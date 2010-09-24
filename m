From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 16/16] Add missing &&'s throughout the testsuite
Date: Fri, 24 Sep 2010 16:22:56 -0600
Message-ID: <1285366976-22216-17-git-send-email-newren@gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:22:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGer-0000n6-MU
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758300Ab0IXWV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:58 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45492 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758293Ab0IXWVw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:52 -0400
Received: by mail-qy0-f181.google.com with SMTP id 33so4608692qyk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NZiGPVy/g1aN4HaI22UxQbDqhcsgu+JOB1mQPZlvzuI=;
        b=lGiVabF1AIZfxEhxOn9bgocZoyfiRi3o/VkdL+Ptbj/fBjNZuTmPW8FfSlMRcqsrCA
         oZwHkxzROsOSDet99q7Zt7P1dAecbcpO9/sbs5QRUn2hDXQEa2qJwbwicfFM4bkBHKIA
         sHB+7+BCfZ6H9DIaO4z/5c06Px9a7YVabuU7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XwnbNZHYjFz/fAKQaIQZSMLN9GeRHwAX07H3J+R74+OARp1NeVpas/ZCMm+Z6pXFAB
         9Dydg0oteDDxYRKIWSN2gDKMchyefFoiYSjSFvi2dUVhEsD9aKkSE1ehZlYn4MoIv7fy
         bBYG3e67MWGItMuM2GRcDteyljxOZcD0iGiXc=
Received: by 10.220.124.36 with SMTP id s36mr259324vcr.129.1285366911950;
        Fri, 24 Sep 2010 15:21:51 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.48
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285366976-22216-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157088>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t0001-init.sh                             |   20 ++++++++++----------
 t/t0003-attributes.sh                       |   16 ++++++++--------
 t/t0020-crlf.sh                             |    2 +-
 t/t0024-crlf-archive.sh                     |    4 ++--
 t/t0026-eol-config.sh                       |    2 +-
 t/t0050-filesystem.sh                       |    6 +++---
 t/t1000-read-tree-m-3way.sh                 |    2 +-
 t/t1302-repo-version.sh                     |    2 +-
 t/t1401-symbolic-ref.sh                     |    2 +-
 t/t1402-check-ref-format.sh                 |    4 ++--
 t/t1410-reflog.sh                           |    8 ++++----
 t/t1501-worktree.sh                         |    2 +-
 t/t1509-root-worktree.sh                    |    6 +++---
 t/t2007-checkout-symlink.sh                 |    2 +-
 t/t2016-checkout-patch.sh                   |    2 +-
 t/t2050-git-dir-relative.sh                 |    4 ++--
 t/t2103-update-index-ignore-missing.sh      |    2 +-
 t/t2200-add-update.sh                       |    2 +-
 t/t3001-ls-files-others-exclude.sh          |    2 +-
 t/t3050-subprojects-fetch.sh                |    4 ++--
 t/t3203-branch-output.sh                    |    6 +++---
 t/t3307-notes-man.sh                        |    2 +-
 t/t3406-rebase-message.sh                   |    6 +++---
 t/t3408-rebase-multi-line.sh                |    2 +-
 t/t3504-cherry-pick-rerere.sh               |    4 ++--
 t/t3903-stash.sh                            |    4 ++--
 t/t3904-stash-patch.sh                      |    2 +-
 t/t4021-format-patch-numbered.sh            |    2 +-
 t/t4027-diff-submodule.sh                   |    2 +-
 t/t4103-apply-binary.sh                     |    8 ++++----
 t/t4104-apply-boundary.sh                   |    4 ++--
 t/t4111-apply-subdir.sh                     |    4 ++--
 t/t4119-apply-config.sh                     |    2 +-
 t/t4124-apply-ws-rule.sh                    |    4 ++--
 t/t4127-apply-same-fn.sh                    |   18 +++++++++---------
 t/t4130-apply-criss-cross-rename.sh         |    2 +-
 t/t4133-apply-filenames.sh                  |    6 +++---
 t/t4150-am.sh                               |    2 +-
 t/t5300-pack-object.sh                      |    4 ++--
 t/t5301-sliding-window.sh                   |    2 +-
 t/t5302-pack-index.sh                       |    2 +-
 t/t5500-fetch-pack.sh                       |    2 +-
 t/t5502-quickfetch.sh                       |    2 +-
 t/t5503-tagfollow.sh                        |    4 ++--
 t/t5510-fetch.sh                            |    2 +-
 t/t5516-fetch-push.sh                       |   20 ++++++++++----------
 t/t5517-push-mirror.sh                      |   10 +++++-----
 t/t5519-push-alternates.sh                  |    2 +-
 t/t5531-deep-submodule-push.sh              |    2 +-
 t/t5541-http-push.sh                        |    2 +-
 t/t5550-http-fetch.sh                       |    6 +++---
 t/t5601-clone.sh                            |    6 +++---
 t/t5701-clone-local.sh                      |    8 ++++----
 t/t5705-clone-2gb.sh                        |    2 +-
 t/t6009-rev-list-parent.sh                  |    2 +-
 t/t6010-merge-base.sh                       |    2 +-
 t/t6022-merge-rename.sh                     |    2 +-
 t/t6024-recursive-merge.sh                  |    2 +-
 t/t6030-bisect-porcelain.sh                 |    8 ++++----
 t/t6040-tracking-info.sh                    |    2 +-
 t/t7004-tag.sh                              |   14 +++++++-------
 t/t7105-reset-patch.sh                      |    6 +++---
 t/t7300-clean.sh                            |    6 +++---
 t/t7501-commit.sh                           |    2 +-
 t/t7502-commit.sh                           |    2 +-
 t/t7506-status-submodule.sh                 |    2 +-
 t/t7600-merge.sh                            |    2 +-
 t/t7610-mergetool.sh                        |    2 +-
 t/t7700-repack.sh                           |    2 +-
 t/t8003-blame.sh                            |    6 +++---
 t/t9122-git-svn-author.sh                   |    4 ++--
 t/t9123-git-svn-rebuild-with-rewriteroot.sh |    2 +-
 t/t9134-git-svn-ignore-paths.sh             |    6 +++---
 t/t9137-git-svn-dcommit-clobber-series.sh   |    2 +-
 t/t9138-git-svn-authors-prog.sh             |    6 +++---
 t/t9146-git-svn-empty-dirs.sh               |    6 +++---
 t/t9151-svn-mergeinfo.sh                    |   22 +++++++++++-----------
 t/t9200-git-cvsexportcommit.sh              |    4 ++--
 t/t9401-git-cvsserver-crlf.sh               |    2 +-
 t/t9600-cvsimport.sh                        |    2 +-
 80 files changed, 184 insertions(+), 184 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 7fe8883..f86beed 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -25,7 +25,7 @@ check_config () {
 
 test_expect_success 'plain' '
 	(
-		unset GIT_DIR GIT_WORK_TREE
+		unset GIT_DIR GIT_WORK_TREE &&
 		mkdir plain &&
 		cd plain &&
 		git init
@@ -48,7 +48,7 @@ test_expect_success 'plain with GIT_WORK_TREE' '
 
 test_expect_success 'plain bare' '
 	(
-		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
 		mkdir plain-bare-1 &&
 		cd plain-bare-1 &&
 		git --bare init
@@ -58,7 +58,7 @@ test_expect_success 'plain bare' '
 
 test_expect_success 'plain bare with GIT_WORK_TREE' '
 	if (
-		unset GIT_DIR GIT_CONFIG
+		unset GIT_DIR GIT_CONFIG &&
 		mkdir plain-bare-2 &&
 		cd plain-bare-2 &&
 		GIT_WORK_TREE=$(pwd) git --bare init
@@ -72,7 +72,7 @@ test_expect_success 'plain bare with GIT_WORK_TREE' '
 test_expect_success 'GIT_DIR bare' '
 
 	(
-		unset GIT_CONFIG
+		unset GIT_CONFIG &&
 		mkdir git-dir-bare.git &&
 		GIT_DIR=git-dir-bare.git git init
 	) &&
@@ -82,7 +82,7 @@ test_expect_success 'GIT_DIR bare' '
 test_expect_success 'init --bare' '
 
 	(
-		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
 		mkdir init-bare.git &&
 		cd init-bare.git &&
 		git init --bare
@@ -93,7 +93,7 @@ test_expect_success 'init --bare' '
 test_expect_success 'GIT_DIR non-bare' '
 
 	(
-		unset GIT_CONFIG
+		unset GIT_CONFIG &&
 		mkdir non-bare &&
 		cd non-bare &&
 		GIT_DIR=.git git init
@@ -104,7 +104,7 @@ test_expect_success 'GIT_DIR non-bare' '
 test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
 
 	(
-		unset GIT_CONFIG
+		unset GIT_CONFIG &&
 		mkdir git-dir-wt-1.git &&
 		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-1.git git init
 	) &&
@@ -114,7 +114,7 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
 test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 
 	if (
-		unset GIT_CONFIG
+		unset GIT_CONFIG &&
 		mkdir git-dir-wt-2.git &&
 		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-2.git git --bare init
 	)
@@ -127,7 +127,7 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 test_expect_success 'reinit' '
 
 	(
-		unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG
+		unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG &&
 
 		mkdir again &&
 		cd again &&
@@ -289,7 +289,7 @@ test_expect_success 'init notices EEXIST (2)' '
 	rm -fr newdir &&
 	(
 		mkdir newdir &&
-		>newdir/a
+		>newdir/a &&
 		test_must_fail git init newdir/a/b &&
 		test -f newdir/a
 	)
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index de38c7f..cb5313b 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -20,11 +20,11 @@ test_expect_success 'setup' '
 
 	mkdir -p a/b/d a/c &&
 	(
-		echo "[attr]notest !test"
-		echo "f	test=f"
-		echo "a/i test=a/i"
-		echo "onoff test -test"
-		echo "offon -test test"
+		echo "[attr]notest !test" &&
+		echo "f	test=f" &&
+		echo "a/i test=a/i" &&
+		echo "onoff test -test" &&
+		echo "offon -test test" &&
 		echo "no notest"
 	) >.gitattributes &&
 	(
@@ -33,7 +33,7 @@ test_expect_success 'setup' '
 	) >a/.gitattributes &&
 	(
 		echo "h test=a/b/h" &&
-		echo "d/* test=a/b/d/*"
+		echo "d/* test=a/b/d/*" &&
 		echo "d/yes notest"
 	) >a/b/.gitattributes
 
@@ -96,7 +96,7 @@ test_expect_success 'setup bare' '
 test_expect_success 'bare repository: check that .gitattribute is ignored' '
 
 	(
-		echo "f	test=f"
+		echo "f	test=f" &&
 		echo "a/i test=a/i"
 	) >.gitattributes &&
 	attr_check f unspecified &&
@@ -110,7 +110,7 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
 test_expect_success 'bare repository: test info/attributes' '
 
 	(
-		echo "f	test=f"
+		echo "f	test=f" &&
 		echo "a/i test=a/i"
 	) >info/attributes &&
 	attr_check f f &&
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 234a94f..1a8f44c 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -439,7 +439,7 @@ test_expect_success 'checkout when deleting .gitattributes' '
 	git rm .gitattributes &&
 	echo "contentsQ" | q_to_cr > .file2 &&
 	git add .file2 &&
-	git commit -m third
+	git commit -m third &&
 
 	git checkout master~1 &&
 	git checkout master &&
diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index c7d0324..ec6c1b3 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -7,7 +7,7 @@ UNZIP=${UNZIP:-unzip}
 
 test_expect_success setup '
 
-	git config core.autocrlf true
+	git config core.autocrlf true &&
 
 	printf "CRLF line ending\r\nAnd another\r\n" > sample &&
 	git add sample &&
@@ -20,7 +20,7 @@ test_expect_success setup '
 test_expect_success 'tar archive' '
 
 	git archive --format=tar HEAD |
-	( mkdir untarred && cd untarred && "$TAR" -xf - )
+	( mkdir untarred && cd untarred && "$TAR" -xf - ) &&
 
 	test_cmp sample untarred/sample
 
diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
index f37ac8f..fe0164b 100755
--- a/t/t0026-eol-config.sh
+++ b/t/t0026-eol-config.sh
@@ -12,7 +12,7 @@ test_expect_success setup '
 
 	git config core.autocrlf false &&
 
-	echo "one text" > .gitattributes
+	echo "one text" > .gitattributes &&
 
 	for w in Hello world how are you; do echo $w; done >one &&
 	for w in I am very very fine thank you; do echo $w; done >two &&
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 41df6bc..64fa8b0 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -12,8 +12,8 @@ unibad=
 no_symlinks=
 test_expect_success 'see what we expect' '
 
-	test_case=test_expect_success
-	test_unicode=test_expect_success
+	test_case=test_expect_success &&
+	test_unicode=test_expect_success &&
 	mkdir junk &&
 	echo good >junk/CamelCase &&
 	echo bad >junk/camelcase &&
@@ -128,7 +128,7 @@ test_expect_success "setup unicode normalization tests" '
   cd unicode &&
   touch "$aumlcdiar" &&
   git add "$aumlcdiar" &&
-  git commit -m initial
+  git commit -m initial &&
   git tag initial &&
   git checkout -b topic &&
   git mv $aumlcdiar tmp &&
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index 4f17172..ca8a409 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -309,7 +309,7 @@ test_expect_success \
 test_expect_success \
     '6 - must not exist in O && !A && !B case' "
      rm -f .git/index DD &&
-     echo DD >DD
+     echo DD >DD &&
      git update-index --add DD &&
      test_must_fail git read-tree -m $tree_O $tree_A $tree_B
 "
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index a6bf1bf..0e47662 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -39,7 +39,7 @@ test_expect_success 'gitdir selection on unsupported repo' '
 	(
 		cd test2 &&
 		git config core.repositoryformatversion >../actual
-	)
+	) &&
 	test_cmp expect actual
 '
 
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 7fa5f5b..2c96551 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -28,7 +28,7 @@ test_expect_success 'symbolic-ref refuses non-ref for HEAD' '
 reset_to_sane
 
 test_expect_success 'symbolic-ref refuses bare sha1' '
-	echo content >file && git add file && git commit -m one
+	echo content >file && git add file && git commit -m one &&
 	test_must_fail git symbolic-ref HEAD `git rev-parse HEAD`
 '
 reset_to_sane
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 782e75d..1b0f82f 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -32,7 +32,7 @@ test_expect_success "check-ref-format --branch @{-1}" '
 	T=$(git write-tree) &&
 	sha1=$(echo A | git commit-tree $T) &&
 	git update-ref refs/heads/master $sha1 &&
-	git update-ref refs/remotes/origin/master $sha1
+	git update-ref refs/remotes/origin/master $sha1 &&
 	git checkout master &&
 	git checkout origin/master &&
 	git checkout master &&
@@ -47,7 +47,7 @@ test_expect_success 'check-ref-format --branch from subdir' '
 	T=$(git write-tree) &&
 	sha1=$(echo A | git commit-tree $T) &&
 	git update-ref refs/heads/master $sha1 &&
-	git update-ref refs/remotes/origin/master $sha1
+	git update-ref refs/remotes/origin/master $sha1 &&
 	git checkout master &&
 	git checkout origin/master &&
 	git checkout master &&
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 25046c4..252fc82 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -186,8 +186,8 @@ test_expect_success 'delete' '
 	test_tick &&
 	git commit -m tiger C &&
 
-	HEAD_entry_count=$(git reflog | wc -l)
-	master_entry_count=$(git reflog show master | wc -l)
+	HEAD_entry_count=$(git reflog | wc -l) &&
+	master_entry_count=$(git reflog show master | wc -l) &&
 
 	test $HEAD_entry_count = 5 &&
 	test $master_entry_count = 5 &&
@@ -199,13 +199,13 @@ test_expect_success 'delete' '
 	test $HEAD_entry_count = $(git reflog | wc -l) &&
 	! grep ox < output &&
 
-	master_entry_count=$(wc -l < output)
+	master_entry_count=$(wc -l < output) &&
 
 	git reflog delete HEAD@{1} &&
 	test $(($HEAD_entry_count -1)) = $(git reflog | wc -l) &&
 	test $master_entry_count = $(git reflog show master | wc -l) &&
 
-	HEAD_entry_count=$(git reflog | wc -l)
+	HEAD_entry_count=$(git reflog | wc -l) &&
 
 	git reflog delete master@{07.04.2005.15:15:00.-0700} &&
 	git reflog show master > output &&
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 2c8f01f..8af9ca4 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -335,7 +335,7 @@ test_expect_success 'absolute pathspec should fail gracefully' '
 '
 
 test_expect_success 'make_relative_path handles double slashes in GIT_DIR' '
-	>dummy_file
+	>dummy_file &&
 	echo git --git-dir="$(pwd)//repo.git" --work-tree="$(pwd)" add dummy_file &&
 	git --git-dir="$(pwd)//repo.git" --work-tree="$(pwd)" add dummy_file
 '
diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
index 7f60fd0..e3391b7 100755
--- a/t/t1509-root-worktree.sh
+++ b/t/t1509-root-worktree.sh
@@ -209,7 +209,7 @@ unset GIT_WORK_TREE
 
 test_expect_success 'go to /' 'cd /'
 test_expect_success 'setup' '
-	rm -rf /.git
+	rm -rf /.git &&
 	echo "Initialized empty Git repository in /.git/" > expected &&
 	git init > result &&
 	test_cmp expected result
@@ -232,8 +232,8 @@ say "auto bare gitdir"
 
 # DESTROYYYYY!!!!!
 test_expect_success 'setup' '
-	rm -rf /refs /objects /info /hooks
-	rm /*
+	rm -rf /refs /objects /info /hooks &&
+	rm /* &&
 	cd / &&
 	echo "Initialized empty Git repository in /" > expected &&
 	git init --bare > result &&
diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index a74ee22..e6f59f1 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -17,7 +17,7 @@ test_expect_success SYMLINKS setup '
 	git branch side &&
 
 	echo goodbye >nitfol &&
-	git add nitfol
+	git add nitfol &&
 	test_tick &&
 	git commit -m "master adds file nitfol" &&
 
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index a463b13..9cd0ac4 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -32,7 +32,7 @@ test_expect_success PERL 'git checkout -p' '
 '
 
 test_expect_success PERL 'git checkout -p with staged changes' '
-	set_state dir/foo work index
+	set_state dir/foo work index &&
 	(echo n; echo y) | git checkout -p &&
 	verify_saved_state bar &&
 	verify_state dir/foo index index
diff --git a/t/t2050-git-dir-relative.sh b/t/t2050-git-dir-relative.sh
index b7131d8..21f4659 100755
--- a/t/t2050-git-dir-relative.sh
+++ b/t/t2050-git-dir-relative.sh
@@ -26,7 +26,7 @@ chmod +x .git/hooks/post-commit'
 
 test_expect_success 'post-commit hook used ordinarily' '
 echo initial >top &&
-git add top
+git add top &&
 git commit -m initial &&
 test -r "${COMMIT_FILE}"
 '
@@ -45,7 +45,7 @@ test -r "${COMMIT_FILE}"
 rm -rf "${COMMIT_FILE}"
 
 test_expect_success 'post-commit-hook from sub dir' '
-echo changed again >top
+echo changed again >top &&
 cd subdir &&
 git --git-dir .git --work-tree .. add ../top &&
 git --git-dir .git --work-tree .. commit -m subcommit &&
diff --git a/t/t2103-update-index-ignore-missing.sh b/t/t2103-update-index-ignore-missing.sh
index 332694e..0114f05 100755
--- a/t/t2103-update-index-ignore-missing.sh
+++ b/t/t2103-update-index-ignore-missing.sh
@@ -32,7 +32,7 @@ test_expect_success basics '
 		test_create_repo xyzzy &&
 		cd xyzzy &&
 		>file &&
-		git add file
+		git add file &&
 		git commit -m "sub initial"
 	) &&
 	git add xyzzy &&
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 2ad2819..0692427 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -25,7 +25,7 @@ test_expect_success setup '
 	echo initial >dir1/sub2 &&
 	echo initial >dir2/sub3 &&
 	git add check dir1 dir2 top foo &&
-	test_tick
+	test_tick &&
 	git commit -m initial &&
 
 	echo changed >check &&
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 6d2f2b6..c8fe978 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -156,7 +156,7 @@ test_expect_success 'trailing slash in exclude allows directory match (2)' '
 
 test_expect_success 'trailing slash in exclude forces directory match (1)' '
 
-	>two
+	>two &&
 	git ls-files --others --exclude=two/ >output &&
 	grep "^two" output
 
diff --git a/t/t3050-subprojects-fetch.sh b/t/t3050-subprojects-fetch.sh
index 4261e96..2f5f41a 100755
--- a/t/t3050-subprojects-fetch.sh
+++ b/t/t3050-subprojects-fetch.sh
@@ -10,10 +10,10 @@ test_expect_success setup '
 		cd sub &&
 		git init &&
 		>subfile &&
-		git add subfile
+		git add subfile &&
 		git commit -m "subproject commit #1"
 	) &&
-	>mainfile
+	>mainfile &&
 	git add sub mainfile &&
 	test_tick &&
 	git commit -m "superproject commit #1"
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 809d1c4..6028748 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -12,13 +12,13 @@ test_expect_success 'make commits' '
 '
 
 test_expect_success 'make branches' '
-	git branch branch-one
+	git branch branch-one &&
 	git branch branch-two HEAD^
 '
 
 test_expect_success 'make remote branches' '
-	git update-ref refs/remotes/origin/branch-one branch-one
-	git update-ref refs/remotes/origin/branch-two branch-two
+	git update-ref refs/remotes/origin/branch-one branch-one &&
+	git update-ref refs/remotes/origin/branch-two branch-two &&
 	git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/branch-one
 '
 
diff --git a/t/t3307-notes-man.sh b/t/t3307-notes-man.sh
index 3269f2e..2ea3be6 100755
--- a/t/t3307-notes-man.sh
+++ b/t/t3307-notes-man.sh
@@ -26,7 +26,7 @@ test_expect_success 'example 1: notes to add an Acked-by line' '
 '
 
 test_expect_success 'example 2: binary notes' '
-	cp "$TEST_DIRECTORY"/test4012.png .
+	cp "$TEST_DIRECTORY"/test4012.png . &&
 	git checkout B &&
 	blob=$(git hash-object -w test4012.png) &&
 	git notes --ref=logo add -C "$blob" &&
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 85fc7c4..506d37e 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -43,20 +43,20 @@ test_expect_success 'rebase -m' '
 '
 
 test_expect_success 'rebase --stat' '
-        git reset --hard start
+        git reset --hard start &&
         git rebase --stat master >diffstat.txt &&
         grep "^ fileX |  *1 +$" diffstat.txt
 '
 
 test_expect_success 'rebase w/config rebase.stat' '
-        git reset --hard start
+        git reset --hard start &&
         git config rebase.stat true &&
         git rebase master >diffstat.txt &&
         grep "^ fileX |  *1 +$" diffstat.txt
 '
 
 test_expect_success 'rebase -n overrides config rebase.stat config' '
-        git reset --hard start
+        git reset --hard start &&
         git config rebase.stat true &&
         git rebase -n master >diffstat.txt &&
         ! grep "^ fileX |  *1 +$" diffstat.txt
diff --git a/t/t3408-rebase-multi-line.sh b/t/t3408-rebase-multi-line.sh
index 2062b85..6b84e60 100755
--- a/t/t3408-rebase-multi-line.sh
+++ b/t/t3408-rebase-multi-line.sh
@@ -16,7 +16,7 @@ test_expect_success setup '
 	git commit -a -m "A sample commit log message that has a long
 summary that spills over multiple lines.
 
-But otherwise with a sane description."
+But otherwise with a sane description." &&
 
 	git branch side &&
 
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index f7b3518..e6a6481 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -23,7 +23,7 @@ test_expect_success 'conflicting merge' '
 test_expect_success 'fixup' '
 	echo foo-dev >foo &&
 	git add foo && test_tick && git commit -q -m 4 &&
-	git reset --hard HEAD^
+	git reset --hard HEAD^ &&
 	echo foo-dev >expect
 '
 
@@ -33,7 +33,7 @@ test_expect_success 'cherry-pick conflict' '
 '
 
 test_expect_success 'reconfigure' '
-	git config rerere.enabled false
+	git config rerere.enabled false &&
 	git reset --hard
 '
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index a283dca..d42b8ab 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -157,7 +157,7 @@ EOF
 
 test_expect_success 'stash branch' '
 	echo foo > file &&
-	git commit file -m first
+	git commit file -m first &&
 	echo bar > file &&
 	echo bar2 > file2 &&
 	git add file2 &&
@@ -268,7 +268,7 @@ test_expect_success 'stash rm and ignore (stage .gitignore)' '
 	git add .gitignore &&
 	git stash save "rm and ignore (stage .gitignore)" &&
 	test bar = "$(cat file)" &&
-	! test -r .gitignore
+	! test -r .gitignore &&
 	git stash apply &&
 	! test -r file &&
 	test file = "$(cat .gitignore)"
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index d1819ca..1e7193a 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -20,7 +20,7 @@ test_expect_success PERL 'setup' '
 # note: bar sorts before dir, so the first 'n' is always to skip 'bar'
 
 test_expect_success PERL 'saying "n" does nothing' '
-	set_state dir/foo work index
+	set_state dir/foo work index &&
 	(echo n; echo n) | test_must_fail git stash save -p &&
 	verify_state dir/foo work index &&
 	verify_saved_state bar
diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
index 709b323..886494b 100755
--- a/t/t4021-format-patch-numbered.sh
+++ b/t/t4021-format-patch-numbered.sh
@@ -95,7 +95,7 @@ test_expect_success 'format.numbered && --keep-subject' '
 
 test_expect_success 'format.numbered = auto' '
 
-	git config format.numbered auto
+	git config format.numbered auto &&
 	git format-patch --stdout HEAD~2 > patch5 &&
 	test_numbered patch5
 
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index d99814a..e62bf2c 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -316,7 +316,7 @@ test_expect_success 'git diff (empty submodule dir)' '
 test_expect_success 'conflicted submodule setup' '
 
 	# 39 efs
-	c=fffffffffffffffffffffffffffffffffffffff
+	c=fffffffffffffffffffffffffffffffffffffff &&
 	(
 		echo "000000 $_z40 0	sub"
 		echo "160000 1$c 1	sub"
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index 9692f16..954118c 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -41,11 +41,11 @@ test_expect_success 'setup' "
 "
 
 test_expect_success 'stat binary diff -- should not fail.' \
-	'git checkout master
+	'git checkout master &&
 	 git apply --stat --summary B.diff'
 
 test_expect_success 'stat binary diff (copy) -- should not fail.' \
-	'git checkout master
+	'git checkout master &&
 	 git apply --stat --summary C.diff'
 
 test_expect_success 'check binary diff -- should fail.' \
@@ -69,11 +69,11 @@ test_expect_success \
 '
 
 test_expect_success 'check binary diff with replacement.' \
-	'git checkout master
+	'git checkout master &&
 	 git apply --check --allow-binary-replacement BF.diff'
 
 test_expect_success 'check binary diff with replacement (copy).' \
-	'git checkout master
+	'git checkout master &&
 	 git apply --check --allow-binary-replacement CF.diff'
 
 # Now we start applying them.
diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
index c617c2a..8e97410 100755
--- a/t/t4104-apply-boundary.sh
+++ b/t/t4104-apply-boundary.sh
@@ -51,7 +51,7 @@ test_expect_success setup '
 		echo $i
 	done >victim &&
 	cat victim >del-a-expect &&
-	git diff victim >del-a-patch.with
+	git diff victim >del-a-patch.with &&
 	git diff --unified=0 >del-a-patch.without &&
 
 	: add to the tail
@@ -78,7 +78,7 @@ test_expect_success setup '
 		echo $i
 	done >victim &&
 	cat victim >del-z-expect &&
-	git diff victim >del-z-patch.with
+	git diff victim >del-z-patch.with &&
 	git diff --unified=0 >del-z-patch.without &&
 
 	: done
diff --git a/t/t4111-apply-subdir.sh b/t/t4111-apply-subdir.sh
index a52d94a..7c39843 100755
--- a/t/t4111-apply-subdir.sh
+++ b/t/t4111-apply-subdir.sh
@@ -89,7 +89,7 @@ test_expect_success 'apply --index from subdir of toplevel' '
 test_expect_success 'apply from .git dir' '
 	cp postimage expected &&
 	cp preimage .git/file &&
-	cp preimage .git/objects/file
+	cp preimage .git/objects/file &&
 	(
 		cd .git &&
 		git apply "$patch"
@@ -100,7 +100,7 @@ test_expect_success 'apply from .git dir' '
 test_expect_success 'apply from subdir of .git dir' '
 	cp postimage expected &&
 	cp preimage .git/file &&
-	cp preimage .git/objects/file
+	cp preimage .git/objects/file &&
 	(
 		cd .git/objects &&
 		git apply "$patch"
diff --git a/t/t4119-apply-config.sh b/t/t4119-apply-config.sh
index 3c73a78..3d0384d 100755
--- a/t/t4119-apply-config.sh
+++ b/t/t4119-apply-config.sh
@@ -73,7 +73,7 @@ D=`pwd`
 test_expect_success 'apply --whitespace=strip in subdir' '
 
 	cd "$D" &&
-	git config --unset-all apply.whitespace
+	git config --unset-all apply.whitespace &&
 	rm -f sub/file1 &&
 	cp saved sub/file1 &&
 	git update-index --refresh &&
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 8a676a5..ccd694a 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -419,7 +419,7 @@ test_expect_success 'same, but with CR-LF line endings && cr-at-eol set' '
 	printf "b\r\n" >>one &&
 	printf "c\r\n" >>one &&
 	cp one save-one &&
-	printf "                 \r\n" >>one
+	printf "                 \r\n" >>one &&
 	git add one &&
 	printf "d\r\n" >>one &&
 	cp one expect &&
@@ -436,7 +436,7 @@ test_expect_success 'same, but with CR-LF line endings && cr-at-eol unset' '
 	printf "b\r\n" >>one &&
 	printf "c\r\n" >>one &&
 	cp one save-one &&
-	printf "                 \r\n" >>one
+	printf "                 \r\n" >>one &&
 	git add one &&
 	cp one expect &&
 	printf "d\r\n" >>one &&
diff --git a/t/t4127-apply-same-fn.sh b/t/t4127-apply-same-fn.sh
index 77200c0..972946c 100755
--- a/t/t4127-apply-same-fn.sh
+++ b/t/t4127-apply-same-fn.sh
@@ -31,7 +31,7 @@ test_expect_success 'apply same filename with independent changes' '
 '
 
 test_expect_success 'apply same filename with overlapping changes' '
-	git reset --hard
+	git reset --hard &&
 	modify "s/^d/z/" same_fn &&
 	git diff > patch0 &&
 	git add same_fn &&
@@ -44,8 +44,8 @@ test_expect_success 'apply same filename with overlapping changes' '
 '
 
 test_expect_success 'apply same new filename after rename' '
-	git reset --hard
-	git mv same_fn new_fn
+	git reset --hard &&
+	git mv same_fn new_fn &&
 	modify "s/^d/z/" new_fn &&
 	git add new_fn &&
 	git diff -M --cached > patch1 &&
@@ -58,12 +58,12 @@ test_expect_success 'apply same new filename after rename' '
 '
 
 test_expect_success 'apply same old filename after rename -- should fail.' '
-	git reset --hard
-	git mv same_fn new_fn
+	git reset --hard &&
+	git mv same_fn new_fn &&
 	modify "s/^d/z/" new_fn &&
 	git add new_fn &&
 	git diff -M --cached > patch1 &&
-	git mv new_fn same_fn
+	git mv new_fn same_fn &&
 	modify "s/^e/y/" same_fn &&
 	git diff >> patch1 &&
 	git reset --hard &&
@@ -71,13 +71,13 @@ test_expect_success 'apply same old filename after rename -- should fail.' '
 '
 
 test_expect_success 'apply A->B (rename), C->A (rename), A->A -- should pass.' '
-	git reset --hard
-	git mv same_fn new_fn
+	git reset --hard &&
+	git mv same_fn new_fn &&
 	modify "s/^d/z/" new_fn &&
 	git add new_fn &&
 	git diff -M --cached > patch1 &&
 	git commit -m "a rename" &&
-	git mv other_fn same_fn
+	git mv other_fn same_fn &&
 	modify "s/^e/y/" same_fn &&
 	git add same_fn &&
 	git diff -M --cached >> patch1 &&
diff --git a/t/t4130-apply-criss-cross-rename.sh b/t/t4130-apply-criss-cross-rename.sh
index 7cfa2d6..d173acd 100755
--- a/t/t4130-apply-criss-cross-rename.sh
+++ b/t/t4130-apply-criss-cross-rename.sh
@@ -44,7 +44,7 @@ test_expect_success 'criss-cross rename' '
 	git reset --hard &&
 	mv file1 tmp &&
 	mv file2 file1 &&
-	mv file3 file2
+	mv file3 file2 &&
 	mv tmp file3 &&
 	cp file1 file1-swapped &&
 	cp file2 file2-swapped &&
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index 3421807..88b35ae 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -29,9 +29,9 @@ EOF
 '
 
 test_expect_success 'apply diff with inconsistent filenames in headers' '
-	test_must_fail git apply bad1.patch 2>err
-	grep "inconsistent new filename" err
-	test_must_fail git apply bad2.patch 2>err
+	test_must_fail git apply bad1.patch 2>err &&
+	grep "inconsistent new filename" err &&
+	test_must_fail git apply bad2.patch 2>err &&
 	grep "inconsistent old filename" err
 '
 
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 1c3d8ed..850fc96 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -219,7 +219,7 @@ test_expect_success 'am stays in branch' '
 
 test_expect_success 'am --signoff does not add Signed-off-by: line if already there' '
 	git format-patch --stdout HEAD^ >patch3 &&
-	sed -e "/^Subject/ s,\[PATCH,Re: Re: Re: & 1/5 v2," patch3 >patch4
+	sed -e "/^Subject/ s,\[PATCH,Re: Re: Re: & 1/5 v2," patch3 >patch4 &&
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout HEAD^ &&
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index bbb9c12..eac1e13 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -12,7 +12,7 @@ TRASH=`pwd`
 
 test_expect_success \
     'setup' \
-    'rm -f .git/index*
+    'rm -f .git/index* &&
      perl -e "print \"a\" x 4096;" > a &&
      perl -e "print \"b\" x 4096;" > b &&
      perl -e "print \"c\" x 4096;" > c &&
@@ -187,7 +187,7 @@ test_expect_success 'survive missing objects/pack directory' '
 		mkdir missing-pack &&
 		cd missing-pack &&
 		git init &&
-		GOP=.git/objects/pack
+		GOP=.git/objects/pack &&
 		rm -fr $GOP &&
 		git index-pack --stdin --keep=test <../test-3-${packname_3}.pack &&
 		test -f $GOP/pack-${packname_3}.pack &&
diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index 0a24e61..bcec3e9 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -8,7 +8,7 @@ test_description='mmap sliding window tests'
 
 test_expect_success \
     'setup' \
-    'rm -f .git/index*
+    'rm -f .git/index* &&
      for i in a b c
      do
          echo $i >$i &&
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index fb3a270..b34ea93 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -8,7 +8,7 @@ test_description='pack index with 64-bit offsets and object CRC'
 
 test_expect_success \
     'setup' \
-    'rm -rf .git
+    'rm -rf .git &&
      git init &&
      git config pack.threads 1 &&
      i=1 &&
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 18376d6..bafcca7 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -91,7 +91,7 @@ test_expect_success 'setup' '
 		prev=$cur &&
 		cur=$(($cur+1))
 	done &&
-	add B1 $A1
+	add B1 $A1 &&
 	echo $ATIP > .git/refs/heads/A &&
 	echo $BTIP > .git/refs/heads/B &&
 	git symbolic-ref HEAD refs/heads/B
diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index 1037a72..7a46cbd 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -57,7 +57,7 @@ test_expect_success 'copy commit and tree but not blob by hand' '
 		cd cloned &&
 		git count-objects | sed -e "s/ *objects,.*//"
 	) ) &&
-	test $cnt -eq 6
+	test $cnt -eq 6 &&
 
 	blob=$(git rev-parse HEAD:file | sed -e "s|..|&/|") &&
 	test -f "cloned/.git/objects/$blob" &&
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 8a298a6..e1c3efe 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -149,8 +149,8 @@ EOF
 '
 
 test_expect_success NOT_MINGW 'new clone fetch master and tags' '
-	git branch -D cat
-	rm -f $U
+	git branch -D cat &&
+	rm -f $U &&
 	(
 		mkdir clone2 &&
 		cd clone2 &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 9a88475..7e433b1 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -119,7 +119,7 @@ test_expect_success 'fetch must not resolve short tag name' '
 test_expect_success 'fetch must not resolve short remote name' '
 
 	cd "$D" &&
-	git update-ref refs/remotes/six/HEAD HEAD
+	git update-ref refs/remotes/six/HEAD HEAD &&
 
 	mkdir six &&
 	cd six &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b11da79..b30ec18 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -49,7 +49,7 @@ check_push_result () {
 	(
 		cd testrepo &&
 		it="$1" &&
-		shift
+		shift &&
 		for ref in "$@"
 		do
 			r=$(git show-ref -s --verify refs/$ref) &&
@@ -542,7 +542,7 @@ test_expect_success 'push does not update local refs on failure' '
 	chmod +x testrepo/.git/hooks/pre-receive &&
 	(
 		cd child &&
-		git pull .. master
+		git pull .. master &&
 		test_must_fail git push &&
 		test $(git rev-parse master) != \
 			$(git rev-parse remotes/origin/master)
@@ -586,7 +586,7 @@ test_expect_success 'push --delete refuses src:dest refspecs' '
 '
 
 test_expect_success 'warn on push to HEAD of non-bare repository' '
-	mk_test heads/master
+	mk_test heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -597,7 +597,7 @@ test_expect_success 'warn on push to HEAD of non-bare repository' '
 '
 
 test_expect_success 'deny push to HEAD of non-bare repository' '
-	mk_test heads/master
+	mk_test heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -607,7 +607,7 @@ test_expect_success 'deny push to HEAD of non-bare repository' '
 '
 
 test_expect_success 'allow push to HEAD of bare repository (bare)' '
-	mk_test heads/master
+	mk_test heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -619,7 +619,7 @@ test_expect_success 'allow push to HEAD of bare repository (bare)' '
 '
 
 test_expect_success 'allow push to HEAD of non-bare repository (config)' '
-	mk_test heads/master
+	mk_test heads/master &&
 	(
 		cd testrepo &&
 		git checkout master &&
@@ -690,7 +690,7 @@ test_expect_success 'push into aliased refs (consistent)' '
 	(
 		cd child1 &&
 		git branch foo &&
-		git symbolic-ref refs/heads/bar refs/heads/foo
+		git symbolic-ref refs/heads/bar refs/heads/foo &&
 		git config receive.denyCurrentBranch false
 	) &&
 	(
@@ -712,7 +712,7 @@ test_expect_success 'push into aliased refs (inconsistent)' '
 	(
 		cd child1 &&
 		git branch foo &&
-		git symbolic-ref refs/heads/bar refs/heads/foo
+		git symbolic-ref refs/heads/bar refs/heads/foo &&
 		git config receive.denyCurrentBranch false
 	) &&
 	(
@@ -757,7 +757,7 @@ test_expect_success 'push --porcelain rejected' '
 	mk_empty &&
 	git push testrepo refs/heads/master:refs/remotes/origin/master &&
 	(cd testrepo &&
-		git reset --hard origin/master^
+		git reset --hard origin/master^ &&
 		git config receive.denyCurrentBranch true) &&
 
 	echo >.git/foo  "To testrepo"  &&
@@ -771,7 +771,7 @@ test_expect_success 'push --porcelain --dry-run rejected' '
 	mk_empty &&
 	git push testrepo refs/heads/master:refs/remotes/origin/master &&
 	(cd testrepo &&
-		git reset --hard origin/master
+		git reset --hard origin/master &&
 		git config receive.denyCurrentBranch true) &&
 
 	echo >.git/foo  "To testrepo"  &&
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index e2ad260..d13606b 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -71,7 +71,7 @@ test_expect_success 'push mirror force updates existing branches' '
 		git push --mirror up &&
 		echo two >foo && git add foo && git commit -m two &&
 		git push --mirror up &&
-		git reset --hard HEAD^
+		git reset --hard HEAD^ &&
 		git push --mirror up
 	) &&
 	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
@@ -88,7 +88,7 @@ test_expect_success 'push mirror removes branches' '
 		echo one >foo && git add foo && git commit -m one &&
 		git branch remove master &&
 		git push --mirror up &&
-		git branch -D remove
+		git branch -D remove &&
 		git push --mirror up
 	) &&
 	(
@@ -170,7 +170,7 @@ test_expect_success 'push mirror force updates existing tags' '
 		echo two >foo && git add foo && git commit -m two &&
 		git tag -f tmaster master &&
 		git push --mirror up &&
-		git reset --hard HEAD^
+		git reset --hard HEAD^ &&
 		git tag -f tmaster master &&
 		git push --mirror up
 	) &&
@@ -188,7 +188,7 @@ test_expect_success 'push mirror removes tags' '
 		echo one >foo && git add foo && git commit -m one &&
 		git tag -f tremove master &&
 		git push --mirror up &&
-		git tag -d tremove
+		git tag -d tremove &&
 		git push --mirror up
 	) &&
 	(
@@ -235,7 +235,7 @@ test_expect_success 'remote.foo.mirror adds and removes branches' '
 		git branch keep master &&
 		git branch remove master &&
 		git push up &&
-		git branch -D remove
+		git branch -D remove &&
 		git push up
 	) &&
 	(
diff --git a/t/t5519-push-alternates.sh b/t/t5519-push-alternates.sh
index 96be523..c00c9b0 100755
--- a/t/t5519-push-alternates.sh
+++ b/t/t5519-push-alternates.sh
@@ -123,7 +123,7 @@ test_expect_success 'bob works and pushes again' '
 	(
 		cd alice-pub &&
 		git cat-file commit master >../bob-work/commit
-	)
+	) &&
 	(
 		# This time Bob does not pull from Alice, and
 		# the master branch at her public repository points
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 65d8d47..faa2e96 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -6,7 +6,7 @@ test_description='unpack-objects'
 
 test_expect_success setup '
 	mkdir pub.git &&
-	GIT_DIR=pub.git git init --bare
+	GIT_DIR=pub.git git init --bare &&
 	GIT_DIR=pub.git git config receive.fsckobjects true &&
 	mkdir work &&
 	(
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index b0c2a2c..9b30cec 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -121,7 +121,7 @@ test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 test_expect_success 'push fails for non-fast-forward refs unmatched by remote helper' '
 	# create a dissimilarly-named remote ref so that git is unable to match the
 	# two refs (viz. local, remote) unless an explicit refspec is provided.
-	git push origin master:retsam
+	git push origin master:retsam &&
 
 	echo "change changed" > path2 &&
 	git commit -a -m path2 --amend &&
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 2fb48d0..37e07c6 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -37,7 +37,7 @@ test_expect_success 'clone http repository' '
 test_expect_success 'fetch changes via http' '
 	echo content >>file &&
 	git commit -a -m two &&
-	git push public
+	git push public &&
 	(cd clone && git pull) &&
 	test_cmp file clone/file
 '
@@ -93,8 +93,8 @@ test_expect_success 'fetch notices corrupt idx' '
 '
 
 test_expect_success 'did not use upload-pack service' '
-	grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act
-	: >exp
+	grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act &&
+	: >exp &&
 	test_cmp exp act
 '
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 987e0c8..a308d97 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -9,9 +9,9 @@ test_expect_success setup '
 	rm -fr .git &&
 	test_create_repo src &&
 	(
-		cd src
-		>file
-		git add file
+		cd src &&
+		>file &&
+		git add file &&
 		git commit -m initial
 	)
 
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 8b4c356..cfed680 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -10,11 +10,11 @@ test_expect_success 'preparing origin repository' '
 	git clone --bare . a.git &&
 	git clone --bare . x &&
 	test "$(GIT_CONFIG=a.git/config git config --bool core.bare)" = true &&
-	test "$(GIT_CONFIG=x/config git config --bool core.bare)" = true
+	test "$(GIT_CONFIG=x/config git config --bool core.bare)" = true &&
 	git bundle create b1.bundle --all &&
 	git bundle create b2.bundle master &&
 	mkdir dir &&
-	cp b1.bundle dir/b3
+	cp b1.bundle dir/b3 &&
 	cp b1.bundle b4
 '
 
@@ -112,7 +112,7 @@ test_expect_success 'bundle clone with nonexistent HEAD' '
 	cd "$D" &&
 	git clone b2.bundle b2 &&
 	cd b2 &&
-	git fetch
+	git fetch &&
 	test ! -e .git/refs/heads/master
 '
 
@@ -124,7 +124,7 @@ test_expect_success 'clone empty repository' '
 	 git config receive.denyCurrentBranch warn) &&
 	git clone empty empty-clone &&
 	test_tick &&
-	(cd empty-clone
+	(cd empty-clone &&
 	 echo "content" >> foo &&
 	 git add foo &&
 	 git commit -m "Initial commit" &&
diff --git a/t/t5705-clone-2gb.sh b/t/t5705-clone-2gb.sh
index e9783c3..dc42932 100755
--- a/t/t5705-clone-2gb.sh
+++ b/t/t5705-clone-2gb.sh
@@ -23,7 +23,7 @@ test_expect_success CLONE_2GB 'setup' '
 		printf "blob\nmark :$i\ndata $blobsize\n" &&
 		#test-genrandom $i $blobsize &&
 		printf "%-${blobsize}s" $i &&
-		echo "M 100644 :$i $i" >> commit
+		echo "M 100644 :$i $i" >> commit &&
 		i=$(($i+1)) ||
 		echo $? > exit-status
 	 done &&
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index c8a96a9..52f7b27 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -18,7 +18,7 @@ test_expect_success setup '
 
 	commit one &&
 
-	test_tick=$(($test_tick - 2400))
+	test_tick=$(($test_tick - 2400)) &&
 
 	commit two &&
 	commit three &&
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 62197a3..082032e 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -131,7 +131,7 @@ test_expect_success 'unsynchronized clocks' '
 	R2=$(doit  3 R2 $R1) &&
 
 	PL=$(doit  4 PL $L2 $C2) &&
-	PR=$(doit  4 PR $C2 $R2)
+	PR=$(doit  4 PR $C2 $R2) &&
 
 	git name-rev $C2 >expected &&
 
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index b66544b..80adaf6 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -332,7 +332,7 @@ test_expect_success 'interference with untracked working tree file' '
 '
 
 test_expect_success 'merge of identical changes in a renamed file' '
-	rm -f A M N
+	rm -f A M N &&
 	git reset --hard &&
 	git checkout change+rename &&
 	GIT_MERGE_VERBOSITY=3 git merge change | grep "^Skipped B" &&
diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
index b3fbf65..755d30c 100755
--- a/t/t6024-recursive-merge.sh
+++ b/t/t6024-recursive-merge.sh
@@ -104,7 +104,7 @@ test_expect_success 'mark rename/delete as unmerged' '
 	test_tick &&
 	git commit -m delete &&
 	git checkout -b rename HEAD^ &&
-	git mv a1 a2
+	git mv a1 a2 &&
 	test_tick &&
 	git commit -m rename &&
 	test_must_fail git merge delete &&
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 3b042aa..b5063b6 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -517,13 +517,13 @@ test_expect_success '"parallel" side branch creation' '
 	add_line_into_file "2(para): line 2 on parallel branch" dir2/file2 &&
 	PARA_HASH2=$(git rev-parse --verify HEAD) &&
 	add_line_into_file "3(para): line 3 on parallel branch" dir2/file3 &&
-	PARA_HASH3=$(git rev-parse --verify HEAD)
+	PARA_HASH3=$(git rev-parse --verify HEAD) &&
 	git merge -m "merge HASH4 and PARA_HASH3" "$HASH4" &&
-	PARA_HASH4=$(git rev-parse --verify HEAD)
+	PARA_HASH4=$(git rev-parse --verify HEAD) &&
 	add_line_into_file "5(para): add line on parallel branch" dir1/file1 &&
-	PARA_HASH5=$(git rev-parse --verify HEAD)
+	PARA_HASH5=$(git rev-parse --verify HEAD) &&
 	add_line_into_file "6(para): add line on parallel branch" dir2/file2 &&
-	PARA_HASH6=$(git rev-parse --verify HEAD)
+	PARA_HASH6=$(git rev-parse --verify HEAD) &&
 	git merge -m "merge HASH7 and PARA_HASH6" "$HASH7" &&
 	PARA_HASH7=$(git rev-parse --verify HEAD)
 '
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 1785e17..1e0447f 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -60,7 +60,7 @@ test_expect_success 'checkout' '
 
 test_expect_success 'checkout with local tracked branch' '
 	git checkout master &&
-	git checkout follower >actual
+	git checkout follower >actual &&
 	grep "is ahead of" actual
 '
 
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index ac943f5..ee44331 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1122,7 +1122,7 @@ v2.0
 EOF
 
 test_expect_success 'checking that first commit is in all tags (hash)' "
-	git tag -l --contains $hash1 v* >actual
+	git tag -l --contains $hash1 v* >actual &&
 	test_cmp expected actual
 "
 
@@ -1201,18 +1201,18 @@ v4.0
 EOF
 
 test_expect_success 'checking that initial commit is in all tags' "
-	git tag -l --contains $hash1 v* >actual
+	git tag -l --contains $hash1 v* >actual &&
 	test_cmp expected actual
 "
 
 # mixing modes and options:
 
 test_expect_success 'mixing incompatibles modes and options is forbidden' '
-	test_must_fail git tag -a
-	test_must_fail git tag -l -v
-	test_must_fail git tag -n 100
-	test_must_fail git tag -l -m msg
-	test_must_fail git tag -l -F some file
+	test_must_fail git tag -a &&
+	test_must_fail git tag -l -v &&
+	test_must_fail git tag -n 100 &&
+	test_must_fail git tag -l -m msg &&
+	test_must_fail git tag -l -F some file &&
 	test_must_fail git tag -v -s
 '
 
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index 9891e2c..95fab20 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -18,7 +18,7 @@ test_expect_success PERL 'setup' '
 # note: bar sorts before foo, so the first 'n' is always to skip 'bar'
 
 test_expect_success PERL 'saying "n" does nothing' '
-	set_and_save_state dir/foo work work
+	set_and_save_state dir/foo work work &&
 	(echo n; echo n) | git reset -p &&
 	verify_saved_state dir/foo &&
 	verify_saved_state bar
@@ -42,14 +42,14 @@ test_expect_success PERL 'git reset -p HEAD^' '
 # the failure case (and thus get out of the loop).
 
 test_expect_success PERL 'git reset -p dir' '
-	set_state dir/foo work work
+	set_state dir/foo work work &&
 	(echo y; echo n) | git reset -p dir &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar
 '
 
 test_expect_success PERL 'git reset -p -- foo (inside dir)' '
-	set_state dir/foo work work
+	set_state dir/foo work work &&
 	(echo y; echo n) | (cd dir && git reset -p -- foo) &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 6c776e9..a37797d 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -183,7 +183,7 @@ test_expect_success 'git clean symbolic link' '
 
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
-	ln -s docs/manual.txt src/part4.c
+	ln -s docs/manual.txt src/part4.c &&
 	git clean &&
 	test -f Makefile &&
 	test -f README &&
@@ -404,7 +404,7 @@ test_expect_success 'nested git work tree' '
 	(
 		cd foo &&
 		git init &&
-		>hello.world
+		>hello.world &&
 		git add . &&
 		git commit -a -m nested
 	) &&
@@ -424,7 +424,7 @@ test_expect_success 'force removal of nested git work tree' '
 	(
 		cd foo &&
 		git init &&
-		>hello.world
+		>hello.world &&
 		git add . &&
 		git commit -a -m nested
 	) &&
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 8297cb4..2f8a4f4 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -351,7 +351,7 @@ test_expect_success 'git commit <file> with dirty index' '
 
 test_expect_success 'same tree (single parent)' '
 
-	git reset --hard
+	git reset --hard &&
 
 	if git commit -m empty
 	then
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index ac2e187..b6b9802 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -390,7 +390,7 @@ try_commit_status_combo () {
 
 	test_expect_success 'commit --no-status' '
 		clear_config commit.status &&
-		try_commit --no-status
+		try_commit --no-status &&
 		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 3d4f85d..f497001 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -159,7 +159,7 @@ test_expect_success 'status with added and untracked file in modified submodule
 
 test_expect_success 'setup .git file for sub' '
 	(cd sub &&
-	 rm -f new-file
+	 rm -f new-file &&
 	 REAL="$(pwd)/../.real" &&
 	 mv .git "$REAL"
 	 echo "gitdir: $REAL" >.git) &&
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index b4f40e4..9351e1d 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -128,7 +128,7 @@ test_expect_success 'setup' '
 	test_tick &&
 	git commit -m "commit 3" &&
 	git tag c3 &&
-	c3=$(git rev-parse HEAD)
+	c3=$(git rev-parse HEAD) &&
 	git reset --hard "$c0" &&
 	create_merge_msgs
 '
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 3bd7404..d78bdec 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -54,7 +54,7 @@ test_expect_success 'custom mergetool' '
 
 test_expect_success 'mergetool crlf' '
     git config core.autocrlf true &&
-    git checkout -b test2 branch1
+    git checkout -b test2 branch1 &&
     test_must_fail git merge master >/dev/null 2>&1 &&
     ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index c2f66ff..bd07f4e 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -56,7 +56,7 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
 '
 
 test_expect_success 'packed obs in alt ODB are repacked even when local repo is packless' '
-	mkdir alt_objects/pack
+	mkdir alt_objects/pack &&
 	mv .git/objects/pack/* alt_objects/pack &&
 	git repack -a &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
index 230143c..ddabf4f 100755
--- a/t/t8003-blame.sh
+++ b/t/t8003-blame.sh
@@ -153,15 +153,15 @@ test_expect_success 'blame path that used to be a directory' '
 '
 
 test_expect_success 'blame to a commit with no author name' '
-  TREE=`git rev-parse HEAD:`
+  TREE=`git rev-parse HEAD:` &&
   cat >badcommit <<EOF
 tree $TREE
 author <noname> 1234567890 +0000
 committer David Reiss <dreiss@facebook.com> 1234567890 +0000
 
 some message
-EOF
-  COMMIT=`git hash-object -t commit -w badcommit`
+EOF &&
+  COMMIT=`git hash-object -t commit -w badcommit` &&
   git --no-pager blame $COMMIT -- uno >/dev/null
 '
 
diff --git a/t/t9122-git-svn-author.sh b/t/t9122-git-svn-author.sh
index 30013b7..9fe0dd2 100755
--- a/t/t9122-git-svn-author.sh
+++ b/t/t9122-git-svn-author.sh
@@ -7,8 +7,8 @@ test_expect_success 'setup svn repository' '
 	svn_cmd checkout "$svnrepo" work.svn &&
 	(
 		cd work.svn &&
-		echo >file
-		svn_cmd add file
+		echo >file &&
+		svn_cmd add file &&
 		svn_cmd commit -m "first commit" file
 	)
 '
diff --git a/t/t9123-git-svn-rebuild-with-rewriteroot.sh b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
index 0ed90d9..fd81847 100755
--- a/t/t9123-git-svn-rebuild-with-rewriteroot.sh
+++ b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
@@ -16,7 +16,7 @@ rm -rf import
 
 test_expect_success 'init, fetch and checkout repository' '
 	git svn init --rewrite-root=http://invalid.invalid/ "$svnrepo" &&
-	git svn fetch
+	git svn fetch &&
 	git checkout -b mybranch ${remotes_git_svn}
 	'
 
diff --git a/t/t9134-git-svn-ignore-paths.sh b/t/t9134-git-svn-ignore-paths.sh
index 09ff10c..fff49c4 100755
--- a/t/t9134-git-svn-ignore-paths.sh
+++ b/t/t9134-git-svn-ignore-paths.sh
@@ -82,7 +82,7 @@ test_expect_success 'update git svn-cloned repo (option ignore)' '
 test_expect_success 'SVN-side change inside of ignored www' '
 	(
 		cd s &&
-		echo zaq >> www/test_www.txt
+		echo zaq >> www/test_www.txt &&
 		svn_cmd commit -m "SVN-side change inside of www/test_www.txt" &&
 		svn_cmd up &&
 		svn_cmd log -v | fgrep "SVN-side change inside of www/test_www.txt"
@@ -114,8 +114,8 @@ test_expect_success 'update git svn-cloned repo (option ignore)' '
 test_expect_success 'SVN-side change in and out of ignored www' '
 	(
 		cd s &&
-		echo cvf >> www/test_www.txt
-		echo ygg >> qqq/test_qqq.txt
+		echo cvf >> www/test_www.txt &&
+		echo ygg >> qqq/test_qqq.txt &&
 		svn_cmd commit -m "SVN-side change in and out of ignored www" &&
 		svn_cmd up &&
 		svn_cmd log -v | fgrep "SVN-side change in and out of ignored www"
diff --git a/t/t9137-git-svn-dcommit-clobber-series.sh b/t/t9137-git-svn-dcommit-clobber-series.sh
index d60da63..ad01487 100755
--- a/t/t9137-git-svn-dcommit-clobber-series.sh
+++ b/t/t9137-git-svn-dcommit-clobber-series.sh
@@ -7,7 +7,7 @@ test_description='git svn dcommit clobber series'
 test_expect_success 'initialize repo' '
 	mkdir import &&
 	(cd import &&
-	awk "BEGIN { for (i = 1; i < 64; i++) { print i } }" > file
+	awk "BEGIN { for (i = 1; i < 64; i++) { print i } }" > file &&
 	svn_cmd import -m "initial" . "$svnrepo"
 	) &&
 	git svn init "$svnrepo" &&
diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
index 83cc5fc..7102ab9 100755
--- a/t/t9138-git-svn-authors-prog.sh
+++ b/t/t9138-git-svn-authors-prog.sh
@@ -37,14 +37,14 @@ test_expect_success 'import authors with prog and file' '
 
 test_expect_success 'imported 6 revisions successfully' '
 	(
-		cd x
+		cd x &&
 		test "`git rev-list refs/remotes/git-svn | wc -l`" -eq 6
 	)
 	'
 
 test_expect_success 'authors-prog ran correctly' '
 	(
-		cd x
+		cd x &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 | \
 		  grep "^author ee-foo <ee-foo@example\.com> " &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn~2 | \
@@ -60,7 +60,7 @@ test_expect_success 'authors-prog ran correctly' '
 
 test_expect_success 'authors-file overrode authors-prog' '
 	(
-		cd x
+		cd x &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
 		  grep "^author FFFFFFF FFFFFFF <fFf@other\.example\.com> "
 	)
diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
index 565365c..14b4c48 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -33,7 +33,7 @@ test_expect_success 'more emptiness' '
 '
 
 test_expect_success 'git svn rebase creates empty directory' '
-	( cd cloned && git svn rebase )
+	( cd cloned && git svn rebase ) &&
 	test -d cloned/"! !"
 '
 
@@ -65,13 +65,13 @@ test_expect_success 'git svn mkdirs -r works' '
 				echo >&2 "$i does not exist"
 				exit 1
 			fi
-		done
+		done &&
 
 		if test -d "! !"
 		then
 			echo >&2 "$i should not exist"
 			exit 1
-		fi
+		fi &&
 
 		git svn mkdirs -r8 &&
 		if ! test -d "! !"
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 250c651..4f6c06e 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -18,39 +18,39 @@ test_expect_success 'load svn dump' "
 
 test_expect_success 'all svn merges became git merge commits' '
 	unmarked=$(git rev-list --parents --all --grep=Merge |
-		grep -v " .* " | cut -f1 -d" ")
+		grep -v " .* " | cut -f1 -d" ") &&
 	[ -z "$unmarked" ]
 	'
 
 test_expect_success 'cherry picks did not become git merge commits' '
 	bad_cherries=$(git rev-list --parents --all --grep=Cherry |
-		grep " .* " | cut -f1 -d" ")
+		grep " .* " | cut -f1 -d" ") &&
 	[ -z "$bad_cherries" ]
 	'
 
 test_expect_success 'svn non-merge merge commits did not become git merge commits' '
 	bad_non_merges=$(git rev-list --parents --all --grep=non-merge |
-		grep " .* " | cut -f1 -d" ")
+		grep " .* " | cut -f1 -d" ") &&
 	[ -z "$bad_non_merges" ]
 	'
 
 test_expect_success 'commit made to merged branch is reachable from the merge' '
-	before_commit=$(git rev-list --all --grep="trunk commit before merging trunk to b2")
-	merge_commit=$(git rev-list --all --grep="Merge trunk to b2")
-	not_reachable=$(git rev-list -1 $before_commit --not $merge_commit)
+	before_commit=$(git rev-list --all --grep="trunk commit before merging trunk to b2") &&
+	merge_commit=$(git rev-list --all --grep="Merge trunk to b2") &&
+	not_reachable=$(git rev-list -1 $before_commit --not $merge_commit) &&
 	[ -z "$not_reachable" ]
 	'
 
 test_expect_success 'merging two branches in one commit is detected correctly' '
-	f1_commit=$(git rev-list --all --grep="make f1 branch from trunk")
-	f2_commit=$(git rev-list --all --grep="make f2 branch from trunk")
-	merge_commit=$(git rev-list --all --grep="Merge f1 and f2 to trunk")
-	not_reachable=$(git rev-list -1 $f1_commit $f2_commit --not $merge_commit)
+	f1_commit=$(git rev-list --all --grep="make f1 branch from trunk") &&
+	f2_commit=$(git rev-list --all --grep="make f2 branch from trunk") &&
+	merge_commit=$(git rev-list --all --grep="Merge f1 and f2 to trunk") &&
+	not_reachable=$(git rev-list -1 $f1_commit $f2_commit --not $merge_commit) &&
 	[ -z "$not_reachable" ]
 	'
 
 test_expect_failure 'everything got merged in the end' '
-	unmerged=$(git rev-list --all --not master)
+	unmerged=$(git rev-list --all --not master) &&
 	[ -z "$unmerged" ]
 	'
 
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index e5da65b..70c1af0 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -182,7 +182,7 @@ test_expect_success \
       git commit -a -m "Update with spaces" &&
       id=$(git rev-list --max-count=1 HEAD) &&
       (cd "$CVSWORK" &&
-      git cvsexportcommit -c $id
+      git cvsexportcommit -c $id &&
       check_entries "G g" "with spaces.png/1.2/-kb|with spaces.txt/1.2/"
       )'
 
@@ -240,7 +240,7 @@ test_expect_success FILEMODE \
       git add G/off &&
       git commit -a -m "Execute test" &&
       (cd "$CVSWORK" &&
-      git cvsexportcommit -c HEAD
+      git cvsexportcommit -c HEAD &&
       test -x G/on &&
       ! test -x G/off
       )'
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index 1bbfd82..ff6d6fb 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -70,7 +70,7 @@ test_expect_success 'setup' '
     mkdir subdir &&
     echo "Another text file" > subdir/file.h &&
     echo "Another binary: Q (this time CR)" | q_to_cr > subdir/withCr.bin &&
-    echo "Mixed up NUL, but marked text: Q <- there" | q_to_nul > mixedUp.c
+    echo "Mixed up NUL, but marked text: Q <- there" | q_to_nul > mixedUp.c &&
     echo "Unspecified" > subdir/unspecified.other &&
     echo "/*.bin -crlf" > .gitattributes &&
     echo "/*.c crlf" >> .gitattributes &&
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 432b82e..db081e7 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -128,7 +128,7 @@ test_expect_success PERL 'second update has correct .git/cvs-revisions' '
 
 	(cd module-git &&
 	 git log --format="o_fortuna 1.1 %H" -1 HEAD^^ &&
-	 git log --format="o_fortuna 1.2 %H" -1 HEAD^
+	 git log --format="o_fortuna 1.2 %H" -1 HEAD^ &&
 	 git log --format="tick 1.1 %H" -1 HEAD) > expected &&
 	test_cmp expected module-git/.git/cvs-revisions
 '
-- 
1.7.3.95.g14291
