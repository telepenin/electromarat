#!/usr/bin/env sh

# abort on errors
set -exo pipefail

# build
HUGO_ENV=production hugo -v -d public -s src

# navigate into the build output directory
cd src/public

# if you are deploying to a custom domain
echo 'dev.electromarat.ru' > CNAME

git config --global user.email "telepenin.nikolay@gmail.com"
git config --global user.name "circle-ci"

git init
git add -A
git commit -m 'deploy [skip ci]'
git push -f git@github.com:telepenin/electromarat.git master:gh-pages

# push onto separate repo
echo 'dev.elektromarat.ru' > CNAME
git commit -am 'deploy [skip ci]'
git remote remove origin
git remote add origin git@github.com:telepenin/elektromarat.git
git push -f git@github.com:telepenin/elektromarat.git master:gh-pages

cd -