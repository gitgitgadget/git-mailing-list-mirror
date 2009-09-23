From: Mark Struberg <struberg@yahoo.de>
Subject: [JGIT PATCH 5/9] mavenized org.spearce.jgit.pgm
Date: Wed, 23 Sep 2009 23:16:06 +0200
Message-ID: <1253740570-10718-5-git-send-email-struberg@yahoo.de>
References: <1253740570-10718-1-git-send-email-struberg@yahoo.de>
 <1253740570-10718-2-git-send-email-struberg@yahoo.de>
 <1253740570-10718-3-git-send-email-struberg@yahoo.de>
 <1253740570-10718-4-git-send-email-struberg@yahoo.de>
Cc: Mark Struberg <struberg@yahoo.de>
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Sep 23 23:16:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqZCL-0004af-CT
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 23:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbZIWVQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 17:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbZIWVQF
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 17:16:05 -0400
Received: from n7.bullet.re3.yahoo.com ([68.142.237.92]:24670 "HELO
	n7.bullet.re3.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752867AbZIWVQA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 17:16:00 -0400
Received: from [68.142.237.87] by n7.bullet.re3.yahoo.com with NNFMP; 23 Sep 2009 21:16:03 -0000
Received: from [69.147.75.182] by t3.bullet.re3.yahoo.com with NNFMP; 23 Sep 2009 21:16:03 -0000
Received: from [127.0.0.1] by omp103.mail.re1.yahoo.com with NNFMP; 23 Sep 2009 21:16:03 -0000
X-Yahoo-Newman-Id: 28231.2822.bm@omp103.mail.re1.yahoo.com
Received: (qmail 22251 invoked from network); 23 Sep 2009 21:16:02 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References;
  b=n0Jamwk8TW5L4DjHobG7DcnWlgrgWOxXIU9ToQD5aDhxT52Jz076O2HgtCgoRAWCIi1dslXxuhi+psDHJDzQVFcrYVkiSZKkmeOyccej0qjIWgUgCOodXRHsZfQ/z636WfwvNTFC7HNSBuaer5rK5LoLMv8/vrhU5UwHYcRlqOc=  ;
Received: from chello062178039060.14.11.vie.surfer.at (struberg@62.178.39.60 with login)
        by smtp103.plus.mail.re1.yahoo.com with SMTP; 23 Sep 2009 14:16:01 -0700 PDT
X-Yahoo-SMTP: 81dhI.iswBBq7boyzRoOX6xuRIe8
X-YMail-OSG: cfcL7GcVM1kJjQC1j3kUApS2PlKo8SEVoEPtx2oUZEHp_oE8EzVOdr_.AWcJiDxslt3QW13RHYIJnykL5EaL4DI8zZrUURmcIEkvN6w04ILjzDaEiKsfxvZ1aBDoZ9zRDyYqJae2kR3vK9zvuX3HKNOGX560DTEbvPXn6oLEGhSuTIQ3pUsuQV4lRL12ShwuQoh.94gXpUJcCin5QwXWZje4ittQ9O.XUS5HzIts2bTqkXGVjkKMaHWgKNdtkC3nGJuSaOhgn.A16GvaU4pWgQ9PItD08WNvgnboo_xueq026icjhzondGuScO4at1A5wS0UD6urYPNRZNOKEM5TyaxIiBKG4ocR.g--
X-Yahoo-Newman-Property: ymail-3
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1253740570-10718-4-git-send-email-struberg@yahoo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129002>

* moved org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ -> org.spearce.jgit.pgm/src/main/java

* all pgm related stuff has been moved to org.speace.jgit.pgm
  This includes jgit.sh and the jgit executable

* create the jgit executable with maven; deleted make_jgit.sh.
  Instead type
  $>mvn clean install
  in the root directory and you'll get org.spearce.jgit.pgm/jgit

Signed-off-by: Mark Struberg <struberg@yahoo.de>
---
 NOTICE                                             |   12 +-
 .../lib => licenses}/args4j.LICENSE.txt            |    0
 make_jgit.sh                                       |  132 -------------
 org.spearce.jgit.pgm/.gitignore                    |    1 -
 jgit.sh => org.spearce.jgit.pgm/jgit.sh            |    7 +-
 org.spearce.jgit.pgm/lib/args4j-2.0.9.jar          |  Bin 40654 -> 0 bytes
 org.spearce.jgit.pgm/lib/args4j-2.0.9.zip          |  Bin 31516 -> 0 bytes
 org.spearce.jgit.pgm/pom.xml                       |  173 +++++++++++------
 .../org/spearce/jgit/pgm/AbstractFetchCommand.java |    0
 .../java}/org/spearce/jgit/pgm/Branch.java         |    0
 .../java}/org/spearce/jgit/pgm/Clone.java          |    0
 .../java}/org/spearce/jgit/pgm/Command.java        |    0
 .../java}/org/spearce/jgit/pgm/CommandCatalog.java |    0
 .../java}/org/spearce/jgit/pgm/CommandRef.java     |    0
 .../java}/org/spearce/jgit/pgm/Daemon.java         |    0
 .../{ => main/java}/org/spearce/jgit/pgm/Die.java  |    0
 .../java}/org/spearce/jgit/pgm/DiffTree.java       |    0
 .../java}/org/spearce/jgit/pgm/Fetch.java          |    0
 .../{ => main/java}/org/spearce/jgit/pgm/Glog.java |    0
 .../java}/org/spearce/jgit/pgm/IndexPack.java      |    0
 .../{ => main/java}/org/spearce/jgit/pgm/Init.java |    0
 .../{ => main/java}/org/spearce/jgit/pgm/Log.java  |    0
 .../java}/org/spearce/jgit/pgm/LsRemote.java       |    0
 .../java}/org/spearce/jgit/pgm/LsTree.java         |    0
 .../{ => main/java}/org/spearce/jgit/pgm/Main.java |    0
 .../java}/org/spearce/jgit/pgm/MergeBase.java      |    0
 .../{ => main/java}/org/spearce/jgit/pgm/Push.java |    0
 .../java}/org/spearce/jgit/pgm/ReceivePack.java    |    0
 .../java}/org/spearce/jgit/pgm/RevList.java        |    0
 .../java}/org/spearce/jgit/pgm/RevParse.java       |    0
 .../org/spearce/jgit/pgm/RevWalkTextBuiltin.java   |    0
 .../{ => main/java}/org/spearce/jgit/pgm/Rm.java   |    0
 .../java}/org/spearce/jgit/pgm/ShowRef.java        |    0
 .../{ => main/java}/org/spearce/jgit/pgm/Tag.java  |    0
 .../java}/org/spearce/jgit/pgm/TextBuiltin.java    |    0
 .../java}/org/spearce/jgit/pgm/UploadPack.java     |    0
 .../java}/org/spearce/jgit/pgm/Version.java        |    0
 .../org/spearce/jgit/pgm/debug/MakeCacheTree.java  |    0
 .../org/spearce/jgit/pgm/debug/ReadDirCache.java   |    0
 .../spearce/jgit/pgm/debug/RebuildCommitGraph.java |    0
 .../org/spearce/jgit/pgm/debug/ShowCacheTree.java  |    0
 .../org/spearce/jgit/pgm/debug/ShowCommands.java   |    0
 .../org/spearce/jgit/pgm/debug/ShowDirCache.java   |    0
 .../org/spearce/jgit/pgm/debug/WriteDirCache.java  |    0
 .../jgit/pgm/opt/AbstractTreeIteratorHandler.java  |    0
 .../org/spearce/jgit/pgm/opt/CmdLineParser.java    |    0
 .../org/spearce/jgit/pgm/opt/ObjectIdHandler.java  |    0
 .../jgit/pgm/opt/PathTreeFilterHandler.java        |    0
 .../org/spearce/jgit/pgm/opt/RefSpecHandler.java   |    0
 .../org/spearce/jgit/pgm/opt/RevCommitHandler.java |    0
 .../org/spearce/jgit/pgm/opt/RevTreeHandler.java   |    0
 .../spearce/jgit/pgm/opt/SubcommandHandler.java    |    0
 .../services/org.spearce.jgit.pgm.TextBuiltin      |    0
 .../org/spearce/jgit/pgm/build/JarLinkUtil.java    |  206 --------------------
 54 files changed, 129 insertions(+), 402 deletions(-)
 rename {org.spearce.jgit.pgm/lib => licenses}/args4j.LICENSE.txt (100%)
 delete mode 100755 make_jgit.sh
 rename jgit.sh => org.spearce.jgit.pgm/jgit.sh (79%)
 delete mode 100644 org.spearce.jgit.pgm/lib/args4j-2.0.9.jar
 delete mode 100644 org.spearce.jgit.pgm/lib/args4j-2.0.9.zip
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/AbstractFetchCommand.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/Branch.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/Clone.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/Command.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/CommandCatalog.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/CommandRef.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/Daemon.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/Die.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/DiffTree.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/Fetch.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/Glog.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/IndexPack.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/Init.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/Log.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/LsRemote.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/LsTree.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/Main.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/MergeBase.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/Push.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/ReceivePack.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/RevList.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/RevParse.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/RevWalkTextBuiltin.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/Rm.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/ShowRef.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/Tag.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/TextBuiltin.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/UploadPack.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/Version.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/debug/MakeCacheTree.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/debug/ReadDirCache.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/debug/RebuildCommitGraph.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/debug/ShowCacheTree.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/debug/ShowCommands.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/debug/ShowDirCache.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/debug/WriteDirCache.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/opt/CmdLineParser.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/opt/ObjectIdHandler.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/opt/PathTreeFilterHandler.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/opt/RefSpecHandler.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/opt/RevCommitHandler.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/opt/RevTreeHandler.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/java}/org/spearce/jgit/pgm/opt/SubcommandHandler.java (100%)
 rename org.spearce.jgit.pgm/src/{ => main/resources}/META-INF/services/org.spearce.jgit.pgm.TextBuiltin (100%)
 delete mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/build/JarLinkUtil.java

diff --git a/NOTICE b/NOTICE
index c19fbc3..ad1d1ee 100644
--- a/NOTICE
+++ b/NOTICE
@@ -1,7 +1,13 @@
 JGIT Java native GIT core library
 
-see LICENSE for mor information
+see LICENSE for more information on JGIT.
 
-This product uses the library jsch-0.1.38.jar as binary, 
-home page of the project is http://www.jcraft.com/jsch/ 
+
+This product uses the library jsch-0.1.38.jar as binary. 
+The home page of the project is http://www.jcraft.com/jsch/ 
+See licenses/JSch.LICENSE.txt for more information.
+
+This product uses the library args4j-2.0.9.jar as binary, 
+The home page of the project is https://args4j.dev.java.net/
+See licenses/args4j.LICENSE.txt for more information.
 
diff --git a/org.spearce.jgit.pgm/lib/args4j.LICENSE.txt b/licenses/args4j.LICENSE.txt
similarity index 100%
rename from org.spearce.jgit.pgm/lib/args4j.LICENSE.txt
rename to licenses/args4j.LICENSE.txt
diff --git a/make_jgit.sh b/make_jgit.sh
deleted file mode 100755
index e3f7ffa..0000000
--- a/make_jgit.sh
+++ /dev/null
@@ -1,132 +0,0 @@
-#!/bin/sh
-
-O_CLI=jgit
-O_JAR=jgit.jar
-O_SRC=jgit_src.zip
-O_DOC=jgit_docs.zip
-
-PLUGINS="
-	org.spearce.jgit
-	org.spearce.jgit.pgm
-"
-JARS="
-	org.spearce.jgit/lib/jsch-0.1.37.jar
-	org.spearce.jgit.pgm/lib/args4j-2.0.9.jar
-"
-
-PSEP=":"
-T=".temp$$.$O_CLI"
-T_MF="$T.MF"
-R=`pwd`
-if [ "$OSTYPE" = "cygwin" ]
-then
-	R=`cygpath -m $R`
-	PSEP=";"
-fi
-if [ "$MSYSTEM" = "MINGW" -o "$MSYSTEM" = "MINGW32" ]
-then
-	PSEP=";"
-	R=`pwd -W`
-fi
-
-if [ -n "$JAVA_HOME" ]
-then
-	PATH=${JAVA_HOME}/bin${PSEP}${PATH}
-fi
-
-cleanup_bin() {
-	rm -f $T $O_CLI+ $O_JAR+ $O_SRC+ $T_MF
-	for p in $PLUGINS
-	do
-		rm -rf $p/bin2
-	done
-	rm -rf docs
-}
-
-die() {
-	cleanup_bin
-	rm -f $O_CLI $O_JAR $O_SRC
-	echo >&2 "$@"
-	exit 1
-}
-
-cleanup_bin
-rm -f $O_CLI $O_JAR $O_SRC $O_DOC
-
-VN=`git describe --abbrev=4 HEAD 2>/dev/null`
-git update-index -q --refresh
-if [ -n "`git diff-index --name-only HEAD --`" ]
-then
-	VN="$VN-dirty"
-fi
-VN=${VN:-untagged}`echo "$VN" | sed -e s/-/./g`
-
-CLASSPATH=
-for j in $JARS
-do
-	if [ -z "$CLASSPATH" ]
-	then
-		CLASSPATH="$R/$j"
-	else
-		CLASSPATH="${CLASSPATH}${PSEP}$R/$j"
-	fi
-done
-export CLASSPATH
-
-for p in $PLUGINS
-do
-	echo "Entering $p ..."
-	(cd $p/src &&
-	 mkdir ../bin2 &&
-	 find . -name \*.java -type f |
-	 xargs javac \
-		-source 1.5 \
-		-target 1.5 \
-		-encoding UTF-8 \
-		-g \
-		-d ../bin2) || die "Building $p failed."
-	CLASSPATH="${CLASSPATH}${PSEP}$R/$p/bin2"
-done
-echo
-
-echo "Version $VN" &&
-echo Manifest-Version: 1.0 >$T_MF &&
-echo Implementation-Title: jgit >>$T_MF &&
-echo Implementation-Version: $VN >>$T_MF &&
-
-java org.spearce.jgit.pgm.build.JarLinkUtil \
-	-include org.spearce.jgit/bin2 \
-	-file META-INF/MANIFEST.MF=$T_MF \
-	>$O_JAR+ &&
-mv $O_JAR+ $O_JAR &&
-echo "Created $O_JAR." &&
-
-java org.spearce.jgit.pgm.build.JarLinkUtil \
-	-include org.spearce.jgit/src \
-	-file META-INF/MANIFEST.MF=$T_MF \
-	>$O_SRC+ &&
-mv $O_SRC+ $O_SRC &&
-echo "Created $O_SRC." &&
-
-M_TB=META-INF/services/org.spearce.jgit.pgm.TextBuiltin &&
-sed s/@@use_self@@/1/ jgit.sh >$O_CLI+ &&
-java org.spearce.jgit.pgm.build.JarLinkUtil \
-	`for p in $JARS   ; do printf %s " -include $p"     ;done` \
-	`for p in $PLUGINS; do printf %s " -include $p/bin2";done` \
-	-file $M_TB=org.spearce.jgit.pgm/src/$M_TB \
-	-file META-INF/MANIFEST.MF=$T_MF \
-	>>$O_CLI+ &&
-chmod 555 $O_CLI+ &&
-mv $O_CLI+ $O_CLI &&
-echo "Created $O_CLI." || die "Build failed."
-
-echo "Building Javadocs ..."
-for p in $PLUGINS; do
-	javadoc -quiet -sourcepath "$p/src/" -d "docs/$p/" \
-	`find "$p/src" -name "*.java"`
-done
-
-(cd docs && jar cf "../$O_DOC" .)
-echo "Created $O_DOC."
-
-cleanup_bin
diff --git a/org.spearce.jgit.pgm/.gitignore b/org.spearce.jgit.pgm/.gitignore
index 934e0e0..ea8c4bf 100644
--- a/org.spearce.jgit.pgm/.gitignore
+++ b/org.spearce.jgit.pgm/.gitignore
@@ -1,2 +1 @@
-/bin
 /target
diff --git a/jgit.sh b/org.spearce.jgit.pgm/jgit.sh
similarity index 79%
rename from jgit.sh
rename to org.spearce.jgit.pgm/jgit.sh
index 6b9b224..5e44356 100755
--- a/jgit.sh
+++ b/org.spearce.jgit.pgm/jgit.sh
@@ -7,10 +7,9 @@ then
 	cp=$this_script
 else
 	jgit_home=`dirname $0`
-	cp="$jgit_home/org.spearce.jgit/bin"
-	cp="$cp:$jgit_home/org.spearce.jgit/lib/jsch-0.1.37.jar"
-	cp="$cp:$jgit_home/org.spearce.jgit.pgm/bin"
-	cp="$cp:$jgit_home/org.spearce.jgit.pgm/lib/args4j-2.0.9.jar"
+	cp="$jgit_home/../org.spearce.jgit/target/classes"
+	cp="$cp:$jgit_home/../org.spearce.jgit.pgm/target/classes"
+	cp="$cp:$jgit_home/target/jgit-cli.jar"
 	unset jgit_home
 	java_args=
 fi
diff --git a/org.spearce.jgit.pgm/lib/args4j-2.0.9.jar b/org.spearce.jgit.pgm/lib/args4j-2.0.9.jar
deleted file mode 100644
index a894c6e..0000000
Binary files a/org.spearce.jgit.pgm/lib/args4j-2.0.9.jar and /dev/null differ
diff --git a/org.spearce.jgit.pgm/lib/args4j-2.0.9.zip b/org.spearce.jgit.pgm/lib/args4j-2.0.9.zip
deleted file mode 100644
index eccd663..0000000
Binary files a/org.spearce.jgit.pgm/lib/args4j-2.0.9.zip and /dev/null differ
diff --git a/org.spearce.jgit.pgm/pom.xml b/org.spearce.jgit.pgm/pom.xml
index 9501cb5..ab399e5 100644
--- a/org.spearce.jgit.pgm/pom.xml
+++ b/org.spearce.jgit.pgm/pom.xml
@@ -1,59 +1,120 @@
 <?xml version="1.0" encoding="UTF-8"?>
+<!--
+/*
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+-->
+
 <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
-  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
-  <modelVersion>4.0.0</modelVersion>
-  <parent>
-    <groupId>org.spearce</groupId>
-    <artifactId>jgit-parent</artifactId>
-    <version>0.5.0-SNAPSHOT</version>  
-  </parent>
-  <artifactId>org.spearce.jgit.pgm</artifactId>
-  <name>JGit :: Pgm</name>
-  <dependencies>
-        <dependency>
-            <groupId>org.spearce</groupId>
-            <artifactId>org.spearce.jgit</artifactId>
-            <version>${project.version}</version>
-        </dependency>    
-        <dependency>
-            <groupId>args4j</groupId>
-            <artifactId>args4j</artifactId>
-        </dependency>
-  </dependencies>
-  <build>
-    <sourceDirectory>src</sourceDirectory>
-    <resources>
-      <resource>
-        <directory>src</directory>
-        <includes>
-          <include>**/services/**</include>
-        </includes>
-      </resource>
-    </resources>
-    <plugins>
-      <plugin>
-        <groupId>org.apache.maven.plugins</groupId>
-        <artifactId>maven-shade-plugin</artifactId>
-        <version>1.2</version>
-        <executions>
-          <execution>
-            <phase>package</phase>
-            <goals>
-              <goal>shade</goal>
-            </goals>
-            <configuration>
-              <finalName>jgit-cli</finalName>
-              <createDependencyReducedPom>false</createDependencyReducedPom>
-              <transformers>
-                <transformer implementation="org.apache.maven.plugins.shade.resource.ServicesResourceTransformer"/>              
-                <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
-                  <mainClass>org.spearce.jgit.pgm.Main</mainClass>
-                </transformer>
-              </transformers>
-            </configuration>
-          </execution>
-        </executions>
-      </plugin>
-    </plugins>      
-  </build>
+	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
+	<modelVersion>4.0.0</modelVersion>
+
+	<parent>
+		<groupId>org.spearce</groupId>
+		<artifactId>jgit-parent</artifactId>
+		<version>0.5.0-SNAPSHOT</version>
+	</parent>
+
+	<artifactId>org.spearce.jgit.pgm</artifactId>
+	<name>JGit :: Pgm</name>
+
+	<description>
+	Command line client for the JGit pure Java GIT implementation.
+	This includes the re-packaging of all dependencies into an 'uberjar'
+	</description>
+
+	<dependencies>
+		<dependency>
+			<groupId>org.spearce</groupId>
+			<artifactId>org.spearce.jgit</artifactId>
+			<version>${project.version}</version>
+		</dependency>
+		<dependency>
+			<groupId>args4j</groupId>
+			<artifactId>args4j</artifactId>
+		</dependency>
+	</dependencies>
+
+	<build>
+		<plugins>
+			<plugin>
+				<groupId>org.apache.maven.plugins</groupId>
+				<artifactId>maven-shade-plugin</artifactId>
+				<version>1.2</version>
+				<executions>
+					<execution>
+						<phase>package</phase>
+						<goals>
+							<goal>shade</goal>
+						</goals>
+						<configuration>
+<!-- temporarily DISABLED due to MSHADE-54	<shadedArtifactAttached>true</shadedArtifactAttached>-->
+							<finalName>jgit-cli</finalName>
+							<createDependencyReducedPom>false</createDependencyReducedPom>
+							<transformers>
+								<transformer implementation="org.apache.maven.plugins.shade.resource.ServicesResourceTransformer" />
+								<transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
+									<mainClass>org.spearce.jgit.pgm.Main</mainClass>
+								</transformer>
+							</transformers>
+						</configuration>
+					</execution>
+				</executions>
+			</plugin>
+			<plugin>
+				<groupId>org.apache.maven.plugins</groupId>
+				<artifactId>maven-antrun-plugin</artifactId>
+				<version>1.3</version>
+				<executions>
+					<execution>
+						<id>create_jgit</id>
+						<phase>package</phase>
+						<configuration>
+							<tasks>
+								<concat destfile="${basedir}/jgit" force="no">
+									<fileset file="${basedir}/jgit.sh" />
+									<fileset file="${basedir}/target/jgit-cli.jar" />
+								</concat>
+								<chmod file="${basedir}/jgit" perm="a+x"/>
+							</tasks>
+						</configuration>
+						<goals>
+							<goal>run</goal>
+						</goals>
+					</execution>
+				</executions>
+			</plugin>
+		</plugins>
+	</build>
 </project>
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/AbstractFetchCommand.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/AbstractFetchCommand.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/AbstractFetchCommand.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/AbstractFetchCommand.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Branch.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Branch.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Clone.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Clone.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Clone.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Clone.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Command.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Command.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Command.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Command.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandCatalog.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/CommandCatalog.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandCatalog.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/CommandCatalog.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandRef.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/CommandRef.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/CommandRef.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/CommandRef.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Daemon.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Daemon.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Die.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Die.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Die.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Die.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/DiffTree.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/DiffTree.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/DiffTree.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/DiffTree.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Fetch.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Fetch.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Glog.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Glog.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Glog.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Glog.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/IndexPack.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/IndexPack.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/IndexPack.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/IndexPack.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Init.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Init.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Init.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Init.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Log.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Log.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsRemote.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/LsRemote.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsRemote.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/LsRemote.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsTree.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/LsTree.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsTree.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/LsTree.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Main.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Main.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Main.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/MergeBase.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/MergeBase.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/MergeBase.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/MergeBase.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Push.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Push.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ReceivePack.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/ReceivePack.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ReceivePack.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/ReceivePack.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevList.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/RevList.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevList.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/RevList.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevParse.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/RevParse.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevParse.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/RevParse.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/RevWalkTextBuiltin.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/RevWalkTextBuiltin.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Rm.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Rm.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Rm.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Rm.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ShowRef.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/ShowRef.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/ShowRef.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/ShowRef.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Tag.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Tag.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Tag.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/TextBuiltin.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/TextBuiltin.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/UploadPack.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/UploadPack.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/UploadPack.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/UploadPack.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Version.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Version.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Version.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/Version.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/MakeCacheTree.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/debug/MakeCacheTree.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/MakeCacheTree.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/debug/MakeCacheTree.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ReadDirCache.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/debug/ReadDirCache.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ReadDirCache.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/debug/ReadDirCache.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/RebuildCommitGraph.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/debug/RebuildCommitGraph.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/RebuildCommitGraph.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/debug/RebuildCommitGraph.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowCacheTree.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/debug/ShowCacheTree.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowCacheTree.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/debug/ShowCacheTree.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowCommands.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/debug/ShowCommands.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowCommands.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/debug/ShowCommands.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowDirCache.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/debug/ShowDirCache.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/ShowDirCache.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/debug/ShowDirCache.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/WriteDirCache.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/debug/WriteDirCache.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/debug/WriteDirCache.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/debug/WriteDirCache.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/CmdLineParser.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/opt/CmdLineParser.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/CmdLineParser.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/opt/CmdLineParser.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/ObjectIdHandler.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/opt/ObjectIdHandler.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/ObjectIdHandler.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/opt/ObjectIdHandler.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/PathTreeFilterHandler.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/opt/PathTreeFilterHandler.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/PathTreeFilterHandler.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/opt/PathTreeFilterHandler.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RefSpecHandler.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/opt/RefSpecHandler.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RefSpecHandler.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/opt/RefSpecHandler.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevCommitHandler.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/opt/RevCommitHandler.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevCommitHandler.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/opt/RevCommitHandler.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevTreeHandler.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/opt/RevTreeHandler.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevTreeHandler.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/opt/RevTreeHandler.java
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/SubcommandHandler.java b/org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/opt/SubcommandHandler.java
similarity index 100%
rename from org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/SubcommandHandler.java
rename to org.spearce.jgit.pgm/src/main/java/org/spearce/jgit/pgm/opt/SubcommandHandler.java
diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/main/resources/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
similarity index 100%
rename from org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
rename to org.spearce.jgit.pgm/src/main/resources/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/build/JarLinkUtil.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/build/JarLinkUtil.java
deleted file mode 100644
index 929ee55..0000000
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/build/JarLinkUtil.java
+++ /dev/null
@@ -1,206 +0,0 @@
-/*
- * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
- *
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or
- * without modification, are permitted provided that the following
- * conditions are met:
- *
- * - Redistributions of source code must retain the above copyright
- *   notice, this list of conditions and the following disclaimer.
- *
- * - Redistributions in binary form must reproduce the above
- *   copyright notice, this list of conditions and the following
- *   disclaimer in the documentation and/or other materials provided
- *   with the distribution.
- *
- * - Neither the name of the Git Development Community nor the
- *   names of its contributors may be used to endorse or promote
- *   products derived from this software without specific prior
- *   written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
- * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
- * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
- * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-package org.spearce.jgit.pgm.build;
-
-import java.io.File;
-import java.io.FileInputStream;
-import java.io.IOException;
-import java.io.InputStream;
-import java.util.ArrayList;
-import java.util.Enumeration;
-import java.util.HashMap;
-import java.util.List;
-import java.util.Map;
-import java.util.zip.ZipEntry;
-import java.util.zip.ZipFile;
-import java.util.zip.ZipOutputStream;
-
-import org.kohsuke.args4j.CmdLineException;
-import org.kohsuke.args4j.CmdLineParser;
-import org.kohsuke.args4j.Option;
-import org.kohsuke.args4j.spi.MapOptionHandler;
-
-/**
- * Combines multiple JAR and directory sources into a single JAR file.
- * <p>
- * This is a crude command line utility to combine multiple JAR files into a
- * single JAR file, without first needing to unpack the individual JARs.
- * <p>
- * The output ZIP stream is sent to standard out and can be redirected onto the
- * end of a shell script which starts the JRE.
- */
-public class JarLinkUtil {
-	/**
-	 * Combine multiple JARs.
-	 *
-	 * @param argv
-	 *            the command line arguments indicating the files to pack.
-	 * @throws IOException
-	 *             a source file could not be read.
-	 */
-	public static void main(final String[] argv) throws IOException {
-		final JarLinkUtil util = new JarLinkUtil();
-		final CmdLineParser clp = new CmdLineParser(util);
-		try {
-			clp.parseArgument(argv);
-		} catch (CmdLineException e) {
-			clp.printSingleLineUsage(System.err);
-			System.exit(1);
-		}
-		util.run();
-	}
-
-	@Option(name = "-include", required = true)
-	private List<File> includes = new ArrayList<File>();
-
-	@Option(name = "-file", handler = MapOptionHandler.class)
-	private Map<String, String> files = new HashMap<String, String>();
-
-	private final Map<String, File> chosenSources = new HashMap<String, File>();
-
-	private long creationTime;
-
-	private ZipOutputStream zos;
-
-	private JarLinkUtil() {
-		// Command line utility only.
-	}
-
-	private void run() throws IOException {
-		for (final File src : includes) {
-			if (src.isFile())
-				scanJar(src);
-			else
-				scanDirectory(src, src, "");
-		}
-		for (final Map.Entry<String, String> e : files.entrySet())
-			chosenSources.put(e.getKey(), new File(e.getValue()));
-
-		creationTime = System.currentTimeMillis();
-		zos = new ZipOutputStream(System.out);
-		zos.setLevel(9);
-
-		for (final File src : includes) {
-			if (src.isFile())
-				appendJar(src);
-			else
-				appendDirectory(src, src, "");
-		}
-		for (final String name : files.keySet())
-			appendFile(chosenSources.get(name), name);
-
-		zos.close();
-	}
-
-	private void scanJar(final File jarPath) throws IOException {
-		final ZipFile zf = new ZipFile(jarPath);
-		final Enumeration<? extends ZipEntry> e = zf.entries();
-		while (e.hasMoreElements())
-			chosenSources.put(e.nextElement().getName(), jarPath);
-		zf.close();
-	}
-
-	private void scanDirectory(final File rootPath, final File dirPath,
-			final String pfx) throws IOException {
-		final File[] entries = dirPath.listFiles();
-		if (entries == null)
-			return;
-		for (final File e : entries) {
-			if (e.getName().equals(".") || e.getName().equals(".."))
-				continue;
-
-			if (e.isDirectory())
-				scanDirectory(rootPath, e, pfx + e.getName() + "/");
-			else
-				chosenSources.put(pfx + e.getName(), rootPath);
-		}
-	}
-
-	private void appendJar(final File jarPath) throws IOException {
-		final ZipFile zf = new ZipFile(jarPath);
-		final Enumeration<? extends ZipEntry> e = zf.entries();
-		while (e.hasMoreElements()) {
-			final ZipEntry ze = e.nextElement();
-			final String name = ze.getName();
-			if (chosenSources.get(name) == jarPath)
-				appendEntry(name, ze.getSize(), ze.getTime(), zf
-						.getInputStream(ze));
-		}
-		zf.close();
-	}
-
-	private void appendDirectory(final File rootDir, final File dirPath,
-			final String pfx) throws IOException {
-		final File[] entries = dirPath.listFiles();
-		if (entries == null)
-			return;
-		for (final File e : entries) {
-			if (e.getName().equals(".") || e.getName().equals(".."))
-				continue;
-
-			if (e.isDirectory())
-				appendDirectory(rootDir, e, pfx + e.getName() + "/");
-			else if (chosenSources.get(pfx + e.getName()) == rootDir)
-				appendFile(e, pfx + e.getName());
-		}
-	}
-
-	private void appendFile(final File path, final String name)
-			throws IOException {
-		final long len = path.length();
-		final InputStream is = new FileInputStream(path);
-		appendEntry(name, len, creationTime, is);
-	}
-
-	private void appendEntry(final String name, final long len,
-			final long time, final InputStream is) throws IOException {
-		final ZipEntry ze = new ZipEntry(name);
-		ze.setSize(len);
-		ze.setTime(time);
-		zos.putNextEntry(ze);
-		try {
-			final byte[] buf = new byte[4096];
-			int n;
-			while ((n = is.read(buf)) >= 0)
-				zos.write(buf, 0, n);
-		} finally {
-			is.close();
-		}
-		zos.closeEntry();
-	}
-}
-- 
1.6.2.5
