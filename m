From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 1/4] tests: use "git xyzzy" form (t0000 - t3599)
Date: Wed, 03 Sep 2008 17:59:27 +0900
Message-ID: <20080903175927.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 11:01:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaoF0-00011w-HJ
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 11:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbYICJAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 05:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbYICJAA
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 05:00:00 -0400
Received: from karen.lavabit.com ([72.249.41.33]:36030 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607AbYICI76 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 04:59:58 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 9F42AC8902;
	Wed,  3 Sep 2008 03:59:48 -0500 (CDT)
Received: from 8115.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id LBBCR0GHT4MC; Wed, 03 Sep 2008 03:59:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Toyf/7EMiQlweUazp4uJHdFrBxgRqEw7YQd8q5NUK8CsfT4BHM/e+654g5tUoRp/RxNaQDneD4HpiSszZc2hEtyzuWQr8XX3j6CfCiNoc84omSgK4mu1J3lD/fXPp9ajiwGps2ZlXpWKSL3DZ2QNCNWVhb6vR0a9WyYfwWop5CE=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94767>

Converts tests between t0050-t3903.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 t/t0050-filesystem.sh              |    2 +-
 t/t1007-hash-object.sh             |    2 +-
 t/t1200-tutorial.sh                |    2 +-
 t/t1303-wacky-config.sh            |    2 +-
 t/t1400-update-ref.sh              |   10 +++---
 t/t1503-rev-parse-verify.sh        |    2 +-
 t/t2005-checkout-index-symlinks.sh |    4 +-
 t/t2050-git-dir-relative.sh        |    4 +-
 t/t2101-update-index-reupdate.sh   |    2 +-
 t/t2102-update-index-symlinks.sh   |    2 +-
 t/t2200-add-update.sh              |   12 ++++----
 t/t3001-ls-files-others-exclude.sh |    2 +-
 t/t3020-ls-files-error-unmatch.sh  |    2 +-
 t/t3030-merge-recursive.sh         |   14 ++++----
 t/t3200-branch.sh                  |   58 ++++++++++++++++++------------------
 t/t3210-pack-refs.sh               |    4 +-
 t/t3400-rebase.sh                  |    6 ++--
 t/t3401-rebase-partial.sh          |   22 +++++++-------
 t/t3403-rebase-skip.sh             |    2 +-
 t/t3404-rebase-interactive.sh      |    2 +-
 t/t3407-rebase-abort.sh            |    2 +-
 t/t3500-cherry.sh                  |   12 ++++----
 t/t3800-mktag.sh                   |   12 ++++----
 t/t3900-i18n-commit.sh             |    6 ++--
 t/t3901-i18n-patch.sh              |   16 +++++-----
 t/t3903-stash.sh                   |    2 +-
 26 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index b177174..7edf49d 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -87,3 +87,3 @@ $test_case 'add (with different case)' '
 	git add CamelCase &&
-	test $(git-ls-files | grep -i camelcase | wc -l) = 1
+	test $(git ls-files | grep -i camelcase | wc -l) = 1
 
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index fcdd15a..fd98e44 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -2,3 +2,3 @@
 
-test_description="git-hash-object"
+test_description="git hash-object"
 
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index 09a8199..67e637b 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -80,3 +80,3 @@ test_expect_success 'git tag my-first-tag' 'cmp .git/refs/heads/master .git/refs
 
-# TODO: test git-clone
+# TODO: test git clone
 
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index f98f4c5..1983076 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -37,3 +37,3 @@ test_expect_success 'add key in different section' '
 SECTION="test.q\"s\\sq'sp e.key"
-test_expect_success 'make sure git-config escapes section names properly' '
+test_expect_success 'make sure git config escapes section names properly' '
 	git config "$SECTION" bar &&
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index b31e4b1..04c2b16 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -230,3 +230,3 @@ test_expect_success \
 	 GIT_AUTHOR_DATE="2005-05-26 23:30" \
-	 GIT_COMMITTER_DATE="2005-05-26 23:30" git-commit -m add -a &&
+	 GIT_COMMITTER_DATE="2005-05-26 23:30" git commit -m add -a &&
 	 h_TEST=$(git rev-parse --verify HEAD)
@@ -236,6 +236,6 @@ test_expect_success \
 	 GIT_AUTHOR_DATE="2005-05-26 23:41" \
-	 GIT_COMMITTER_DATE="2005-05-26 23:41" git-commit -F M -a &&
+	 GIT_COMMITTER_DATE="2005-05-26 23:41" git commit -F M -a &&
 	 h_OTHER=$(git rev-parse --verify HEAD) &&
 	 GIT_AUTHOR_DATE="2005-05-26 23:44" \
-	 GIT_COMMITTER_DATE="2005-05-26 23:44" git-commit --amend &&
+	 GIT_COMMITTER_DATE="2005-05-26 23:44" git commit --amend &&
 	 h_FIXED=$(git rev-parse --verify HEAD) &&
@@ -244,3 +244,3 @@ test_expect_success \
 	 GIT_AUTHOR_DATE="2005-05-26 23:45" \
-	 GIT_COMMITTER_DATE="2005-05-26 23:45" git-commit -F M &&
+	 GIT_COMMITTER_DATE="2005-05-26 23:45" git commit -F M &&
 	 h_MERGED=$(git rev-parse --verify HEAD) &&
@@ -255,3 +255,3 @@ EOF
 test_expect_success \
-	'git-commit logged updates' \
+	'git commit logged updates' \
 	"diff expect .git/logs/$m"
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 95244c9..cc65394 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -25,3 +25,3 @@ add_line_into_file()
     test_tick
-    git-commit --quiet -m "$MSG" $_file
+    git commit --quiet -m "$MSG" $_file
 }
diff --git a/t/t2005-checkout-index-symlinks.sh b/t/t2005-checkout-index-symlinks.sh
index a84c5a6..ed12c4d 100755
--- a/t/t2005-checkout-index-symlinks.sh
+++ b/t/t2005-checkout-index-symlinks.sh
@@ -15,3 +15,3 @@ test_expect_success \
 git config core.symlinks false &&
-l=$(echo -n file | git-hash-object -t blob -w --stdin) &&
+l=$(echo -n file | git hash-object -t blob -w --stdin) &&
 echo "120000 $l	symlink" | git update-index --index-info'
@@ -25,3 +25,3 @@ test_expect_success \
 'the file must be the blob we added during the setup' '
-test "$(git-hash-object -t blob symlink)" = $l'
+test "$(git hash-object -t blob symlink)" = $l'
 
diff --git a/t/t2050-git-dir-relative.sh b/t/t2050-git-dir-relative.sh
index 88f268b..b7131d8 100755
--- a/t/t2050-git-dir-relative.sh
+++ b/t/t2050-git-dir-relative.sh
@@ -28,4 +28,4 @@ test_expect_success 'post-commit hook used ordinarily' '
 echo initial >top &&
-git-add top
-git-commit -m initial &&
+git add top
+git commit -m initial &&
 test -r "${COMMIT_FILE}"
diff --git a/t/t2101-update-index-reupdate.sh b/t/t2101-update-index-reupdate.sh
index 59b560b..648184f 100755
--- a/t/t2101-update-index-reupdate.sh
+++ b/t/t2101-update-index-reupdate.sh
@@ -42,3 +42,3 @@ test_expect_success 'update-index --remove --again' \
 
-test_expect_success 'first commit' 'git-commit -m initial'
+test_expect_success 'first commit' 'git commit -m initial'
 
diff --git a/t/t2102-update-index-symlinks.sh b/t/t2102-update-index-symlinks.sh
index 19d0894..f195aef 100755
--- a/t/t2102-update-index-symlinks.sh
+++ b/t/t2102-update-index-symlinks.sh
@@ -15,3 +15,3 @@ test_expect_success \
 git config core.symlinks false &&
-l=$(echo -n file | git-hash-object -t blob -w --stdin) &&
+l=$(echo -n file | git hash-object -t blob -w --stdin) &&
 echo "120000 $l	symlink" | git update-index --index-info'
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index f57a6e0..cd9231c 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -28,3 +28,3 @@ test_expect_success setup '
 	test_tick
-	git-commit -m initial &&
+	git commit -m initial &&
 
@@ -42,3 +42,3 @@ test_expect_success update '
 test_expect_success 'update noticed a removal' '
-	test "$(git-ls-files dir1/sub1)" = ""
+	test "$(git ls-files dir1/sub1)" = ""
 '
@@ -46,3 +46,3 @@ test_expect_success 'update noticed a removal' '
 test_expect_success 'update touched correct path' '
-	test "$(git-diff-files --name-status dir2/sub3)" = ""
+	test "$(git diff-files --name-status dir2/sub3)" = ""
 '
@@ -50,4 +50,4 @@ test_expect_success 'update touched correct path' '
 test_expect_success 'update did not touch other tracked files' '
-	test "$(git-diff-files --name-status check)" = "M	check" &&
-	test "$(git-diff-files --name-status top)" = "M	top"
+	test "$(git diff-files --name-status check)" = "M	check" &&
+	test "$(git diff-files --name-status top)" = "M	top"
 '
@@ -55,3 +55,3 @@ test_expect_success 'update did not touch other tracked files' '
 test_expect_success 'update did not touch untracked files' '
-	test "$(git-ls-files dir2/other)" = ""
+	test "$(git ls-files dir2/other)" = ""
 '
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 1caeaca..8666946 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -98,3 +98,3 @@ EOF
 
-test_expect_success 'git-status honours core.excludesfile' \
+test_expect_success 'git status honors core.excludesfile' \
 	'test_cmp expect output'
diff --git a/t/t3020-ls-files-error-unmatch.sh b/t/t3020-ls-files-error-unmatch.sh
index af8c412..f4066cb 100755
--- a/t/t3020-ls-files-error-unmatch.sh
+++ b/t/t3020-ls-files-error-unmatch.sh
@@ -15,3 +15,3 @@ touch foo bar
 git update-index --add foo bar
-git-commit -m "add foo bar"
+git commit -m "add foo bar"
 
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index f288015..de0cdb1 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -243,3 +243,3 @@ test_expect_success 'merge-recursive simple' '
 
-	git-merge-recursive "$c0" -- "$c2" "$c1"
+	git merge-recursive "$c0" -- "$c2" "$c1"
 	status=$?
@@ -287,3 +287,3 @@ test_expect_success 'merge-recursive remove conflict' '
 
-	git-merge-recursive "$c0" -- "$c1" "$c5"
+	git merge-recursive "$c0" -- "$c1" "$c5"
 	status=$?
@@ -319,3 +319,3 @@ test_expect_success 'merge-recursive d/f simple' '
 
-	git-merge-recursive "$c0" -- "$c1" "$c3"
+	git merge-recursive "$c0" -- "$c1" "$c3"
 '
@@ -341,3 +341,3 @@ test_expect_success 'merge-recursive d/f conflict' '
 
-	git-merge-recursive "$c0" -- "$c1" "$c4"
+	git merge-recursive "$c0" -- "$c1" "$c4"
 	status=$?
@@ -375,3 +375,3 @@ test_expect_success 'merge-recursive d/f conflict the other way' '
 
-	git-merge-recursive "$c0" -- "$c4" "$c1"
+	git merge-recursive "$c0" -- "$c4" "$c1"
 	status=$?
@@ -409,3 +409,3 @@ test_expect_success 'merge-recursive d/f conflict' '
 
-	git-merge-recursive "$c0" -- "$c1" "$c6"
+	git merge-recursive "$c0" -- "$c1" "$c6"
 	status=$?
@@ -443,3 +443,3 @@ test_expect_success 'merge-recursive d/f conflict' '
 
-	git-merge-recursive "$c0" -- "$c6" "$c1"
+	git merge-recursive "$c0" -- "$c6" "$c1"
 	status=$?
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7a83fbf..2147eac 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -16,6 +16,6 @@ test_expect_success \
      git update-index --add A &&
-     git-commit -m "Initial commit." &&
+     git commit -m "Initial commit." &&
      echo World >> A &&
      git update-index --add A &&
-     git-commit -m "Second commit." &&
+     git commit -m "Second commit." &&
      HEAD=$(git rev-parse --verify HEAD)'
@@ -125,3 +125,3 @@ test_expect_success 'test tracking setup via --track' \
      git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-     (git show-ref -q refs/remotes/local/master || git-fetch local) &&
+     (git show-ref -q refs/remotes/local/master || git fetch local) &&
      git branch --track my1 local/master &&
@@ -133,3 +133,3 @@ test_expect_success 'test tracking setup (non-wildcard, matching)' \
      git config remote.local.fetch refs/heads/master:refs/remotes/local/master &&
-     (git show-ref -q refs/remotes/local/master || git-fetch local) &&
+     (git show-ref -q refs/remotes/local/master || git fetch local) &&
      git branch --track my4 local/master &&
@@ -141,3 +141,3 @@ test_expect_success 'test tracking setup (non-wildcard, not matching)' \
      git config remote.local.fetch refs/heads/s:refs/remotes/local/s &&
-     (git show-ref -q refs/remotes/local/master || git-fetch local) &&
+     (git show-ref -q refs/remotes/local/master || git fetch local) &&
      git branch --track my5 local/master &&
@@ -150,3 +150,3 @@ test_expect_success 'test tracking setup via config' \
      git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-     (git show-ref -q refs/remotes/local/master || git-fetch local) &&
+     (git show-ref -q refs/remotes/local/master || git fetch local) &&
      git branch my3 local/master &&
@@ -159,3 +159,3 @@ test_expect_success 'test overriding tracking setup via --no-track' \
      git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-     (git show-ref -q refs/remotes/local/master || git-fetch local) &&
+     (git show-ref -q refs/remotes/local/master || git fetch local) &&
      git branch --no-track my2 local/master &&
@@ -175,3 +175,3 @@ test_expect_success 'test tracking setup via --track but deeper' \
      git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-     (git show-ref -q refs/remotes/local/o/o || git-fetch local) &&
+     (git show-ref -q refs/remotes/local/o/o || git fetch local) &&
      git branch --track my7 local/o/o &&
@@ -211,3 +211,3 @@ test_expect_success \
 	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
-     git-checkout -b g/h/i -l master &&
+     git checkout -b g/h/i -l master &&
 	 test -f .git/refs/heads/g/h/i &&
@@ -230,3 +230,3 @@ test_expect_success 'autosetuprebase local on a tracked local branch' '
 	git config branch.autosetuprebase local &&
-	(git show-ref -q refs/remotes/local/o || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase &&
@@ -242,3 +242,3 @@ test_expect_success 'autosetuprebase always on a tracked local branch' '
 	git config branch.autosetuprebase always &&
-	(git show-ref -q refs/remotes/local/o || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase2 &&
@@ -254,3 +254,3 @@ test_expect_success 'autosetuprebase remote on a tracked local branch' '
 	git config branch.autosetuprebase remote &&
-	(git show-ref -q refs/remotes/local/o || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase3 &&
@@ -266,3 +266,3 @@ test_expect_success 'autosetuprebase never on a tracked local branch' '
 	git config branch.autosetuprebase never &&
-	(git show-ref -q refs/remotes/local/o || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase4 &&
@@ -278,3 +278,3 @@ test_expect_success 'autosetuprebase local on a tracked remote branch' '
 	git config branch.autosetuprebase local &&
-	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr5 local/master &&
@@ -289,3 +289,3 @@ test_expect_success 'autosetuprebase never on a tracked remote branch' '
 	git config branch.autosetuprebase never &&
-	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr6 local/master &&
@@ -300,3 +300,3 @@ test_expect_success 'autosetuprebase remote on a tracked remote branch' '
 	git config branch.autosetuprebase remote &&
-	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr7 local/master &&
@@ -311,3 +311,3 @@ test_expect_success 'autosetuprebase always on a tracked remote branch' '
 	git config branch.autosetuprebase remote &&
-	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr8 local/master &&
@@ -322,3 +322,3 @@ test_expect_success 'autosetuprebase unconfigured on a tracked remote branch' '
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --track myr9 local/master &&
@@ -332,3 +332,3 @@ test_expect_success 'autosetuprebase unconfigured on a tracked local branch' '
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/o || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/o || git fetch local) &&
 	git branch mybase10 &&
@@ -343,3 +343,3 @@ test_expect_success 'autosetuprebase unconfigured on untracked local branch' '
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr11 mybase2 &&
@@ -353,3 +353,3 @@ test_expect_success 'autosetuprebase unconfigured on untracked remote branch' '
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr12 local/master &&
@@ -364,3 +364,3 @@ test_expect_success 'autosetuprebase never on an untracked local branch' '
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr13 mybase2 &&
@@ -375,3 +375,3 @@ test_expect_success 'autosetuprebase local on an untracked local branch' '
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr14 mybase2 &&
@@ -386,3 +386,3 @@ test_expect_success 'autosetuprebase remote on an untracked local branch' '
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr15 mybase2 &&
@@ -397,3 +397,3 @@ test_expect_success 'autosetuprebase always on an untracked local branch' '
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr16 mybase2 &&
@@ -408,3 +408,3 @@ test_expect_success 'autosetuprebase never on an untracked remote branch' '
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr17 local/master &&
@@ -419,3 +419,3 @@ test_expect_success 'autosetuprebase local on an untracked remote branch' '
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr18 local/master &&
@@ -430,3 +430,3 @@ test_expect_success 'autosetuprebase remote on an untracked remote branch' '
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr19 local/master &&
@@ -441,3 +441,3 @@ test_expect_success 'autosetuprebase always on an untracked remote branch' '
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git-fetch local) &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
 	git branch --no-track myr20 local/master &&
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index c2dec1c..087ef75 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -19,3 +19,3 @@ test_expect_success \
      git update-index --add A &&
-     git-commit -m "Initial commit." &&
+     git commit -m "Initial commit." &&
      HEAD=$(git rev-parse --verify HEAD)'
@@ -99,3 +99,3 @@ test_expect_success \
 test_expect_success 'pack, prune and repack' '
-	git-tag foo &&
+	git tag foo &&
 	git pack-refs --all --prune &&
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 91bb5e1..b7a670e 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -18,3 +18,3 @@ test_expect_success \
      git update-index --add A &&
-     git-commit -m "Add A." &&
+     git commit -m "Add A." &&
      git checkout -b my-topic-branch &&
@@ -22,3 +22,3 @@ test_expect_success \
      git update-index --add B &&
-     git-commit -m "Add B." &&
+     git commit -m "Add B." &&
      git checkout -f master &&
@@ -26,3 +26,3 @@ test_expect_success \
      git update-index A &&
-     git-commit -m "Modify A." &&
+     git commit -m "Modify A." &&
      git checkout -b side my-topic-branch &&
diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
index 166ddb1..aea6685 100755
--- a/t/t3401-rebase-partial.sh
+++ b/t/t3401-rebase-partial.sh
@@ -17,5 +17,5 @@ test_expect_success \
      git update-index --add A &&
-     git-commit -m "Add A." &&
+     git commit -m "Add A." &&
 
-     git-checkout -b my-topic-branch &&
+     git checkout -b my-topic-branch &&
 
@@ -23,3 +23,3 @@ test_expect_success \
      git update-index --add B &&
-     git-commit -m "Add B." &&
+     git commit -m "Add B." &&
 
@@ -27,5 +27,5 @@ test_expect_success \
      git update-index --add C &&
-     git-commit -m "Add C." &&
+     git commit -m "Add C." &&
 
-     git-checkout -f master &&
+     git checkout -f master &&
 
@@ -33,3 +33,3 @@ test_expect_success \
      git update-index A &&
-     git-commit -m "Modify A."
+     git commit -m "Modify A."
 '
@@ -39,3 +39,3 @@ test_expect_success \
     'git cherry-pick my-topic-branch^0 &&
-     git-checkout -f my-topic-branch &&
+     git checkout -f my-topic-branch &&
      git branch master-merge master &&
@@ -51,4 +51,4 @@ test_debug \
 test_expect_success \
-    'rebase topic branch against new master and check git-am did not get halted' \
-    'git-rebase master && test ! -d .git/rebase-apply'
+    'rebase topic branch against new master and check git am did not get halted' \
+    'git rebase master && test ! -d .git/rebase-apply'
 
@@ -56,4 +56,4 @@ test_expect_success \
 	'rebase --merge topic branch that was partially merged upstream' \
-	'git-checkout -f my-topic-branch-merge &&
-	 git-rebase --merge master-merge &&
+	'git checkout -f my-topic-branch-merge &&
+	 git rebase --merge master-merge &&
 	 test ! -d .git/rebase-merge'
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index 0d33c71..64446e3 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -9,3 +9,3 @@ test_description='git rebase --merge --skip tests'
 
-# we assume the default git-am -3 --skip strategy is tested independently
+# we assume the default git am -3 --skip strategy is tested independently
 # and always works :)
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 5aa487a..e0ded19 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -163,3 +163,3 @@ test_expect_success 'stop on conflicting pick' '
 	test_cmp expect2 file1 &&
-	test "$(git-diff --name-status |
+	test "$(git diff --name-status |
 		sed -n -e "/^U/s/^U[^a-z]*//p")" = file1 &&
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 4de550a..2999e78 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -54,3 +54,3 @@ testrebase() {
 		test $(git rev-parse HEAD) = $(git rev-parse master) &&
-		git-rebase --abort &&
+		git rebase --abort &&
 		test $(git rev-parse to-rebase) = $(git rev-parse pre-rebase) &&
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index 4911c48..dadbbc2 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -19,5 +19,5 @@ test_expect_success \
      git update-index --add A &&
-     git-commit -m "Add A." &&
+     git commit -m "Add A." &&
 
-     git-checkout -b my-topic-branch &&
+     git checkout -b my-topic-branch &&
 
@@ -25,3 +25,3 @@ test_expect_success \
      git update-index --add B &&
-     git-commit -m "Add B." &&
+     git commit -m "Add B." &&
 
@@ -30,5 +30,5 @@ test_expect_success \
      git update-index --add C &&
-     git-commit -m "Add C." &&
+     git commit -m "Add C." &&
 
-     git-checkout -f master &&
+     git checkout -f master &&
      rm -f B C &&
@@ -37,3 +37,3 @@ test_expect_success \
      git update-index A &&
-     git-commit -m "Modify A." &&
+     git commit -m "Modify A." &&
 
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index c851db8..6fb027b 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -4,3 +4,3 @@
 
-test_description='git-mktag: tag object verify test'
+test_description='git mktag: tag object verify test'
 
@@ -16,3 +16,3 @@ check_verify_failure () {
 	test_expect_success "$1" '
-		( test_must_fail git-mktag <tag.sig 2>message ) &&
+		( test_must_fail git mktag <tag.sig 2>message ) &&
 		grep "$expect" message
@@ -26,3 +26,3 @@ echo Hello >A
 git update-index --add A
-git-commit -m "Initial commit"
+git commit -m "Initial commit"
 head=$(git rev-parse --verify HEAD)
@@ -224,3 +224,3 @@ test_expect_success \
     'allow empty tag email' \
-    'git-mktag <tag.sig >.git/refs/tags/mytag 2>message'
+    'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
 
@@ -352,3 +352,3 @@ test_expect_success \
     'create valid tag' \
-    'git-mktag <tag.sig >.git/refs/tags/mytag 2>message'
+    'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
 
@@ -359,3 +359,3 @@ test_expect_success \
     'check mytag' \
-    'git-tag -l | grep mytag'
+    'git tag -l | grep mytag'
 
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index f4f4184..784c31a 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -20,3 +20,3 @@ test_expect_success setup '
 	git update-ref HEAD $C &&
-	git-tag C0
+	git tag C0
 '
@@ -32,5 +32,5 @@ do
 		git config i18n.commitencoding $H &&
-		git-checkout -b $H C0 &&
+		git checkout -b $H C0 &&
 		echo $H >F &&
-		git-commit -a -F "$TEST_DIRECTORY"/t3900/$H.txt
+		git commit -a -F "$TEST_DIRECTORY"/t3900/$H.txt
 	'
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index f68ff53..7655da3 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -105,3 +105,3 @@ test_expect_success 'rebase (U/U)' '
 	git checkout -b test &&
-	git-rebase master &&
+	git rebase master &&
 
@@ -116,3 +116,3 @@ test_expect_success 'rebase (U/L)' '
 	git reset --hard side &&
-	git-rebase master &&
+	git rebase master &&
 
@@ -128,3 +128,3 @@ test_expect_success 'rebase (L/L)' '
 	git reset --hard side &&
-	git-rebase master &&
+	git rebase master &&
 
@@ -141,3 +141,3 @@ test_expect_success 'rebase (L/U)' '
 	git reset --hard side &&
-	git-rebase master &&
+	git rebase master &&
 
@@ -213,3 +213,3 @@ test_expect_success 'rebase --merge (U/U)' '
 	git reset --hard side &&
-	git-rebase --merge master &&
+	git rebase --merge master &&
 
@@ -224,3 +224,3 @@ test_expect_success 'rebase --merge (U/L)' '
 	git reset --hard side &&
-	git-rebase --merge master &&
+	git rebase --merge master &&
 
@@ -236,3 +236,3 @@ test_expect_success 'rebase --merge (L/L)' '
 	git reset --hard side &&
-	git-rebase --merge master &&
+	git rebase --merge master &&
 
@@ -249,3 +249,3 @@ test_expect_success 'rebase --merge (L/U)' '
 	git reset --hard side &&
-	git-rebase --merge master &&
+	git rebase --merge master &&
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 8d4804b..7484cbe 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -5,3 +5,3 @@
 
-test_description='Test git-stash'
+test_description='Test git stash'
 
-- 
1.6.0.1

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
