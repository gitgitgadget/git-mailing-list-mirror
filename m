From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 4/4] tests: use "git xyzzy" form (t7200 - t9001)
Date: Wed, 03 Sep 2008 17:59:33 +0900
Message-ID: <20080903175933.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 11:01:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaoF3-00011w-SM
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 11:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbYICJAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 05:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbYICJAX
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 05:00:23 -0400
Received: from karen.lavabit.com ([72.249.41.33]:36041 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbYICJAU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 05:00:20 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 6423EC88F1;
	Wed,  3 Sep 2008 04:00:10 -0500 (CDT)
Received: from 8115.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id BKRE9PMXQ5B6; Wed, 03 Sep 2008 04:00:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=U51V6+/hPzIXlsymyGBGpw4IbC2c9CI83gZm/aY/YxGd7auCF3AqixaXu5aq1YB0y31Iz53fqMtT+su3Yi4uDCnMpCs5g58q8r8wdkIFuS0iyAenmWJkJO2j5FeqtZKwzG6nnxn2wiwMKgnq0fme1TP3XBT5HrBApgtBL4Gjl54=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94769>

Converts tests between t7201-t9001.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 t/t7201-co.sh                        |    2 +-
 t/t7300-clean.sh                     |   72 +++++++++++++++++-----------------
 t/t7400-submodule-basic.sh           |   48 +++++++++++-----------
 t/t7401-submodule-summary.sh         |    2 +-
 t/t7500-commit.sh                    |    2 +-
 t/t7501-commit.sh                    |   48 +++++++++++-----------
 t/t7502-status.sh                    |    2 +-
 t/t7505-prepare-commit-msg-hook.sh   |    2 +-
 t/t7506-status-submodule.sh          |    2 +-
 t/t7600-merge.sh                     |    2 +-
 t/t7601-merge-pull-config.sh         |    2 +-
 t/t7602-merge-octopus-many.sh        |    2 +-
 t/t7603-merge-reduce-heads.sh        |    2 +-
 t/t7604-merge-custom-message.sh      |    2 +-
 t/t7605-merge-resolve.sh             |    2 +-
 t/t7610-mergetool.sh                 |    2 +-
 t/t7701-repack-unpack-unreachable.sh |    2 +-
 t/t9001-send-email.sh                |    2 +-
 18 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 1dff84d..543b1c2 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -5,3 +5,3 @@
 
-test_description='git-checkout tests.
+test_description='git checkout tests.
 
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 2b51c0d..1636fac 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -5,3 +5,3 @@
 
-test_description='git-clean basic tests'
+test_description='git clean basic tests'
 
@@ -18,3 +18,3 @@ test_expect_success 'setup' '
 	git add . &&
-	git-commit -m setup &&
+	git commit -m setup &&
 	touch src/part2.c README &&
@@ -24,3 +24,3 @@ test_expect_success 'setup' '
 
-test_expect_success 'git-clean' '
+test_expect_success 'git clean' '
 
@@ -28,3 +28,3 @@ test_expect_success 'git-clean' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
-	git-clean &&
+	git clean &&
 	test -f Makefile &&
@@ -41,3 +41,3 @@ test_expect_success 'git-clean' '
 
-test_expect_success 'git-clean src/' '
+test_expect_success 'git clean src/' '
 
@@ -45,3 +45,3 @@ test_expect_success 'git-clean src/' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
-	git-clean src/ &&
+	git clean src/ &&
 	test -f Makefile &&
@@ -58,3 +58,3 @@ test_expect_success 'git-clean src/' '
 
-test_expect_success 'git-clean src/ src/' '
+test_expect_success 'git clean src/ src/' '
 
@@ -62,3 +62,3 @@ test_expect_success 'git-clean src/ src/' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
-	git-clean src/ src/ &&
+	git clean src/ src/ &&
 	test -f Makefile &&
@@ -75,3 +75,3 @@ test_expect_success 'git-clean src/ src/' '
 
-test_expect_success 'git-clean with prefix' '
+test_expect_success 'git clean with prefix' '
 
@@ -79,3 +79,3 @@ test_expect_success 'git-clean with prefix' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so src/test/1.c &&
-	(cd src/ && git-clean) &&
+	(cd src/ && git clean) &&
 	test -f Makefile &&
@@ -93,3 +93,3 @@ test_expect_success 'git-clean with prefix' '
 
-test_expect_success 'git-clean with relative prefix' '
+test_expect_success 'git clean with relative prefix' '
 
@@ -108,3 +108,3 @@ test_expect_success 'git-clean with relative prefix' '
 
-test_expect_success 'git-clean with absolute path' '
+test_expect_success 'git clean with absolute path' '
 
@@ -123,3 +123,3 @@ test_expect_success 'git-clean with absolute path' '
 
-test_expect_success 'git-clean with out of work tree relative path' '
+test_expect_success 'git clean with out of work tree relative path' '
 
@@ -133,3 +133,3 @@ test_expect_success 'git-clean with out of work tree relative path' '
 
-test_expect_success 'git-clean with out of work tree absolute path' '
+test_expect_success 'git clean with out of work tree absolute path' '
 
@@ -144,3 +144,3 @@ test_expect_success 'git-clean with out of work tree absolute path' '
 
-test_expect_success 'git-clean -d with prefix and path' '
+test_expect_success 'git clean -d with prefix and path' '
 
@@ -148,3 +148,3 @@ test_expect_success 'git-clean -d with prefix and path' '
 	touch a.out src/part3.c src/feature/file.c docs/manual.txt obj.o build/lib.so &&
-	(cd src/ && git-clean -d feature/) &&
+	(cd src/ && git clean -d feature/) &&
 	test -f Makefile &&
@@ -162,3 +162,3 @@ test_expect_success 'git-clean -d with prefix and path' '
 
-test_expect_success 'git-clean symbolic link' '
+test_expect_success 'git clean symbolic link' '
 
@@ -167,3 +167,3 @@ test_expect_success 'git-clean symbolic link' '
 	ln -s docs/manual.txt src/part4.c
-	git-clean &&
+	git clean &&
 	test -f Makefile &&
@@ -181,6 +181,6 @@ test_expect_success 'git-clean symbolic link' '
 
-test_expect_success 'git-clean with wildcard' '
+test_expect_success 'git clean with wildcard' '
 
 	touch a.clean b.clean other.c &&
-	git-clean "*.clean" &&
+	git clean "*.clean" &&
 	test -f Makefile &&
@@ -195,3 +195,3 @@ test_expect_success 'git-clean with wildcard' '
 
-test_expect_success 'git-clean -n' '
+test_expect_success 'git clean -n' '
 
@@ -199,3 +199,3 @@ test_expect_success 'git-clean -n' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
-	git-clean -n &&
+	git clean -n &&
 	test -f Makefile &&
@@ -212,3 +212,3 @@ test_expect_success 'git-clean -n' '
 
-test_expect_success 'git-clean -d' '
+test_expect_success 'git clean -d' '
 
@@ -216,3 +216,3 @@ test_expect_success 'git-clean -d' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
-	git-clean -d &&
+	git clean -d &&
 	test -f Makefile &&
@@ -229,3 +229,3 @@ test_expect_success 'git-clean -d' '
 
-test_expect_success 'git-clean -d src/ examples/' '
+test_expect_success 'git clean -d src/ examples/' '
 
@@ -233,3 +233,3 @@ test_expect_success 'git-clean -d src/ examples/' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so examples/1.c &&
-	git-clean -d src/ examples/ &&
+	git clean -d src/ examples/ &&
 	test -f Makefile &&
@@ -247,3 +247,3 @@ test_expect_success 'git-clean -d src/ examples/' '
 
-test_expect_success 'git-clean -x' '
+test_expect_success 'git clean -x' '
 
@@ -251,3 +251,3 @@ test_expect_success 'git-clean -x' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
-	git-clean -x &&
+	git clean -x &&
 	test -f Makefile &&
@@ -264,3 +264,3 @@ test_expect_success 'git-clean -x' '
 
-test_expect_success 'git-clean -d -x' '
+test_expect_success 'git clean -d -x' '
 
@@ -268,3 +268,3 @@ test_expect_success 'git-clean -d -x' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
-	git-clean -d -x &&
+	git clean -d -x &&
 	test -f Makefile &&
@@ -281,3 +281,3 @@ test_expect_success 'git-clean -d -x' '
 
-test_expect_success 'git-clean -X' '
+test_expect_success 'git clean -X' '
 
@@ -285,3 +285,3 @@ test_expect_success 'git-clean -X' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
-	git-clean -X &&
+	git clean -X &&
 	test -f Makefile &&
@@ -298,3 +298,3 @@ test_expect_success 'git-clean -X' '
 
-test_expect_success 'git-clean -d -X' '
+test_expect_success 'git clean -d -X' '
 
@@ -302,3 +302,3 @@ test_expect_success 'git-clean -d -X' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
-	git-clean -d -X &&
+	git clean -d -X &&
 	test -f Makefile &&
@@ -333,3 +333,3 @@ test_expect_success 'clean.requireForce and -n' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
-	git-clean -n &&
+	git clean -n &&
 	test -f Makefile &&
@@ -348,3 +348,3 @@ test_expect_success 'clean.requireForce and -f' '
 
-	git-clean -f &&
+	git clean -f &&
 	test -f README &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index cbc0c34..be73f7b 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -8,3 +8,3 @@ test_description='Basic porcelain support for submodules
 This test tries to verify basic sanity of the init, update and status
-subcommands of git-submodule.
+subcommands of git submodule.
 '
@@ -24,4 +24,4 @@ test_expect_success 'Prepare submodule testing' '
 	: > t &&
-	git-add t &&
-	git-commit -m "initial commit" &&
+	git add t &&
+	git commit -m "initial commit" &&
 	git branch initial HEAD &&
@@ -32,4 +32,4 @@ test_expect_success 'Prepare submodule testing' '
 	git add a &&
-	git-commit -m "submodule commit 1" &&
-	git-tag -a -m "rev-1" rev-1 &&
+	git commit -m "submodule commit 1" &&
+	git tag -a -m "rev-1" rev-1 &&
 	rev1=$(git rev-parse HEAD) &&
@@ -44,3 +44,3 @@ test_expect_success 'Prepare submodule testing' '
 	git add a init z &&
-	git-commit -m "super commit 1" &&
+	git commit -m "super commit 1" &&
 	mv init .subrepo &&
@@ -50,3 +50,3 @@ test_expect_success 'Prepare submodule testing' '
 test_expect_success 'status should fail for unmapped paths' '
-	if git-submodule status
+	if git submodule status
 	then
@@ -62,3 +62,3 @@ test_expect_success 'status should fail for unmapped paths' '
 test_expect_success 'status should only print one line' '
-	lines=$(git-submodule status | wc -l) &&
+	lines=$(git submodule status | wc -l) &&
 	test $lines = 1
@@ -67,3 +67,3 @@ test_expect_success 'status should only print one line' '
 test_expect_success 'status should initially be "missing"' '
-	git-submodule status | grep "^-$rev1"
+	git submodule status | grep "^-$rev1"
 '
@@ -71,3 +71,3 @@ test_expect_success 'status should initially be "missing"' '
 test_expect_success 'init should register submodule url in .git/config' '
-	git-submodule init &&
+	git submodule init &&
 	url=$(git config submodule.example.url) &&
@@ -86,3 +86,3 @@ test_expect_success 'update should fail when path is used by a file' '
 	echo "hello" >init &&
-	if git-submodule update
+	if git submodule update
 	then
@@ -102,3 +102,3 @@ test_expect_success 'update should fail when path is used by a nonempty director
 	echo "hello" >init/a &&
-	if git-submodule update
+	if git submodule update
 	then
@@ -118,3 +118,3 @@ test_expect_success 'update should work when path is an empty dir' '
 	mkdir init &&
-	git-submodule update &&
+	git submodule update &&
 	head=$(cd init && git rev-parse HEAD) &&
@@ -132,3 +132,3 @@ test_expect_success 'update should work when path is an empty dir' '
 test_expect_success 'status should be "up-to-date" after update' '
-	git-submodule status | grep "^ $rev1"
+	git submodule status | grep "^ $rev1"
 '
@@ -139,3 +139,3 @@ test_expect_success 'status should be "modified" after submodule commit' '
 	git add b &&
-	git-commit -m "submodule commit 2" &&
+	git commit -m "submodule commit 2" &&
 	rev2=$(git rev-parse HEAD) &&
@@ -147,3 +147,3 @@ test_expect_success 'status should be "modified" after submodule commit' '
 	fi &&
-	git-submodule status | grep "^+$rev2"
+	git submodule status | grep "^+$rev2"
 '
@@ -151,3 +151,3 @@ test_expect_success 'status should be "modified" after submodule commit' '
 test_expect_success 'the --cached sha1 should be rev1' '
-	git-submodule --cached status | grep "^+$rev1"
+	git submodule --cached status | grep "^+$rev1"
 '
@@ -155,3 +155,3 @@ test_expect_success 'the --cached sha1 should be rev1' '
 test_expect_success 'git diff should report the SHA1 of the new submodule commit' '
-	git-diff | grep "^+Subproject commit $rev2"
+	git diff | grep "^+Subproject commit $rev2"
 '
@@ -159,3 +159,3 @@ test_expect_success 'git diff should report the SHA1 of the new submodule commit
 test_expect_success 'update should checkout rev1' '
-	git-submodule update init &&
+	git submodule update init &&
 	head=$(cd init && git rev-parse HEAD) &&
@@ -173,3 +173,3 @@ test_expect_success 'update should checkout rev1' '
 test_expect_success 'status should be "up-to-date" after update' '
-	git-submodule status | grep "^ $rev1"
+	git submodule status | grep "^ $rev1"
 '
@@ -177,4 +177,4 @@ test_expect_success 'status should be "up-to-date" after update' '
 test_expect_success 'checkout superproject with subproject already present' '
-	git-checkout initial &&
-	git-checkout master
+	git checkout initial &&
+	git checkout master
 '
@@ -190,4 +190,4 @@ test_expect_success 'apply submodule diff' '
 	git update-index --add init &&
-	git-commit -m "change init" &&
-	git-format-patch -1 --stdout >P.diff &&
+	git commit -m "change init" &&
+	git format-patch -1 --stdout >P.diff &&
 	git checkout second &&
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index bf12dbd..6149829 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -7,3 +7,3 @@ test_description='Summary support for submodules
 
-This test tries to verify the sanity of summary subcommand of git-submodule.
+This test tries to verify the sanity of summary subcommand of git submodule.
 '
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 7ae0bd0..6e18a96 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -5,3 +5,3 @@
 
-test_description='git-commit
+test_description='git commit
 
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 0edd9dd..469bff8 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -8,3 +8,3 @@
 
-test_description='git-commit'
+test_description='git commit'
 . ./test-lib.sh
@@ -16,4 +16,4 @@ test_expect_success \
 	"echo 'bongo bongo' >file &&
-	 git-add file && \
-	 git-status | grep 'Initial commit'"
+	 git add file && \
+	 git status | grep 'Initial commit'"
 
@@ -21,3 +21,3 @@ test_expect_success \
 	"fail initial amend" \
-	"test_must_fail git-commit --amend"
+	"test_must_fail git commit --amend"
 
@@ -25,3 +25,3 @@ test_expect_success \
 	"initial commit" \
-	"git-commit -m initial"
+	"git commit -m initial"
 
@@ -29,3 +29,3 @@ test_expect_success \
 	"invalid options 1" \
-	"test_must_fail git-commit -m foo -m bar -F file"
+	"test_must_fail git commit -m foo -m bar -F file"
 
@@ -33,3 +33,3 @@ test_expect_success \
 	"invalid options 2" \
-	"test_must_fail git-commit -C HEAD -m illegal"
+	"test_must_fail git commit -C HEAD -m illegal"
 
@@ -38,3 +38,3 @@ test_expect_success \
 	"echo King of the bongo >file &&
-	test_must_fail git-commit -m foo -a file"
+	test_must_fail git commit -m foo -a file"
 
@@ -43,3 +43,3 @@ test_expect_success \
 	"echo bong-o-bong >file &&
-	! (echo 7 | git-commit -m foo --interactive file)"
+	! (echo 7 | git commit -m foo --interactive file)"
 
@@ -47,3 +47,3 @@ test_expect_success \
 	"using invalid commit with -C" \
-	"test_must_fail git-commit -C bogus"
+	"test_must_fail git commit -C bogus"
 
@@ -51,3 +51,3 @@ test_expect_success \
 	"testing nothing to commit" \
-	"test_must_fail git-commit -m initial"
+	"test_must_fail git commit -m initial"
 
@@ -56,3 +56,3 @@ test_expect_success \
 	"echo 'bongo bongo bongo' >file \
-	 git-commit -m next -a"
+	 git commit -m next -a"
 
@@ -61,3 +61,3 @@ test_expect_success \
 	"echo 'more bongo: bongo bongo bongo bongo' >file && \
-	 test_must_fail git-commit -F gah -a"
+	 test_must_fail git commit -F gah -a"
 
@@ -72,3 +72,3 @@ test_expect_success \
 	"empty commit message" \
-	"test_must_fail git-commit -F msg -a"
+	"test_must_fail git commit -F msg -a"
 
@@ -77,3 +77,3 @@ test_expect_success \
 	"echo 'this is the commit message, coming from a file' >msg && \
-	 git-commit -F msg -a"
+	 git commit -F msg -a"
 
@@ -88,3 +88,3 @@ test_expect_success \
 	"amend commit" \
-	"VISUAL=./editor git-commit --amend"
+	"VISUAL=./editor git commit --amend"
 
@@ -93,3 +93,3 @@ test_expect_success \
 	"echo 'enough with the bongos' >file && \
-	 test_must_fail git-commit -F msg -m amending ."
+	 test_must_fail git commit -F msg -m amending ."
 
@@ -97,3 +97,3 @@ test_expect_success \
 	"using message from other commit" \
-	"git-commit -C HEAD^ ."
+	"git commit -C HEAD^ ."
 
@@ -109,3 +109,3 @@ test_expect_success \
 	"echo 'hula hula' >file && \
-	 VISUAL=./editor git-commit -c HEAD^ -a"
+	 VISUAL=./editor git commit -c HEAD^ -a"
 
@@ -114,3 +114,3 @@ test_expect_success \
 	"echo 'silly new contents' >file && \
-	 echo commit message from stdin | git-commit -F - -a"
+	 echo commit message from stdin | git commit -F - -a"
 
@@ -119,3 +119,3 @@ test_expect_success \
 	"echo 'gak' >file && \
-	 git-commit -m 'author' --author 'Rubber Duck <rduck@convoy.org>' -a"
+	 git commit -m 'author' --author 'Rubber Duck <rduck@convoy.org>' -a"
 
@@ -123,3 +123,3 @@ test_expect_success \
 	"interactive add" \
-	"echo 7 | git-commit --interactive | grep 'What now'"
+	"echo 7 | git commit --interactive | grep 'What now'"
 
@@ -127,3 +127,3 @@ test_expect_success \
 	"showing committed revisions" \
-	"git-rev-list HEAD >current"
+	"git rev-list HEAD >current"
 
@@ -142,3 +142,3 @@ EOF
 test_expect_success \
-    'validate git-rev-list output.' \
+    'validate git rev-list output.' \
     'diff current expected'
diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index 38a48b5..c8e4c2e 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -5,3 +5,3 @@
 
-test_description='git-status'
+test_description='git status'
 
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index cd6c7c8..ff18962 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -34,3 +34,3 @@ cat >> "$HOOK" <<'EOF'
 if test "$2" = commit; then
-  source=$(git-rev-parse "$3")
+  source=$(git rev-parse "$3")
 else
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index a75130c..d9a08aa 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -2,3 +2,3 @@
 
-test_description='git-status for submodule'
+test_description='git status for submodule'
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 6a2b125..9516f54 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -5,3 +5,3 @@
 
-test_description='git-merge
+test_description='git merge
 
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 55aa6b5..7ba94ea 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -2,3 +2,3 @@
 
-test_description='git-merge
+test_description='git merge
 
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index fcb8285..01e5415 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -2,3 +2,3 @@
 
-test_description='git-merge
+test_description='git merge
 
diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads.sh
index 17b19dc..b47b7b9 100755
--- a/t/t7603-merge-reduce-heads.sh
+++ b/t/t7603-merge-reduce-heads.sh
@@ -2,3 +2,3 @@
 
-test_description='git-merge
+test_description='git merge
 
diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index 6081677..de977c5 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -2,3 +2,3 @@
 
-test_description='git-merge
+test_description='git merge
 
diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
index f1f86dd..0cb9d11 100755
--- a/t/t7605-merge-resolve.sh
+++ b/t/t7605-merge-resolve.sh
@@ -2,3 +2,3 @@
 
-test_description='git-merge
+test_description='git merge
 
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 9285071..09fa5f1 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -5,3 +5,3 @@
 
-test_description='git-mergetool
+test_description='git mergetool
 
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 31c340f..531dac0 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -2,3 +2,3 @@
 
-test_description='git-repack works correctly'
+test_description='git repack works correctly'
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1c857cf..d098a01 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2,3 +2,3 @@
 
-test_description='git-send-email'
+test_description='git send-email'
 . ./test-lib.sh
-- 
1.6.0.1

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
