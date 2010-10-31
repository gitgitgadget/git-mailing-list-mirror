From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/10] tests: add missing &&, batch 2
Date: Sun, 31 Oct 2010 02:30:58 -0500
Message-ID: <20101031073058.GB11483@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
 <20101031014654.GC29456@burratino>
 <7vr5f73umz.fsf@alter.siamese.dyndns.org>
 <20101031072640.GA11483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 08:32:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCSOd-00041v-Qo
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 08:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554Ab0JaHbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 03:31:12 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54040 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab0JaHbK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 03:31:10 -0400
Received: by yxk8 with SMTP id 8so2331797yxk.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=busv++LeREmkgc3jOf09UzQI3V9QL+l+ewSwqiHJR3w=;
        b=k9JQmFBXelcQdOpi2mfpiHxf9IVqOcf3+hYQodBRuux41GtZjQlZJr3UpHIjS9axPw
         2/vQbNy3Cw5hHngXpstCau5w3kMsM0AsmKS4PklA4WxfrD0KX/6nUJRTrQ9+F4vlrpMr
         RRIZms93WRoqidWfEpVruGYyNM44c6I6PCOYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hlniKS6fVgfr5xYzDttf9pvXaEuVpLqIhlyKvBfW8Q3UMvp/wBk/SHJsxKIoW6ckwh
         wSqFivValW6Wy5VogF/p1S72MesXPjAgIq6ITS0RolXNtZh+ko2s0O4bXrct5HHZWgvP
         IBd1gqSI5WLoNJH/U3cJ+6qBtXA9jDQ2rlx10=
Received: by 10.151.51.9 with SMTP id d9mr25619650ybk.89.1288510269578;
        Sun, 31 Oct 2010 00:31:09 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 43sm3799525yhl.37.2010.10.31.00.31.05
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 00:31:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101031072640.GA11483@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160420>

Same rules as before: this patch only adds " &&" to the end of
some lines in the test suite.

Intended to be applied on top of or squashed with the last
batch if they look okay.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t0020-crlf.sh               |    2 +-
 t/t1400-update-ref.sh         |   20 ++++++++++----------
 t/t3301-notes.sh              |    6 +++---
 t/t3404-rebase-interactive.sh |    6 +++---
 t/t4124-apply-ws-rule.sh      |    6 +++---
 t/t5503-tagfollow.sh          |    6 +++---
 t/t5701-clone-local.sh        |    6 +++---
 t/t7001-mv.sh                 |    2 +-
 t/t7004-tag.sh                |   30 +++++++++++++++---------------
 t/t7300-clean.sh              |    2 +-
 t/t7502-commit.sh             |    2 +-
 t/t7700-repack.sh             |    6 +++---
 t/t9146-git-svn-empty-dirs.sh |    2 +-
 13 files changed, 48 insertions(+), 48 deletions(-)

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
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 54ba3df..d17551e 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -185,55 +185,55 @@ gd="Thu, 26 May 2005 18:33:00 -0500"
 ld="Thu, 26 May 2005 18:43:00 -0500"
 test_expect_success \
 	'Query "master@{May 25 2005}" (before history)' \
-	'rm -f o e
+	'rm -f o e &&
 	 git rev-parse --verify "master@{May 25 2005}" >o 2>e &&
 	 test '"$C"' = $(cat o) &&
 	 test "warning: Log for '\'master\'' only goes back to $ed." = "$(cat e)"'
 test_expect_success \
 	"Query master@{2005-05-25} (before history)" \
-	'rm -f o e
+	'rm -f o e &&
 	 git rev-parse --verify master@{2005-05-25} >o 2>e &&
 	 test '"$C"' = $(cat o) &&
 	 echo test "warning: Log for '\'master\'' only goes back to $ed." = "$(cat e)"'
 test_expect_success \
 	'Query "master@{May 26 2005 23:31:59}" (1 second before history)' \
-	'rm -f o e
+	'rm -f o e &&
 	 git rev-parse --verify "master@{May 26 2005 23:31:59}" >o 2>e &&
 	 test '"$C"' = $(cat o) &&
 	 test "warning: Log for '\''master'\'' only goes back to $ed." = "$(cat e)"'
 test_expect_success \
 	'Query "master@{May 26 2005 23:32:00}" (exactly history start)' \
-	'rm -f o e
+	'rm -f o e &&
 	 git rev-parse --verify "master@{May 26 2005 23:32:00}" >o 2>e &&
 	 test '"$C"' = $(cat o) &&
 	 test "" = "$(cat e)"'
 test_expect_success \
 	'Query "master@{May 26 2005 23:32:30}" (first non-creation change)' \
-	'rm -f o e
+	'rm -f o e &&
 	 git rev-parse --verify "master@{May 26 2005 23:32:30}" >o 2>e &&
 	 test '"$A"' = $(cat o) &&
 	 test "" = "$(cat e)"'
 test_expect_success \
 	'Query "master@{2005-05-26 23:33:01}" (middle of history with gap)' \
-	'rm -f o e
+	'rm -f o e &&
 	 git rev-parse --verify "master@{2005-05-26 23:33:01}" >o 2>e &&
 	 test '"$B"' = $(cat o) &&
 	 test "warning: Log .git/logs/'"$m has gap after $gd"'." = "$(cat e)"'
 test_expect_success \
 	'Query "master@{2005-05-26 23:38:00}" (middle of history)' \
-	'rm -f o e
+	'rm -f o e &&
 	 git rev-parse --verify "master@{2005-05-26 23:38:00}" >o 2>e &&
 	 test '"$Z"' = $(cat o) &&
 	 test "" = "$(cat e)"'
 test_expect_success \
 	'Query "master@{2005-05-26 23:43:00}" (exact end of history)' \
-	'rm -f o e
+	'rm -f o e &&
 	 git rev-parse --verify "master@{2005-05-26 23:43:00}" >o 2>e &&
 	 test '"$E"' = $(cat o) &&
 	 test "" = "$(cat e)"'
 test_expect_success \
 	'Query "master@{2005-05-28}" (past end of history)' \
-	'rm -f o e
+	'rm -f o e &&
 	 git rev-parse --verify "master@{2005-05-28}" >o 2>e &&
 	 test '"$D"' = $(cat o) &&
 	 test "warning: Log .git/logs/'"$m unexpectedly ended on $ld"'." = "$(cat e)"'
@@ -247,7 +247,7 @@ test_expect_success \
      git add F &&
 	 GIT_AUTHOR_DATE="2005-05-26 23:30" \
 	 GIT_COMMITTER_DATE="2005-05-26 23:30" git commit -m add -a &&
-	 h_TEST=$(git rev-parse --verify HEAD)
+	 h_TEST=$(git rev-parse --verify HEAD) &&
 	 echo The other day this did not work. >M &&
 	 echo And then Bob told me how to fix it. >>M &&
 	 echo OTHER >F &&
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index a2b79a0..6931171 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -627,16 +627,16 @@ test_expect_success '--show-notes=ref accumulates' '
 
 test_expect_success 'Allow notes on non-commits (trees, blobs, tags)' '
 	git config core.notesRef refs/notes/other &&
-	echo "Note on a tree" > expect
+	echo "Note on a tree" > expect &&
 	git notes add -m "Note on a tree" HEAD: &&
 	git notes show HEAD: > actual &&
 	test_cmp expect actual &&
-	echo "Note on a blob" > expect
+	echo "Note on a blob" > expect &&
 	filename=$(git ls-tree --name-only HEAD | head -n1) &&
 	git notes add -m "Note on a blob" HEAD:$filename &&
 	git notes show HEAD:$filename > actual &&
 	test_cmp expect actual &&
-	echo "Note on a tag" > expect
+	echo "Note on a tag" > expect &&
 	git tag -a -m "This is an annotated tag" foobar HEAD^ &&
 	git notes add -m "Note on a tag" foobar &&
 	git notes show foobar > actual &&
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7d20a74..c0e69f6 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -46,7 +46,7 @@ test_expect_success 'setup' '
 	test_commit G file1 &&
 	test_commit H file5 &&
 	git checkout -b branch2 F &&
-	test_commit I file6
+	test_commit I file6 &&
 	git checkout -b conflict-branch A &&
 	for n in one two three four
 	do
@@ -584,7 +584,7 @@ test_expect_success 'do "noop" when there is nothing to cherry-pick' '
 
 	git checkout -b branch4 HEAD &&
 	GIT_EDITOR=: git commit --amend \
-		--author="Somebody else <somebody@else.com>" 
+		--author="Somebody else <somebody@else.com>" &&
 	test $(git rev-parse branch3) != $(git rev-parse branch4) &&
 	git rebase -i branch3 &&
 	test $(git rev-parse branch3) = $(git rev-parse branch4)
@@ -599,7 +599,7 @@ test_expect_success 'submodule rebase setup' '
 		git add elif && git commit -m "submodule initial"
 	) &&
 	echo 1 >file1 &&
-	git add file1 sub
+	git add file1 sub &&
 	test_tick &&
 	git commit -m "One" &&
 	echo 2 >file1 &&
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 8a676a5..414b09b 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -368,7 +368,7 @@ test_expect_success 'missing blanks at EOF must only match blank lines' '
 	git diff -- one >patch &&
 
 	echo a >one &&
-	test_must_fail git apply patch
+	test_must_fail git apply patch &&
 	test_must_fail git apply --whitespace=fix patch &&
 	test_must_fail git apply --ignore-space-change --whitespace=fix patch
 '
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
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 8a298a6..7f6d3d2 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -54,7 +54,7 @@ EOF
 '
 
 test_expect_success NOT_MINGW 'fetch A (new commit : 1 connection)' '
-	rm -f $U
+	rm -f $U &&
 	(
 		cd cloned &&
 		GIT_DEBUG_SEND_PACK=3 git fetch 3>../$U &&
@@ -87,7 +87,7 @@ EOF
 '
 
 test_expect_success NOT_MINGW 'fetch C, T (new branch, tag : 1 connection)' '
-	rm -f $U
+	rm -f $U &&
 	(
 		cd cloned &&
 		GIT_DEBUG_SEND_PACK=3 git fetch 3>../$U &&
@@ -126,7 +126,7 @@ EOF
 '
 
 test_expect_success NOT_MINGW 'fetch B, S (commit and tag : 1 connection)' '
-	rm -f $U
+	rm -f $U &&
 	(
 		cd cloned &&
 		GIT_DEBUG_SEND_PACK=3 git fetch 3>../$U &&
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 8b4c356..0f4d487 100755
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
 
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 624e6d2..a845b15 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -207,7 +207,7 @@ test_expect_success 'git mv should not change sha1 of moved cache entry' '
 	git init &&
 	echo 1 >dirty &&
 	git add dirty &&
-	entry="$(git ls-files --stage dirty | cut -f 1)"
+	entry="$(git ls-files --stage dirty | cut -f 1)" &&
 	git mv dirty dirty2 &&
 	[ "$entry" = "$(git ls-files --stage dirty2 | cut -f 1)" ] &&
 	echo 2 >dirty2 &&
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index ac943f5..d05f421 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1097,7 +1097,7 @@ hash1=$(git rev-parse HEAD)
 test_expect_success 'creating second commit and tag' '
 	echo foo-2.0 >foo &&
 	git add foo &&
-	git commit -m second
+	git commit -m second &&
 	git tag v2.0
 '
 
@@ -1122,18 +1122,18 @@ v2.0
 EOF
 
 test_expect_success 'checking that first commit is in all tags (hash)' "
-	git tag -l --contains $hash1 v* >actual
+	git tag -l --contains $hash1 v* >actual &&
 	test_cmp expected actual
 "
 
 # other ways of specifying the commit
 test_expect_success 'checking that first commit is in all tags (tag)' "
-	git tag -l --contains v1.0 v* >actual
+	git tag -l --contains v1.0 v* >actual &&
 	test_cmp expected actual
 "
 
 test_expect_success 'checking that first commit is in all tags (relative)' "
-	git tag -l --contains HEAD~2 v* >actual
+	git tag -l --contains HEAD~2 v* >actual &&
 	test_cmp expected actual
 "
 
@@ -1142,7 +1142,7 @@ v2.0
 EOF
 
 test_expect_success 'checking that second commit only has one tag' "
-	git tag -l --contains $hash2 v* >actual
+	git tag -l --contains $hash2 v* >actual &&
 	test_cmp expected actual
 "
 
@@ -1151,7 +1151,7 @@ cat > expected <<EOF
 EOF
 
 test_expect_success 'checking that third commit has no tags' "
-	git tag -l --contains $hash3 v* >actual
+	git tag -l --contains $hash3 v* >actual &&
 	test_cmp expected actual
 "
 
@@ -1161,7 +1161,7 @@ test_expect_success 'creating simple branch' '
 	git branch stable v2.0 &&
         git checkout stable &&
 	echo foo-3.0 > foo &&
-	git commit foo -m fourth
+	git commit foo -m fourth &&
 	git tag v3.0
 '
 
@@ -1172,7 +1172,7 @@ v3.0
 EOF
 
 test_expect_success 'checking that branch head only has one tag' "
-	git tag -l --contains $hash4 v* >actual
+	git tag -l --contains $hash4 v* >actual &&
 	test_cmp expected actual
 "
 
@@ -1186,7 +1186,7 @@ v4.0
 EOF
 
 test_expect_success 'checking that original branch head has one tag now' "
-	git tag -l --contains $hash3 v* >actual
+	git tag -l --contains $hash3 v* >actual &&
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
 
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 6c776e9..c802ef8 100755
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
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index c1c6645..50da034 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -390,7 +390,7 @@ try_commit_status_combo () {
 
 	test_expect_success 'commit --no-status' '
 		clear_config commit.status &&
-		try_commit --no-status
+		try_commit --no-status &&
 		! grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
 
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index c2f66ff..d954b84 100755
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
@@ -95,14 +95,14 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	# swap the .keep so the commit object is in the pack with .keep
 	for p in alt_objects/pack/*.pack
 	do
-		base_name=$(basename $p .pack)
+		base_name=$(basename $p .pack) &&
 		if test -f alt_objects/pack/$base_name.keep
 		then
 			rm alt_objects/pack/$base_name.keep
 		else
 			touch alt_objects/pack/$base_name.keep
 		fi
-	done
+	done &&
 	git repack -a -d &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
 	test -f "$myidx" &&
diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
index 565365c..158c8e3 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -33,7 +33,7 @@ test_expect_success 'more emptiness' '
 '
 
 test_expect_success 'git svn rebase creates empty directory' '
-	( cd cloned && git svn rebase )
+	( cd cloned && git svn rebase ) &&
 	test -d cloned/"! !"
 '
 
-- 
1.7.2.3.557.gab647.dirty
