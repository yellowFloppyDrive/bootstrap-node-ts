project=$1

if [ -z "$1" ]
then
	echo "Please provide a project name. Here is an example:"
	echo "./bootstrap-node-ts.sh [project-name]"
	exit 1
fi

mkdir $project

cd $project

mkdir src
touch src/main.ts

cat << EOF > .gitignore
node_modules
build
EOF

cat << EOF > package.json
{
  "name": "$project",
  "version": "1.0.0",
  "main": "src/main.ts",
  "scripts": {
    "dev": "npx nodemon",
    "build": "rimraf ./build && tsc",
    "start": "npm run build && node build/main.js",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "description": ""
}
EOF

npm i -D typescript @types/node ts-node nodemon rimraf

cat << EOF > tsconfig.json
{
  "compilerOptions": {
    "target": "es5",                          
    "module": "commonjs",                    
    "lib": ["es6"],                     
    "allowJs": true,
    "outDir": "build",                          
    "rootDir": "src",
    "strict": true,         
    "noImplicitAny": true,
    "esModuleInterop": true,
    "resolveJsonModule": true
  }
}
EOF

cat << EOF > nodemon.json
{
  "watch": ["src"],
  "ext": ".ts,.js",
  "ignore": [],
  "exec": "npx ts-node ./src/main.ts"
}
EOF

