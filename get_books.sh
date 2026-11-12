#!/bin/bash
set -euo pipefail

BUCKET="$1"
BOOK_DIR="$2"

# dest dir
mkdir -p "$BOOK_DIR"

# jsut download .txt from the s3
aws s3 cp "s3://${BUCKET}/" "$BOOK_DIR/" \
    --recursive \
    --exclude "*" \
    --include "*.txt"

# abs path convert
BOOK_DIR_ABS=$(realpath "$BOOK_DIR")

# make book list + header
echo "File path" > book_list.txt

# Find sort titles
find "$BOOK_DIR_ABS" -type f -name "*.txt" | sort >> book_list.txt

# cOunt books num
BOOK_COUNT=$(($(wc -l < book_list.txt) - 1))

echo "Wrote $BOOK_COUNT book files to book_list.txt"
