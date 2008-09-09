From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 4/6] tests: use "git foo" without dash in strings
Date: Wed, 10 Sep 2008 06:25:27 +0900
Message-ID: <20080910062527.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:28:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdAki-0007Te-H0
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbYIIV0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 17:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753962AbYIIV0b
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:26:31 -0400
Received: from karen.lavabit.com ([72.249.41.33]:33447 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200AbYIIV0a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:26:30 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 6D61AC89DC;
	Tue,  9 Sep 2008 16:26:20 -0500 (CDT)
Received: from 9677.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id MWXMPMI8DLCI; Tue, 09 Sep 2008 16:26:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=uiVYIR6OBMXoJkwCSUSI/PYI+HSZo6bl0AjjbT63MH63qACsYDcreUG2F5Y4TMqRw6Uf0/9TMJdhU76w3Ec+6qhteFJhmEeZUlbFfN2JX9xl930CN4I3BKmySynfMljGyHZeVd6Ft4O0L2XdDxGJP5mdpk0mK8hTY8RF9ynWO6I=;
  h=From:To:Cc:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95439>

This changes "git-foo" to "git foo" when message strings in tests
name git subcommands.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 t/t7606-merge-custom.sh                     |    2 +-
 t/t9100-git-svn-basic.sh                    |    4 ++--
 t/t9101-git-svn-props.sh                    |    4 ++--
 t/t9102-git-svn-deep-rmdir.sh               |    4 ++--
 t/t9112-git-svn-md5less-file.sh             |    2 +-
 t/t9122-git-svn-author.sh                   |    2 +-
 t/t9123-git-svn-rebuild-with-rewriteroot.sh |    2 +-
 t/t9124-git-svn-dcommit-auto-props.sh       |    4 ++--
 t/t9600-cvsimport.sh                        |    2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t7606-merge-custom.sh b/t/t7606-merge-custom.sh
index de9b6ed..52a451d 100755
--- a/t/t7606-merge-custom.sh
+++ b/t/t7606-merge-custom.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git-merge
+test_description='git merge
 
 Testing a custom strategy.'
 
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 5ade88d..9b238c3 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -20,7 +20,7 @@ esac
 say 'define NO_SVN_TESTS to skip git svn tests'
 
 test_expect_success \
-    'initialize git-svn' '
+    'initialize git svn' '
 	mkdir import &&
 	cd import &&
 	echo foo > foo &&
@@ -31,7 +31,7 @@ test_expect_success \
 	echo "zzz" > bar/zzz &&
 	echo "#!/bin/sh" > exec.sh &&
 	chmod +x exec.sh &&
-	svn import -m "import for git-svn" . "$svnrepo" >/dev/null &&
+	svn import -m "import for git svn" . "$svnrepo" >/dev/null &&
 	cd .. &&
 	rm -rf import &&
 	git svn init "$svnrepo"'
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 0d48b26..7732dea 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -48,7 +48,7 @@ EOF
 	printf "\r\n" > empty_crlf
 	a_empty_crlf=`git-hash-object -w empty_crlf`
 
-	svn import --no-auto-props -m 'import for git-svn' . "$svnrepo" >/dev/null
+	svn import --no-auto-props -m 'import for git svn' . "$svnrepo" >/dev/null
 cd ..
 
 rm -rf import
@@ -66,7 +66,7 @@ test_expect_success 'setup some commits to svn' \
 		svn commit -m "Propset Id" &&
 	cd ..'
 
-test_expect_success 'initialize git-svn' 'git svn init "$svnrepo"'
+test_expect_success 'initialize git svn' 'git svn init "$svnrepo"'
 test_expect_success 'fetch revisions from svn' 'git svn fetch'
 
 name='test svn:keywords ignoring'
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
index ea5a385..e223218 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -9,11 +9,11 @@ test_expect_success 'initialize repo' '
 	mkdir -p deeply/nested/directory/number/2 &&
 	echo foo > deeply/nested/directory/number/1/file &&
 	echo foo > deeply/nested/directory/number/2/another &&
-	svn import -m "import for git-svn" . "$svnrepo" &&
+	svn import -m "import for git svn" . "$svnrepo" &&
 	cd ..
 	'
 
-test_expect_success 'mirror via git-svn' '
+test_expect_success 'mirror via git svn' '
 	git svn init "$svnrepo" &&
 	git svn fetch &&
 	git checkout -f -b test-rmdir ${remotes_git_svn}
diff --git a/t/t9112-git-svn-md5less-file.sh b/t/t9112-git-svn-md5less-file.sh
index 91b88cf..a61d671 100755
--- a/t/t9112-git-svn-md5less-file.sh
+++ b/t/t9112-git-svn-md5less-file.sh
@@ -42,6 +42,6 @@ EOF
 
 test_expect_success 'load svn dumpfile' 'svnadmin load "$rawsvnrepo" < dumpfile.svn'
 
-test_expect_success 'initialize git-svn' 'git svn init "$svnrepo"'
+test_expect_success 'initialize git svn' 'git svn init "$svnrepo"'
 test_expect_success 'fetch revisions from svn' 'git svn fetch'
 test_done
diff --git a/t/t9122-git-svn-author.sh b/t/t9122-git-svn-author.sh
index 1190576..1b1cf47 100755
--- a/t/t9122-git-svn-author.sh
+++ b/t/t9122-git-svn-author.sh
@@ -13,7 +13,7 @@ test_expect_success 'setup svn repository' '
 	)
 '
 
-test_expect_success 'interact with it via git-svn' '
+test_expect_success 'interact with it via git svn' '
 	mkdir work.git &&
 	(
 		cd work.git &&
diff --git a/t/t9123-git-svn-rebuild-with-rewriteroot.sh b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
index ddb1a48..cf04152 100755
--- a/t/t9123-git-svn-rebuild-with-rewriteroot.sh
+++ b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
@@ -10,7 +10,7 @@ test_description='git svn respects rewriteRoot during rebuild'
 mkdir import
 cd import
 	touch foo
-	svn import -m 'import for git-svn' . "$svnrepo" >/dev/null
+	svn import -m 'import for git svn' . "$svnrepo" >/dev/null
 cd ..
 rm -rf import
 
diff --git a/t/t9124-git-svn-dcommit-auto-props.sh b/t/t9124-git-svn-dcommit-auto-props.sh
index 0d7e7b2..263dbf5 100755
--- a/t/t9124-git-svn-dcommit-auto-props.sh
+++ b/t/t9124-git-svn-dcommit-auto-props.sh
@@ -16,12 +16,12 @@ enable-auto-props=$1
 EOF
 }
 
-test_expect_success 'initialize git-svn' '
+test_expect_success 'initialize git svn' '
 	mkdir import &&
 	(
 		cd import &&
 		echo foo >foo &&
-		svn import -m "import for git-svn" . "$svnrepo"
+		svn import -m "import for git svn" . "$svnrepo"
 	) &&
 	rm -rf import &&
 	git svn init "$svnrepo"
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 0d7786a..d2379e7 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git-cvsimport basic tests'
+test_description='git cvsimport basic tests'
 . ./test-lib.sh
 
 CVSROOT=$(pwd)/cvsroot
-- 
1.6.0.1


-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
