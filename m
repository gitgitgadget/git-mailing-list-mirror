From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 2/4] tests: use "git xyzzy" form (t3600 - t6999)
Date: Wed, 03 Sep 2008 17:59:29 +0900
Message-ID: <20080903175929.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 11:01:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaoF2-00011w-0k
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 11:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbYICJAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 05:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbYICJAJ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 05:00:09 -0400
Received: from karen.lavabit.com ([72.249.41.33]:36032 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695AbYICJAC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 05:00:02 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 93C5EC8903;
	Wed,  3 Sep 2008 03:59:52 -0500 (CDT)
Received: from 8115.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id RDIH7U4LN0I4; Wed, 03 Sep 2008 04:00:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=1NdpYPbi1z9S1M7sUnKlvrB3R8KQoHeaOa57wlSMaRcyxHvbLnvESBt4k8WDEmKgXi0ux6nhnLUoHhp46GFkS28r/mHz83jj8pv9dovVvJp5S7/e8WPg+DVFIs1ZPMEaFzNbV6iSS09/KFdYyONvHKFuRKnDqIVnYaXvGNBGz8g=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94768>

Converts tests between t3600-t6300.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 t/t3600-rm.sh                 |    4 ++--
 t/t4012-diff-binary.sh        |    4 ++--
 t/t4103-apply-binary.sh       |   26 +++++++++++++-------------
 t/t4124-apply-ws-rule.sh      |    2 +-
 t/t4127-apply-same-fn.sh      |    4 ++--
 t/t4150-am.sh                 |    2 +-
 t/t4151-am-abort.sh           |    4 ++--
 t/t5300-pack-object.sh        |   14 +++++++-------
 t/t5301-sliding-window.sh     |    4 ++--
 t/t5302-pack-index.sh         |   12 ++++++------
 t/t5400-send-pack.sh          |   30 +++++++++++++++---------------
 t/t5401-update-hooks.sh       |    4 ++--
 t/t5402-post-merge-hook.sh    |    4 ++--
 t/t5403-post-checkout-hook.sh |    4 ++--
 t/t5500-fetch-pack.sh         |    4 ++--
 t/t5510-fetch.sh              |    2 +-
 t/t5530-upload-pack-error.sh  |    4 ++--
 t/t5600-clone-fail-cleanup.sh |   12 ++++++------
 t/t5602-clone-remote-exec.sh  |    4 ++--
 t/t6006-rev-list-format.sh    |    6 +++---
 t/t6025-merge-symlinks.sh     |   32 ++++++++++++++++----------------
 t/t6026-merge-attr.sh         |   12 ++++++------
 t/t6030-bisect-porcelain.sh   |    4 ++--
 t/t6120-describe.sh           |   30 +++++++++++++++---------------
 t/t6300-for-each-ref.sh       |   28 ++++++++++++++--------------
 25 files changed, 128 insertions(+), 128 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 79c06ad..558c80e 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -14,3 +14,3 @@ test_expect_success \
      git add -- foo bar baz 'space embedded' -q &&
-     git-commit -m 'add normal files' &&
+     git commit -m 'add normal files' &&
      test_tabs=y &&
@@ -21,3 +21,3 @@ embedded'
 embedded' &&
-     git-commit -m 'add files with tabs and newlines'
+     git commit -m 'add files with tabs and newlines'
      else
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 6993499..b8ec6e9 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -63,3 +63,3 @@ test_expect_success 'apply detecting corrupt patch correctly' \
 
-test_expect_success 'initial commit' 'git-commit -a -m initial'
+test_expect_success 'initial commit' 'git commit -a -m initial'
 
@@ -74,3 +74,3 @@ test_expect_success 'diff-index with --binary' \
 test_expect_success 'apply binary patch' \
-	'git-reset --hard &&
+	'git reset --hard &&
 	 git apply --binary --index <current &&
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index 7da0b4b..ad4cc1a 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -23,5 +23,5 @@ cat file1 >file4
 git update-index --add --remove file1 file2 file4
-git-commit -m 'Initial Version' 2>/dev/null
+git commit -m 'Initial Version' 2>/dev/null
 
-git-checkout -b binary
+git checkout -b binary
 perl -pe 'y/x/\000/' <file1 >file3
@@ -32,3 +32,3 @@ rm -f file2
 git update-index --add --remove file1 file2 file3 file4
-git-commit -m 'Second Version'
+git commit -m 'Second Version'
 
@@ -41,3 +41,3 @@ git diff-tree -p --binary -C master binary >CF.diff
 test_expect_success 'stat binary diff -- should not fail.' \
-	'git-checkout master
+	'git checkout master
 	 git apply --stat --summary B.diff'
@@ -45,3 +45,3 @@ test_expect_success 'stat binary diff -- should not fail.' \
 test_expect_success 'stat binary diff (copy) -- should not fail.' \
-	'git-checkout master
+	'git checkout master
 	 git apply --stat --summary C.diff'
@@ -49,3 +49,3 @@ test_expect_success 'stat binary diff (copy) -- should not fail.' \
 test_expect_success 'check binary diff -- should fail.' \
-	'git-checkout master &&
+	'git checkout master &&
 	 test_must_fail git apply --check B.diff'
@@ -53,3 +53,3 @@ test_expect_success 'check binary diff -- should fail.' \
 test_expect_success 'check binary diff (copy) -- should fail.' \
-	'git-checkout master &&
+	'git checkout master &&
 	 test_must_fail git apply --check C.diff'
@@ -58,3 +58,3 @@ test_expect_success \
 	'check incomplete binary diff with replacement -- should fail.' '
-	git-checkout master &&
+	git checkout master &&
 	test_must_fail git apply --check --allow-binary-replacement B.diff
@@ -64,3 +64,3 @@ test_expect_success \
     'check incomplete binary diff with replacement (copy) -- should fail.' '
-	 git-checkout master &&
+	 git checkout master &&
 	 test_must_fail git apply --check --allow-binary-replacement C.diff
@@ -69,3 +69,3 @@ test_expect_success \
 test_expect_success 'check binary diff with replacement.' \
-	'git-checkout master
+	'git checkout master
 	 git apply --check --allow-binary-replacement BF.diff'
@@ -73,3 +73,3 @@ test_expect_success 'check binary diff with replacement.' \
 test_expect_success 'check binary diff with replacement (copy).' \
-	'git-checkout master
+	'git checkout master
 	 git apply --check --allow-binary-replacement CF.diff'
@@ -80,4 +80,4 @@ do_reset () {
 	rm -f file? &&
-	git-reset --hard &&
-	git-checkout -f master
+	git reset --hard &&
+	git checkout -f master
 }
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 85f3da2..f83322e 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -2,3 +2,3 @@
 
-test_description='core.whitespace rules and git-apply'
+test_description='core.whitespace rules and git apply'
 
diff --git a/t/t4127-apply-same-fn.sh b/t/t4127-apply-same-fn.sh
index 1f859dd..3a8202e 100755
--- a/t/t4127-apply-same-fn.sh
+++ b/t/t4127-apply-same-fn.sh
@@ -28,3 +28,3 @@ test_expect_success 'apply same filename with independent changes' '
 	git reset --hard &&
-	git-apply patch0 &&
+	git apply patch0 &&
 	diff same_fn same_fn2
@@ -41,3 +41,3 @@ test_expect_success 'apply same filename with overlapping changes' '
 	git reset --hard &&
-	git-apply patch0 &&
+	git apply patch0 &&
 	diff same_fn same_fn2
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 6e6aaf5..1be5fb3 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -166,3 +166,3 @@ test_expect_success 'am --keep really keeps the subject' '
 	! test -d .git/rebase-apply &&
-	git-cat-file commit HEAD |
+	git cat-file commit HEAD |
 		grep -q -F "Re: Re: Re: [PATCH 1/5 v2] third"
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 7d86cdf..4448aba 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -46,3 +46,3 @@ do
 	test_expect_success "am$with3 --skip continue after failed am$with3" '
-		test_must_fail git-am$with3 --skip >output &&
+		test_must_fail git am$with3 --skip >output &&
 		test "$(grep "^Applying" output)" = "Applying: 6" &&
@@ -53,3 +53,3 @@ do
 	test_expect_success "am --abort goes back after failed am$with3" '
-		git-am --abort &&
+		git am --abort &&
 		git rev-parse HEAD >actual &&
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 83abe5f..0c14003 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -244,6 +244,6 @@ test_expect_success \
     'cat test-1-${packname_1}.pack >test-3.pack &&
-     git-index-pack -o tmp.idx test-3.pack &&
+     git index-pack -o tmp.idx test-3.pack &&
      cmp tmp.idx test-1-${packname_1}.idx &&
 
-     git-index-pack test-3.pack &&
+     git index-pack test-3.pack &&
      cmp test-3.idx test-1-${packname_1}.idx &&
@@ -251,6 +251,6 @@ test_expect_success \
      cat test-2-${packname_2}.pack >test-3.pack &&
-     git-index-pack -o tmp.idx test-2-${packname_2}.pack &&
+     git index-pack -o tmp.idx test-2-${packname_2}.pack &&
      cmp tmp.idx test-2-${packname_2}.idx &&
 
-     git-index-pack test-3.pack &&
+     git index-pack test-3.pack &&
      cmp test-3.idx test-2-${packname_2}.idx &&
@@ -258,6 +258,6 @@ test_expect_success \
      cat test-3-${packname_3}.pack >test-3.pack &&
-     git-index-pack -o tmp.idx test-3-${packname_3}.pack &&
+     git index-pack -o tmp.idx test-3-${packname_3}.pack &&
      cmp tmp.idx test-3-${packname_3}.idx &&
 
-     git-index-pack test-3.pack &&
+     git index-pack test-3.pack &&
      cmp test-3.idx test-3-${packname_3}.idx &&
@@ -274,3 +274,3 @@ test_expect_success \
     'make sure index-pack detects the SHA1 collision' \
-    'test_must_fail git-index-pack -o bad.idx test-3.pack'
+    'test_must_fail git index-pack -o bad.idx test-3.pack'
 
diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index 073ac0c..0a24e61 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -21,3 +21,3 @@ test_expect_success \
      git update-ref HEAD $commit1 &&
-     git-repack -a -d &&
+     git repack -a -d &&
      test "`git count-objects`" = "0 objects, 0 kilobytes" &&
@@ -47,3 +47,3 @@ test_expect_success \
      git update-ref HEAD $commit2 &&
-     git-repack -a -d &&
+     git repack -a -d &&
      test "`git count-objects`" = "0 objects, 0 kilobytes" &&
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 0639772..6424db1 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -50,3 +50,3 @@ test_expect_success \
     'index-pack with index version 1' \
-    'git-index-pack --index-version=1 -o 1.idx "test-1-${pack1}.pack"'
+    'git index-pack --index-version=1 -o 1.idx "test-1-${pack1}.pack"'
 
@@ -54,3 +54,3 @@ test_expect_success \
     'index-pack with index version 2' \
-    'git-index-pack --index-version=2 -o 2.idx "test-1-${pack1}.pack"'
+    'git index-pack --index-version=2 -o 2.idx "test-1-${pack1}.pack"'
 
@@ -87,3 +87,3 @@ test_expect_success \
     'index v2: force some 64-bit offsets with index-pack' \
-    'git-index-pack --index-version=2,0x40000 -o 3.idx "test-1-${pack1}.pack"'
+    'git index-pack --index-version=2,0x40000 -o 3.idx "test-1-${pack1}.pack"'
 
@@ -96,3 +96,3 @@ test_expect_success \
     '[index v1] 1) stream pack to repository' \
-    'git-index-pack --index-version=1 --stdin < "test-1-${pack1}.pack" &&
+    'git index-pack --index-version=1 --stdin < "test-1-${pack1}.pack" &&
      git prune-packed &&
@@ -134,3 +134,3 @@ test_expect_success \
     'rm -f .git/objects/pack/* &&
-     git-index-pack --index-version=2 --stdin < "test-1-${pack1}.pack" &&
+     git index-pack --index-version=2 --stdin < "test-1-${pack1}.pack" &&
      git prune-packed &&
@@ -167,3 +167,3 @@ test_expect_success \
     'rm -f .git/objects/pack/* &&
-     git-index-pack --index-version=2 --stdin < "test-1-${pack1}.pack" &&
+     git index-pack --index-version=2 --stdin < "test-1-${pack1}.pack" &&
      git verify-pack ".git/objects/pack/pack-${pack1}.pack" &&
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 68c2ae6..544771d 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -33,3 +33,3 @@ test_expect_success setup '
 	git update-ref HEAD "$commit" &&
-	git-clone ./. victim &&
+	git clone ./. victim &&
 	cd victim &&
@@ -70,3 +70,3 @@ test_expect_success \
 	# should not fail but refuse to update.
-	if git-send-pack ./victim/.git/ master
+	if git send-pack ./victim/.git/ master
 	then
@@ -87,3 +87,3 @@ test_expect_success \
 	# this should update
-	git-send-pack --force ./victim/.git/ master &&
+	git send-pack --force ./victim/.git/ master &&
 	cmp victim/.git/refs/heads/master .git/refs/heads/master
@@ -97,3 +97,3 @@ test_expect_success \
 	test -f victim/.git/refs/heads/extra &&
-	git-send-pack ./victim/.git/ :extra master &&
+	git send-pack ./victim/.git/ :extra master &&
 	! test -f victim/.git/refs/heads/extra
@@ -111,3 +111,3 @@ test_expect_success \
 	git update-ref refs/heads/master master^ || return 1
-	git-send-pack --force ./victim/.git/ master && return 1
+	git send-pack --force ./victim/.git/ master && return 1
 	! test_cmp .git/refs/heads/master victim/.git/refs/heads/master
@@ -118,7 +118,7 @@ test_expect_success \
 	mkdir parent && cd parent &&
-	git-init && touch file && git-add file && git-commit -m add &&
+	git init && touch file && git add file && git commit -m add &&
 	cd .. &&
-	git-clone parent child && cd child && git-push --all &&
+	git clone parent child && cd child && git push --all &&
 	cd ../parent &&
-	git-branch -a >branches && ! grep origin/master branches
+	git branch -a >branches && ! grep origin/master branches
 '
@@ -128,6 +128,6 @@ rewound_push_setup() {
 	mkdir parent && cd parent &&
-	git-init && echo one >file && git-add file && git-commit -m one &&
-	echo two >file && git-commit -a -m two &&
+	git init && echo one >file && git add file && git commit -m one &&
+	echo two >file && git commit -a -m two &&
 	cd .. &&
-	git-clone parent child && cd child && git-reset --hard HEAD^
+	git clone parent child && cd child && git reset --hard HEAD^
 }
@@ -150,3 +150,3 @@ test_expect_success \
 	rewound_push_setup &&
-	if git-send-pack ../parent/.git refs/heads/master:refs/heads/master
+	if git send-pack ../parent/.git refs/heads/master:refs/heads/master
 	then
@@ -156,3 +156,3 @@ test_expect_success \
 	fi && rewound_push_failed &&
-	git-send-pack ../parent/.git +refs/heads/master:refs/heads/master &&
+	git send-pack ../parent/.git +refs/heads/master:refs/heads/master &&
 	rewound_push_succeeded
@@ -163,3 +163,3 @@ test_expect_success \
 	rewound_push_setup &&
-	if git-send-pack ../parent/.git refs/heads/*:refs/heads/*
+	if git send-pack ../parent/.git refs/heads/*:refs/heads/*
 	then
@@ -169,3 +169,3 @@ test_expect_success \
 	fi && rewound_push_failed &&
-	git-send-pack ../parent/.git +refs/heads/*:refs/heads/* &&
+	git send-pack ../parent/.git +refs/heads/*:refs/heads/* &&
 	rewound_push_succeeded
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index ee769d6..64f66c9 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -19,3 +19,3 @@ test_expect_success setup '
 	git update-ref refs/heads/tofail $commit1 &&
-	git-clone ./. victim &&
+	git clone ./. victim &&
 	GIT_DIR=victim/.git git update-ref refs/heads/tofail $commit1 &&
@@ -63,3 +63,3 @@ chmod u+x victim/.git/hooks/post-update
 test_expect_success push '
-	test_must_fail git-send-pack --force ./victim/.git \
+	test_must_fail git send-pack --force ./victim/.git \
 		master tofail >send.out 2>send.err
diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index 1394047..6eb2ffd 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -18,5 +18,5 @@ test_expect_success setup '
         git update-ref refs/heads/master $commit0 &&
-	git-clone ./. clone1 &&
+	git clone ./. clone1 &&
 	GIT_DIR=clone1/.git git update-index --add a &&
-	git-clone ./. clone2 &&
+	git clone ./. clone2 &&
 	GIT_DIR=clone2/.git git update-index --add a
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 823239a..9b2e1a9 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -16,4 +16,4 @@ test_expect_success setup '
         git update-ref refs/heads/master $commit0 &&
-	 git-clone ./. clone1 &&
-	 git-clone ./. clone2 &&
+	 git clone ./. clone1 &&
+	 git clone ./. clone2 &&
         GIT_DIR=clone2/.git git branch -a new2 &&
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 7125bae..c450f33 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -60,3 +60,3 @@ pull_to_client () {
 	test_expect_success "$number pull" \
-		"git-fetch-pack -k -v .. $heads"
+		"git fetch-pack -k -v .. $heads"
 	case "$heads" in *A*) echo $ATIP > .git/refs/heads/A;; esac
@@ -131,3 +131,3 @@ pull_to_client 3rd "A" $((1*3)) # old fails
 
-test_expect_success "clone shallow" 'git-clone --depth 2 "file://$(pwd)/." shallow'
+test_expect_success "clone shallow" 'git clone --depth 2 "file://$(pwd)/." shallow'
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 13d1d82..de26c20 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -113,3 +113,3 @@ test_expect_success 'fetch must not resolve short remote name' '
 	cd "$D" &&
-	git-update-ref refs/remotes/six/HEAD HEAD
+	git update-ref refs/remotes/six/HEAD HEAD
 
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 1a15817..f5102b9 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -36,3 +36,3 @@ test_expect_success 'upload-pack fails due to error in pack-objects' '
 00000009done
-0000" | git-upload-pack . > /dev/null 2> output.err &&
+0000" | git upload-pack . > /dev/null 2> output.err &&
 	grep "pack-objects died" output.err
@@ -54,3 +54,3 @@ test_expect_success 'upload-pack fails due to error in rev-list' '
 00000009done
-0000" | git-upload-pack . > /dev/null 2> output.err &&
+0000" | git upload-pack . > /dev/null 2> output.err &&
 	grep "waitpid (async) failed" output.err
diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index 3c013e2..ee06d28 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -5,5 +5,5 @@
 
-test_description='test git-clone to cleanup after failure
+test_description='test git clone to cleanup after failure
 
-This test covers the fact that if git-clone fails, it should remove
+This test covers the fact that if git clone fails, it should remove
 the directory it created, to avoid the user having to manually
@@ -15,3 +15,3 @@ test_expect_success \
     'clone of non-existent source should fail' \
-    'test_must_fail git-clone foo bar'
+    'test_must_fail git clone foo bar'
 
@@ -27,3 +27,3 @@ test_create_repo foo
 
-# source repository given to git-clone should be relative to the
+# source repository given to git clone should be relative to the
 # current path not to the target dir
@@ -31,3 +31,3 @@ test_expect_success \
     'clone of non-existent (relative to $PWD) source should fail' \
-    'test_must_fail git-clone ../foo baz'
+    'test_must_fail git clone ../foo baz'
 
@@ -35,3 +35,3 @@ test_expect_success \
     'clone should work now that source exists' \
-    'git-clone foo bar'
+    'git clone foo bar'
 
diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.sh
index 8367a68..82b1d1e 100755
--- a/t/t5602-clone-remote-exec.sh
+++ b/t/t5602-clone-remote-exec.sh
@@ -13,3 +13,3 @@ test_expect_success setup '
 
-test_expect_success 'clone calls git-upload-pack unqualified with no -u option' '
+test_expect_success 'clone calls git upload-pack unqualified with no -u option' '
 	GIT_SSH=./not_ssh git clone localhost:/path/to/repo junk
@@ -19,3 +19,3 @@ test_expect_success 'clone calls git-upload-pack unqualified with no -u option'
 
-test_expect_success 'clone calls specified git-upload-pack with -u option' '
+test_expect_success 'clone calls specified git upload-pack with -u option' '
 	GIT_SSH=./not_ssh git clone -u /something/bin/git-upload-pack localhost:/path/to/repo junk
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 485ad4d..86bf7e1 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -8,4 +8,4 @@ test_tick
 test_expect_success 'setup' '
-touch foo && git add foo && git-commit -m "added foo" &&
-  echo changed >foo && git-commit -a -m "changed foo"
+touch foo && git add foo && git commit -m "added foo" &&
+  echo changed >foo && git commit -a -m "changed foo"
 '
@@ -112,3 +112,3 @@ test_expect_success 'setup complex body' '
 git config i18n.commitencoding iso8859-1 &&
-  echo change2 >foo && git-commit -a -F commit-msg
+  echo change2 >foo && git commit -a -F commit-msg
 '
diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
index fc58456..53892a5 100755
--- a/t/t6025-merge-symlinks.sh
+++ b/t/t6025-merge-symlinks.sh
@@ -7,3 +7,3 @@ test_description='merging symlinks on filesystem w/o symlink support.
 
-This tests that git-merge-recursive writes merge results as plain files
+This tests that git merge-recursive writes merge results as plain files
 if core.symlinks is false.'
@@ -17,16 +17,16 @@ git config core.symlinks false &&
 git add file &&
-git-commit -m initial &&
+git commit -m initial &&
 git branch b-symlink &&
 git branch b-file &&
-l=$(echo -n file | git-hash-object -t blob -w --stdin) &&
+l=$(echo -n file | git hash-object -t blob -w --stdin) &&
 echo "120000 $l	symlink" | git update-index --index-info &&
-git-commit -m master &&
-git-checkout b-symlink &&
-l=$(echo -n file-different | git-hash-object -t blob -w --stdin) &&
+git commit -m master &&
+git checkout b-symlink &&
+l=$(echo -n file-different | git hash-object -t blob -w --stdin) &&
 echo "120000 $l	symlink" | git update-index --index-info &&
-git-commit -m b-symlink &&
-git-checkout b-file &&
+git commit -m b-symlink &&
+git checkout b-file &&
 echo plain-file > symlink &&
 git add symlink &&
-git-commit -m b-file'
+git commit -m b-file'
 
@@ -34,4 +34,4 @@ test_expect_success \
 'merge master into b-symlink, which has a different symbolic link' '
-git-checkout b-symlink &&
-test_must_fail git-merge master'
+git checkout b-symlink &&
+test_must_fail git merge master'
 
@@ -43,4 +43,4 @@ test_expect_success \
 'merge master into b-file, which has a file instead of a symbolic link' '
-git-reset --hard && git-checkout b-file &&
-test_must_fail git-merge master'
+git reset --hard && git checkout b-file &&
+test_must_fail git merge master'
 
@@ -52,5 +52,5 @@ test_expect_success \
 'merge b-file, which has a file instead of a symbolic link, into master' '
-git-reset --hard &&
-git-checkout master &&
-test_must_fail git-merge b-file'
+git reset --hard &&
+git checkout master &&
+test_must_fail git merge b-file'
 
diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 56fc341..4b423e9 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -108,5 +108,5 @@ test_expect_success 'custom merge backend' '
 	sed -e 1,3d text >check-1 &&
-	o=$(git-unpack-file master^:text) &&
-	a=$(git-unpack-file side^:text) &&
-	b=$(git-unpack-file master:text) &&
+	o=$(git unpack-file master^:text) &&
+	a=$(git unpack-file side^:text) &&
+	b=$(git unpack-file master:text) &&
 	sh -c "./custom-merge $o $a $b 0" &&
@@ -135,5 +135,5 @@ test_expect_success 'custom merge backend' '
 	sed -e 1,3d text >check-1 &&
-	o=$(git-unpack-file master^:text) &&
-	a=$(git-unpack-file anchor:text) &&
-	b=$(git-unpack-file master:text) &&
+	o=$(git unpack-file master^:text) &&
+	a=$(git unpack-file anchor:text) &&
+	b=$(git unpack-file master:text) &&
 	sh -c "./custom-merge $o $a $b 0" &&
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 244fda6..36c9a69 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -4,3 +4,3 @@
 #
-test_description='Tests git-bisect functionality'
+test_description='Tests git bisect functionality'
 
@@ -25,3 +25,3 @@ add_line_into_file()
     test_tick
-    git-commit --quiet -m "$MSG" $_file
+    git commit --quiet -m "$MSG" $_file
 }
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 2fb672c..16cc635 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -33,3 +33,3 @@ test_expect_success setup '
 	test_tick &&
-	echo one >file && git add file && git-commit -m initial &&
+	echo one >file && git add file && git commit -m initial &&
 	one=$(git rev-parse HEAD) &&
@@ -37,3 +37,3 @@ test_expect_success setup '
 	test_tick &&
-	echo two >file && git add file && git-commit -m second &&
+	echo two >file && git add file && git commit -m second &&
 	two=$(git rev-parse HEAD) &&
@@ -41,13 +41,13 @@ test_expect_success setup '
 	test_tick &&
-	echo three >file && git add file && git-commit -m third &&
+	echo three >file && git add file && git commit -m third &&
 
 	test_tick &&
-	echo A >file && git add file && git-commit -m A &&
+	echo A >file && git add file && git commit -m A &&
 	test_tick &&
-	git-tag -a -m A A &&
+	git tag -a -m A A &&
 
 	test_tick &&
-	echo c >file && git add file && git-commit -m c &&
+	echo c >file && git add file && git commit -m c &&
 	test_tick &&
-	git-tag c &&
+	git tag c &&
 
@@ -55,8 +55,8 @@ test_expect_success setup '
 	test_tick &&
-	echo B >side && git add side && git-commit -m B &&
+	echo B >side && git add side && git commit -m B &&
 	test_tick &&
-	git-tag -a -m B B &&
+	git tag -a -m B B &&
 
 	test_tick &&
-	git-merge -m Merged c &&
+	git merge -m Merged c &&
 	merged=$(git rev-parse HEAD) &&
@@ -65,5 +65,5 @@ test_expect_success setup '
 	test_tick &&
-	echo D >another && git add another && git-commit -m D &&
+	echo D >another && git add another && git commit -m D &&
 	test_tick &&
-	git-tag -a -m D D &&
+	git tag -a -m D D &&
 
@@ -73,3 +73,3 @@ test_expect_success setup '
 	test_tick &&
-	git-tag e &&
+	git tag e &&
 
@@ -79,3 +79,3 @@ test_expect_success setup '
 	test_tick &&
-	git-merge -m Merged $merged &&
+	git merge -m Merged $merged &&
 
@@ -83,3 +83,3 @@ test_expect_success setup '
 	echo X >file && echo X >side && git add file side &&
-	git-commit -m x
+	git commit -m x
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 8ced593..26995b3 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -99,3 +99,3 @@ test_atom tag contents 'Tagging at 1151939927
 test_expect_success 'Check invalid atoms names are errors' '
-	test_must_fail git-for-each-ref --format="%(INVALID)" refs/heads
+	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
 '
@@ -103,6 +103,6 @@ test_expect_success 'Check invalid atoms names are errors' '
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
-	git-for-each-ref --format="%(authordate)" refs/heads &&
-	git-for-each-ref --format="%(authordate:default) %(authordate)" refs/heads &&
-	git-for-each-ref --format="%(authordate) %(authordate:default)" refs/heads &&
-	git-for-each-ref --format="%(authordate:default) %(authordate:default)" refs/heads
+	git for-each-ref --format="%(authordate)" refs/heads &&
+	git for-each-ref --format="%(authordate:default) %(authordate)" refs/heads &&
+	git for-each-ref --format="%(authordate) %(authordate:default)" refs/heads &&
+	git for-each-ref --format="%(authordate:default) %(authordate:default)" refs/heads
 '
@@ -110,8 +110,8 @@ test_expect_success 'Check format specifiers are ignored in naming date atoms' '
 test_expect_success 'Check valid format specifiers for date fields' '
-	git-for-each-ref --format="%(authordate:default)" refs/heads &&
-	git-for-each-ref --format="%(authordate:relative)" refs/heads &&
-	git-for-each-ref --format="%(authordate:short)" refs/heads &&
-	git-for-each-ref --format="%(authordate:local)" refs/heads &&
-	git-for-each-ref --format="%(authordate:iso8601)" refs/heads &&
-	git-for-each-ref --format="%(authordate:rfc2822)" refs/heads
+	git for-each-ref --format="%(authordate:default)" refs/heads &&
+	git for-each-ref --format="%(authordate:relative)" refs/heads &&
+	git for-each-ref --format="%(authordate:short)" refs/heads &&
+	git for-each-ref --format="%(authordate:local)" refs/heads &&
+	git for-each-ref --format="%(authordate:iso8601)" refs/heads &&
+	git for-each-ref --format="%(authordate:rfc2822)" refs/heads
 '
@@ -119,3 +119,3 @@ test_expect_success 'Check valid format specifiers for date fields' '
 test_expect_success 'Check invalid format specifiers are errors' '
-	test_must_fail git-for-each-ref --format="%(authordate:INVALID)" refs/heads
+	test_must_fail git for-each-ref --format="%(authordate:INVALID)" refs/heads
 '
@@ -209,3 +209,3 @@ EOF
 test_expect_success 'Verify ascending sort' '
-	git-for-each-ref --format="%(refname)" --sort=refname >actual &&
+	git for-each-ref --format="%(refname)" --sort=refname >actual &&
 	test_cmp expected actual
@@ -220,3 +220,3 @@ EOF
 test_expect_success 'Verify descending sort' '
-	git-for-each-ref --format="%(refname)" --sort=-refname >actual &&
+	git for-each-ref --format="%(refname)" --sort=-refname >actual &&
 	test_cmp expected actual
-- 
1.6.0.1

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
