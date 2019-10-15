Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F211F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 10:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfJOKZl (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 06:25:41 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:54058 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbfJOKZk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 06:25:40 -0400
Received: by mail-wm1-f49.google.com with SMTP id i16so20231050wmd.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 03:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IMmwcd5sSEarHz7Dac/g2mBmv0SOcTUdrywiZG/UctI=;
        b=gklJH+gqPjYbgaBl1yT4N3ErWCUgVJxrnJJXwYoKnD21mbLUYWdwRqxZWE/xafmWrC
         YMC9a0UyGR6BFFGmaYufxq+Q4A9qv7HYLC+4w78mcCiD0zMzSgl6YekqKzfJMhIwBHfz
         8tl0h4ejODzKUYcVm6x7m6aDaoPglq014NWW+11IfMsJApqeoPFvCIBCWfe23KTgYYQg
         IOjQNoGbeUU439HN5Fqrnlahodnb0Tnjr3ZjN+obAapmA2ZGM2f1iQY60l0+MH7QOgyW
         gM5SQuZ43MUXSayZdL0r9SycnvJU/9zya6i26A+NbF/lTd5nozPP7uqWHMxvxh3yFkNQ
         njSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IMmwcd5sSEarHz7Dac/g2mBmv0SOcTUdrywiZG/UctI=;
        b=fq5DACQe6q1lzbEdjzCN8KSLkd1Pfc+7KZB/M8MKOybnRNYpoaJXeVVB9eY/DNVZAS
         gTXCJBtdVWSlbQC3Dr0TdwlbaBiUIh2vl78PPiIc4y5V6xKUTiZntaVjIu15yVOiuIAF
         chOfVUCub4jFUUmadbxtsxZ3NGUlMHR4CBi7mgez2CyJvzPhYPt0CrfC1cCJtaU4XKuh
         Ed2lKzKPRnaCVpJunxdkxFEoQOA2mbTOpxOKue4zHJWuoBNqnpmzrOebsyhgii643OyW
         HKA0Czhe0ezQSr6EmLHfb8qlK5eMKxI9wqDFQgztU4NX51FYB/kywTLlij7+ZVZoRhO7
         G8Ng==
X-Gm-Message-State: APjAAAVaiDV/2HH7mJTC73jgk5BsHUKhBkHeW2MqIGJ4bOXcS1f5oRz/
        N3mDBdEiw9DyNCzaqNZQmU0KonCk
X-Google-Smtp-Source: APXvYqzh8WnXT9Jo95Ner4t5FOo2jXi1PKoPOg3NkhFmPZR/VwHaE2WEMRW+9lXO6GfhIXDS/CKOZw==
X-Received: by 2002:a05:600c:3cb:: with SMTP id z11mr4997093wmd.138.1571135136069;
        Tue, 15 Oct 2019 03:25:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm18905656wrv.66.2019.10.15.03.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 03:25:35 -0700 (PDT)
Message-Id: <96432cd0f005aa7ef6865af535682c4607a27b33.1571135132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.388.v2.git.1571135132.gitgitgadget@gmail.com>
References: <pull.388.git.gitgitgadget@gmail.com>
        <pull.388.v2.git.1571135132.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 10:25:28 +0000
Subject: [PATCH v2 2/6] t3404: set $EDITOR in subshell
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As $EDITOR is exported setting it in one test affects all subsequent
tests. Avoid this by always setting it in a subshell. This commit leaves
20 calls to set_fake_editor that are not in subshells as they can
safely be removed in the next commit once all the other editor setting
is done inside subshells.

I have moved the call to set_fake_editor in some tests so it comes
immediately before the call to 'git rebase' to avoid moving unrelated
commands into the subshell. In one case ('rebase -ix with
--autosquash') the call to set_fake_editor is moved past an invocation
of 'git rebase'. This is safe as that invocation of 'git rebase'
requires EDITOR=: or EDITOR=fake-editor.sh without FAKE_LINES being
set which will be the case as the preceding tests either set their
editor in a subshell or call set_fake_editor without setting FAKE_LINES.

In a one test ('auto-amend only edited commits after "edit"') a call
to test_tick are now in a subshell. I think this is OK as it is there
to set the date for the next commit which is executed in the same
subshell rather than updating GIT_COMMITTER_DATE for later tests (the
next test calls test_tick before doing anything else).

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3404-rebase-interactive.sh | 546 +++++++++++++++++++++-------------
 1 file changed, 342 insertions(+), 204 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c26b3362ef..cb9b210000 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -79,8 +79,11 @@ test_expect_success 'rebase -i with empty HEAD' '
 	cat >expect <<-\EOF &&
 	error: nothing to do
 	EOF
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES="1 exec_true" git rebase -i HEAD^ >actual 2>&1 &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="1 exec_true" \
+			git rebase -i HEAD^ >actual 2>&1
+	) &&
 	test_i18ncmp expect actual
 '
 
@@ -139,8 +142,11 @@ test_expect_success 'rebase -i sets work tree properly' '
 
 test_expect_success 'rebase -i with the exec command checks tree cleanness' '
 	git checkout master &&
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES="exec_echo_foo_>file1 1" git rebase -i HEAD^ &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="exec_echo_foo_>file1 1" \
+			git rebase -i HEAD^
+	) &&
 	test_cmp_rev master^ HEAD &&
 	git reset --hard &&
 	git rebase --continue
@@ -168,9 +174,11 @@ test_expect_success 'rebase -x with newline in command fails' '
 test_expect_success 'rebase -i with exec of inexistent command' '
 	git checkout master &&
 	test_when_finished "git rebase --abort" &&
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES="exec_this-command-does-not-exist 1" \
-	git rebase -i HEAD^ >actual 2>&1 &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="exec_this-command-does-not-exist 1" \
+			git rebase -i HEAD^ >actual 2>&1
+	) &&
 	! grep "Maybe git-rebase is broken" actual
 '
 
@@ -230,8 +238,10 @@ test_expect_success 'reflog for the branch shows correct finish message' '
 '
 
 test_expect_success 'exchange two commits' '
-	set_fake_editor &&
-	FAKE_LINES="2 1" git rebase -i HEAD~2 &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="2 1" git rebase -i HEAD~2
+	) &&
 	test H = $(git cat-file commit HEAD^ | sed -ne \$p) &&
 	test G = $(git cat-file commit HEAD | sed -ne \$p)
 '
@@ -332,9 +342,11 @@ test_expect_success 'squash' '
 	test_tick &&
 	GIT_AUTHOR_NAME="Nitfol" git commit -m "nitfol" file7 &&
 	echo "******************************" &&
-	set_fake_editor &&
-	FAKE_LINES="1 squash 2" EXPECT_HEADER_COUNT=2 \
-		git rebase -i --onto master HEAD~2 &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 squash 2" EXPECT_HEADER_COUNT=2 \
+			git rebase -i --onto master HEAD~2
+	) &&
 	test B = $(cat file7) &&
 	test $(git rev-parse HEAD^) = $(git rev-parse master)
 '
@@ -355,8 +367,10 @@ test_expect_success REBASE_P '-p handles "no changes" gracefully' '
 
 test_expect_failure REBASE_P 'exchange two commits with -p' '
 	git checkout H &&
-	set_fake_editor &&
-	FAKE_LINES="2 1" git rebase -i -p HEAD~2 &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="2 1" git rebase -i -p HEAD~2
+	) &&
 	test H = $(git cat-file commit HEAD^ | sed -ne \$p) &&
 	test G = $(git cat-file commit HEAD | sed -ne \$p)
 '
@@ -405,8 +419,10 @@ test_expect_success REBASE_P 'preserve merges with -p' '
 '
 
 test_expect_success REBASE_P 'edit ancestor with -p' '
-	set_fake_editor &&
-	FAKE_LINES="1 2 edit 3 4" git rebase -i -p HEAD~3 &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 2 edit 3 4" git rebase -i -p HEAD~3
+	) &&
 	echo 2 > unrelated-file &&
 	test_tick &&
 	git commit -m L2-modified --amend unrelated-file &&
@@ -420,11 +436,13 @@ test_expect_success REBASE_P 'edit ancestor with -p' '
 test_expect_success '--continue tries to commit' '
 	git reset --hard D &&
 	test_tick &&
-	set_fake_editor &&
-	test_must_fail git rebase -i --onto new-branch1 HEAD^ &&
-	echo resolved > file1 &&
-	git add file1 &&
-	FAKE_COMMIT_MESSAGE="chouette!" git rebase --continue &&
+	(
+		set_fake_editor &&
+		test_must_fail git rebase -i --onto new-branch1 HEAD^ &&
+		echo resolved > file1 &&
+		git add file1 &&
+		FAKE_COMMIT_MESSAGE="chouette!" git rebase --continue
+	) &&
 	test $(git rev-parse HEAD^) = $(git rev-parse new-branch1) &&
 	git show HEAD | grep chouette
 '
@@ -442,10 +460,13 @@ test_expect_success 'verbose flag is heeded, even after --continue' '
 
 test_expect_success C_LOCALE_OUTPUT 'multi-squash only fires up editor once' '
 	base=$(git rev-parse HEAD~4) &&
-	set_fake_editor &&
-	FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="1 squash 2 squash 3 squash 4" \
-		EXPECT_HEADER_COUNT=4 \
-		git rebase -i $base &&
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_AMEND="ONCE" \
+			FAKE_LINES="1 squash 2 squash 3 squash 4" \
+			EXPECT_HEADER_COUNT=4 \
+			git rebase -i $base
+	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	test 1 = $(git show | grep ONCE | wc -l)
 '
@@ -453,9 +474,12 @@ test_expect_success C_LOCALE_OUTPUT 'multi-squash only fires up editor once' '
 test_expect_success C_LOCALE_OUTPUT 'multi-fixup does not fire up editor' '
 	git checkout -b multi-fixup E &&
 	base=$(git rev-parse HEAD~4) &&
-	set_fake_editor &&
-	FAKE_COMMIT_AMEND="NEVER" FAKE_LINES="1 fixup 2 fixup 3 fixup 4" \
-		git rebase -i $base &&
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_AMEND="NEVER" \
+			FAKE_LINES="1 fixup 2 fixup 3 fixup 4" \
+			git rebase -i $base
+	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	test 0 = $(git show | grep NEVER | wc -l) &&
 	git checkout @{-1} &&
@@ -465,12 +489,15 @@ test_expect_success C_LOCALE_OUTPUT 'multi-fixup does not fire up editor' '
 test_expect_success 'commit message used after conflict' '
 	git checkout -b conflict-fixup conflict-branch &&
 	base=$(git rev-parse HEAD~4) &&
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES="1 fixup 3 fixup 4" git rebase -i $base &&
-	echo three > conflict &&
-	git add conflict &&
-	FAKE_COMMIT_AMEND="ONCE" EXPECT_HEADER_COUNT=2 \
-		git rebase --continue &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="1 fixup 3 fixup 4" \
+			git rebase -i $base &&
+		echo three > conflict &&
+		git add conflict &&
+		FAKE_COMMIT_AMEND="ONCE" EXPECT_HEADER_COUNT=2 \
+			git rebase --continue
+	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	test 1 = $(git show | grep ONCE | wc -l) &&
 	git checkout @{-1} &&
@@ -480,12 +507,15 @@ test_expect_success 'commit message used after conflict' '
 test_expect_success 'commit message retained after conflict' '
 	git checkout -b conflict-squash conflict-branch &&
 	base=$(git rev-parse HEAD~4) &&
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES="1 fixup 3 squash 4" git rebase -i $base &&
-	echo three > conflict &&
-	git add conflict &&
-	FAKE_COMMIT_AMEND="TWICE" EXPECT_HEADER_COUNT=2 \
-		git rebase --continue &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="1 fixup 3 squash 4" \
+			git rebase -i $base &&
+		echo three > conflict &&
+		git add conflict &&
+		FAKE_COMMIT_AMEND="TWICE" EXPECT_HEADER_COUNT=2 \
+			git rebase --continue
+	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	test 2 = $(git show | grep TWICE | wc -l) &&
 	git checkout @{-1} &&
@@ -502,10 +532,13 @@ test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct log messa
 	EOF
 	git checkout -b squash-fixup E &&
 	base=$(git rev-parse HEAD~4) &&
-	set_fake_editor &&
-	FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="1 fixup 2 squash 3 fixup 4" \
-		EXPECT_HEADER_COUNT=4 \
-		git rebase -i $base &&
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_AMEND="ONCE" \
+			FAKE_LINES="1 fixup 2 squash 3 fixup 4" \
+			EXPECT_HEADER_COUNT=4 \
+			git rebase -i $base
+	) &&
 	git cat-file commit HEAD | sed -e 1,/^\$/d > actual-squash-fixup &&
 	test_cmp expect-squash-fixup actual-squash-fixup &&
 	git cat-file commit HEAD@{2} |
@@ -519,10 +552,13 @@ test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct log messa
 test_expect_success C_LOCALE_OUTPUT 'squash ignores comments' '
 	git checkout -b skip-comments E &&
 	base=$(git rev-parse HEAD~4) &&
-	set_fake_editor &&
-	FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="# 1 # squash 2 # squash 3 # squash 4 #" \
-		EXPECT_HEADER_COUNT=4 \
-		git rebase -i $base &&
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_AMEND="ONCE" \
+			FAKE_LINES="# 1 # squash 2 # squash 3 # squash 4 #" \
+			EXPECT_HEADER_COUNT=4 \
+			git rebase -i $base
+	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	test 1 = $(git show | grep ONCE | wc -l) &&
 	git checkout @{-1} &&
@@ -532,10 +568,13 @@ test_expect_success C_LOCALE_OUTPUT 'squash ignores comments' '
 test_expect_success C_LOCALE_OUTPUT 'squash ignores blank lines' '
 	git checkout -b skip-blank-lines E &&
 	base=$(git rev-parse HEAD~4) &&
-	set_fake_editor &&
-	FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="> 1 > squash 2 > squash 3 > squash 4 >" \
-		EXPECT_HEADER_COUNT=4 \
-		git rebase -i $base &&
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_AMEND="ONCE" \
+			FAKE_LINES="> 1 > squash 2 > squash 3 > squash 4 >" \
+			EXPECT_HEADER_COUNT=4 \
+			git rebase -i $base
+	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	test 1 = $(git show | grep ONCE | wc -l) &&
 	git checkout @{-1} &&
@@ -545,17 +584,21 @@ test_expect_success C_LOCALE_OUTPUT 'squash ignores blank lines' '
 test_expect_success 'squash works as expected' '
 	git checkout -b squash-works no-conflict-branch &&
 	one=$(git rev-parse HEAD~3) &&
-	set_fake_editor &&
-	FAKE_LINES="1 s 3 2" EXPECT_HEADER_COUNT=2 \
-		git rebase -i HEAD~3 &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 s 3 2" EXPECT_HEADER_COUNT=2 git rebase -i HEAD~3
+	) &&
 	test $one = $(git rev-parse HEAD~2)
 '
 
 test_expect_success 'interrupted squash works as expected' '
 	git checkout -b interrupted-squash conflict-branch &&
 	one=$(git rev-parse HEAD~3) &&
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES="1 squash 3 2" git rebase -i HEAD~3 &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="1 squash 3 2" \
+			git rebase -i HEAD~3
+	) &&
 	test_write_lines one two four > conflict &&
 	git add conflict &&
 	test_must_fail git rebase --continue &&
@@ -568,8 +611,11 @@ test_expect_success 'interrupted squash works as expected' '
 test_expect_success 'interrupted squash works as expected (case 2)' '
 	git checkout -b interrupted-squash2 conflict-branch &&
 	one=$(git rev-parse HEAD~3) &&
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES="3 squash 1 2" git rebase -i HEAD~3 &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="3 squash 1 2" \
+			git rebase -i HEAD~3
+	) &&
 	test_write_lines one four > conflict &&
 	git add conflict &&
 	test_must_fail git rebase --continue &&
@@ -589,11 +635,13 @@ test_expect_success '--continue tries to commit, even for "edit"' '
 	git commit -m "unrelated change" &&
 	parent=$(git rev-parse HEAD^) &&
 	test_tick &&
-	set_fake_editor &&
-	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
-	echo edited > file7 &&
-	git add file7 &&
-	FAKE_COMMIT_MESSAGE="chouette!" git rebase --continue &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 1" git rebase -i HEAD^ &&
+		echo edited > file7 &&
+		git add file7 &&
+		FAKE_COMMIT_MESSAGE="chouette!" git rebase --continue
+	) &&
 	test edited = $(git show HEAD:file7) &&
 	git show HEAD | grep chouette &&
 	test $parent = $(git rev-parse HEAD^)
@@ -602,34 +650,41 @@ test_expect_success '--continue tries to commit, even for "edit"' '
 test_expect_success 'aborted --continue does not squash commits after "edit"' '
 	old=$(git rev-parse HEAD) &&
 	test_tick &&
-	set_fake_editor &&
-	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
-	echo "edited again" > file7 &&
-	git add file7 &&
-	test_must_fail env FAKE_COMMIT_MESSAGE=" " git rebase --continue &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 1" git rebase -i HEAD^ &&
+		echo "edited again" > file7 &&
+		git add file7 &&
+		test_must_fail env FAKE_COMMIT_MESSAGE=" " git rebase --continue
+	) &&
 	test $old = $(git rev-parse HEAD) &&
 	git rebase --abort
 '
 
 test_expect_success 'auto-amend only edited commits after "edit"' '
 	test_tick &&
-	set_fake_editor &&
-	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
-	echo "edited again" > file7 &&
-	git add file7 &&
-	FAKE_COMMIT_MESSAGE="edited file7 again" git commit &&
-	echo "and again" > file7 &&
-	git add file7 &&
-	test_tick &&
-	test_must_fail env FAKE_COMMIT_MESSAGE="and again" git rebase --continue &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 1" git rebase -i HEAD^ &&
+		echo "edited again" > file7 &&
+		git add file7 &&
+		FAKE_COMMIT_MESSAGE="edited file7 again" git commit &&
+		echo "and again" > file7 &&
+		git add file7 &&
+		test_tick &&
+		test_must_fail env FAKE_COMMIT_MESSAGE="and again" \
+			git rebase --continue
+	) &&
 	git rebase --abort
 '
 
 test_expect_success 'clean error after failed "exec"' '
 	test_tick &&
 	test_when_finished "git rebase --abort || :" &&
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES="1 exec_false" git rebase -i HEAD^ &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="1 exec_false" git rebase -i HEAD^
+	) &&
 	echo "edited again" > file7 &&
 	git add file7 &&
 	test_must_fail git rebase --continue 2>error &&
@@ -640,8 +695,10 @@ test_expect_success 'rebase a detached HEAD' '
 	grandparent=$(git rev-parse HEAD~2) &&
 	git checkout $(git rev-parse HEAD) &&
 	test_tick &&
-	set_fake_editor &&
-	FAKE_LINES="2 1" git rebase -i HEAD~2 &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="2 1" git rebase -i HEAD~2
+	) &&
 	test $grandparent = $(git rev-parse HEAD~2)
 '
 
@@ -656,9 +713,10 @@ test_expect_success 'rebase a commit violating pre-commit' '
 	test_must_fail git commit -m doesnt-verify file1 &&
 	git commit -m doesnt-verify --no-verify file1 &&
 	test_tick &&
-	set_fake_editor &&
-	FAKE_LINES=2 git rebase -i HEAD~2
-
+	(
+		set_fake_editor &&
+		FAKE_LINES=2 git rebase -i HEAD~2
+	)
 '
 
 test_expect_success 'rebase with a file named HEAD in worktree' '
@@ -678,8 +736,10 @@ test_expect_success 'rebase with a file named HEAD in worktree' '
 		git commit -m "Add body"
 	) &&
 
-	set_fake_editor &&
-	FAKE_LINES="1 squash 2" git rebase -i @{-1} &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 squash 2" git rebase -i @{-1}
+	) &&
 	test "$(git show -s --pretty=format:%an)" = "Squashed Away"
 
 '
@@ -720,8 +780,10 @@ test_expect_success 'submodule rebase setup' '
 '
 
 test_expect_success 'submodule rebase -i' '
-	set_fake_editor &&
-	FAKE_LINES="1 squash 2 3" git rebase -i A
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 squash 2 3" git rebase -i A
+	)
 '
 
 test_expect_success 'submodule conflict setup' '
@@ -770,16 +832,22 @@ test_expect_success 'avoid unnecessary reset' '
 
 test_expect_success 'reword' '
 	git checkout -b reword-branch master &&
-	set_fake_editor &&
-	FAKE_LINES="1 2 3 reword 4" FAKE_COMMIT_MESSAGE="E changed" git rebase -i A &&
-	git show HEAD | grep "E changed" &&
-	test $(git rev-parse master) != $(git rev-parse HEAD) &&
-	test $(git rev-parse master^) = $(git rev-parse HEAD^) &&
-	FAKE_LINES="1 2 reword 3 4" FAKE_COMMIT_MESSAGE="D changed" git rebase -i A &&
-	git show HEAD^ | grep "D changed" &&
-	FAKE_LINES="reword 1 2 3 4" FAKE_COMMIT_MESSAGE="B changed" git rebase -i A &&
-	git show HEAD~3 | grep "B changed" &&
-	FAKE_LINES="1 r 2 pick 3 p 4" FAKE_COMMIT_MESSAGE="C changed" git rebase -i A &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 2 3 reword 4" FAKE_COMMIT_MESSAGE="E changed" \
+			git rebase -i A &&
+		git show HEAD | grep "E changed" &&
+		test $(git rev-parse master) != $(git rev-parse HEAD) &&
+		test $(git rev-parse master^) = $(git rev-parse HEAD^) &&
+		FAKE_LINES="1 2 reword 3 4" FAKE_COMMIT_MESSAGE="D changed" \
+			git rebase -i A &&
+		git show HEAD^ | grep "D changed" &&
+		FAKE_LINES="reword 1 2 3 4" FAKE_COMMIT_MESSAGE="B changed" \
+			git rebase -i A &&
+		git show HEAD~3 | grep "B changed" &&
+		FAKE_LINES="1 r 2 pick 3 p 4" FAKE_COMMIT_MESSAGE="C changed" \
+			git rebase -i A
+	) &&
 	git show HEAD~2 | grep "C changed"
 '
 
@@ -803,8 +871,11 @@ test_expect_success 'rebase -i can copy notes over a fixup' '
 	EOF
 	git reset --hard n3 &&
 	git notes add -m"an earlier note" n2 &&
-	set_fake_editor &&
-	GIT_NOTES_REWRITE_MODE=concatenate FAKE_LINES="1 f 2" git rebase -i n1 &&
+	(
+		set_fake_editor &&
+		GIT_NOTES_REWRITE_MODE=concatenate FAKE_LINES="1 f 2" \
+			git rebase -i n1
+	) &&
 	git notes show > output &&
 	test_cmp expect output
 '
@@ -813,8 +884,10 @@ test_expect_success 'rebase while detaching HEAD' '
 	git symbolic-ref HEAD &&
 	grandparent=$(git rev-parse HEAD~2) &&
 	test_tick &&
-	set_fake_editor &&
-	FAKE_LINES="2 1" git rebase -i HEAD~2 HEAD^0 &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="2 1" git rebase -i HEAD~2 HEAD^0
+	) &&
 	test $grandparent = $(git rev-parse HEAD~2) &&
 	test_must_fail git symbolic-ref HEAD
 '
@@ -855,8 +928,10 @@ test_expect_success 'set up commits with funny messages' '
 test_expect_success 'rebase-i history with funny messages' '
 	git rev-list A..funny >expect &&
 	test_tick &&
-	set_fake_editor &&
-	FAKE_LINES="1 2 3 4" git rebase -i A &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 2 3 4" git rebase -i A
+	) &&
 	git rev-list A.. >actual &&
 	test_cmp expect actual
 '
@@ -870,9 +945,9 @@ test_expect_success 'prepare for rebase -i --exec' '
 '
 
 test_expect_success 'running "git rebase -i --exec git show HEAD"' '
-	set_fake_editor &&
-	git rebase -i --exec "git show HEAD" HEAD~2 >actual &&
 	(
+		set_fake_editor &&
+		git rebase -i --exec "git show HEAD" HEAD~2 >actual &&
 		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
 		export FAKE_LINES &&
 		git rebase -i HEAD~2 >expect
@@ -883,9 +958,9 @@ test_expect_success 'running "git rebase -i --exec git show HEAD"' '
 
 test_expect_success 'running "git rebase --exec git show HEAD -i"' '
 	git reset --hard execute &&
-	set_fake_editor &&
-	git rebase --exec "git show HEAD" -i HEAD~2 >actual &&
 	(
+		set_fake_editor &&
+		git rebase --exec "git show HEAD" -i HEAD~2 >actual &&
 		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
 		export FAKE_LINES &&
 		git rebase -i HEAD~2 >expect
@@ -896,9 +971,9 @@ test_expect_success 'running "git rebase --exec git show HEAD -i"' '
 
 test_expect_success 'running "git rebase -ix git show HEAD"' '
 	git reset --hard execute &&
-	set_fake_editor &&
-	git rebase -ix "git show HEAD" HEAD~2 >actual &&
 	(
+		set_fake_editor &&
+		git rebase -ix "git show HEAD" HEAD~2 >actual &&
 		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
 		export FAKE_LINES &&
 		git rebase -i HEAD~2 >expect
@@ -910,9 +985,9 @@ test_expect_success 'running "git rebase -ix git show HEAD"' '
 
 test_expect_success 'rebase -ix with several <CMD>' '
 	git reset --hard execute &&
-	set_fake_editor &&
-	git rebase -ix "git show HEAD; pwd" HEAD~2 >actual &&
 	(
+		set_fake_editor &&
+		git rebase -ix "git show HEAD; pwd" HEAD~2 >actual &&
 		FAKE_LINES="1 exec_git_show_HEAD;_pwd 2 exec_git_show_HEAD;_pwd" &&
 		export FAKE_LINES &&
 		git rebase -i HEAD~2 >expect
@@ -923,9 +998,9 @@ test_expect_success 'rebase -ix with several <CMD>' '
 
 test_expect_success 'rebase -ix with several instances of --exec' '
 	git reset --hard execute &&
-	set_fake_editor &&
-	git rebase -i --exec "git show HEAD" --exec "pwd" HEAD~2 >actual &&
 	(
+		set_fake_editor &&
+		git rebase -i --exec "git show HEAD" --exec "pwd" HEAD~2 >actual &&
 		FAKE_LINES="1 exec_git_show_HEAD exec_pwd 2
 				exec_git_show_HEAD exec_pwd" &&
 		export FAKE_LINES &&
@@ -944,11 +1019,11 @@ test_expect_success C_LOCALE_OUTPUT 'rebase -ix with --autosquash' '
 	echo bis >bis.txt &&
 	git add bis.txt &&
 	git commit -m "fixup! two_exec" &&
-	set_fake_editor &&
 	git checkout -b autosquash_actual &&
 	git rebase -i --exec "git show HEAD" --autosquash HEAD~4 >actual &&
 	git checkout autosquash &&
 	(
+		set_fake_editor &&
 		git checkout -b autosquash_expected &&
 		FAKE_LINES="1 fixup 3 fixup 4 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
 		export FAKE_LINES &&
@@ -977,8 +1052,10 @@ test_expect_success 'rebase -i --exec without <CMD>' '
 
 test_expect_success 'rebase -i --root re-order and drop commits' '
 	git checkout E &&
-	set_fake_editor &&
-	FAKE_LINES="3 1 2 5" git rebase -i --root &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="3 1 2 5" git rebase -i --root
+	) &&
 	test E = $(git cat-file commit HEAD | sed -ne \$p) &&
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p) &&
 	test A = $(git cat-file commit HEAD^^ | sed -ne \$p) &&
@@ -991,24 +1068,30 @@ test_expect_success 'rebase -i --root retain root commit author and message' '
 	echo B >file7 &&
 	git add file7 &&
 	GIT_AUTHOR_NAME="Twerp Snog" git commit -m "different author" &&
-	set_fake_editor &&
-	FAKE_LINES="2" git rebase -i --root &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="2" git rebase -i --root
+	) &&
 	git cat-file commit HEAD | grep -q "^author Twerp Snog" &&
 	git cat-file commit HEAD | grep -q "^different author$"
 '
 
 test_expect_success 'rebase -i --root temporary sentinel commit' '
 	git checkout B &&
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES="2" git rebase -i --root &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="2" git rebase -i --root
+	) &&
 	git cat-file commit HEAD | grep "^tree 4b825dc642cb" &&
 	git rebase --abort
 '
 
 test_expect_success 'rebase -i --root fixup root commit' '
 	git checkout B &&
-	set_fake_editor &&
-	FAKE_LINES="1 fixup 2" git rebase -i --root &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 fixup 2" git rebase -i --root
+	) &&
 	test A = $(git cat-file commit HEAD | sed -ne \$p) &&
 	test B = $(git show HEAD:file1) &&
 	test 0 = $(git cat-file commit HEAD | grep -c ^parent\ )
@@ -1017,9 +1100,11 @@ test_expect_success 'rebase -i --root fixup root commit' '
 test_expect_success 'rebase -i --root reword original root commit' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout -b reword-original-root-branch master &&
-	set_fake_editor &&
-	FAKE_LINES="reword 1 2" FAKE_COMMIT_MESSAGE="A changed" \
-	git rebase -i --root &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="reword 1 2" FAKE_COMMIT_MESSAGE="A changed" \
+			git rebase -i --root
+	) &&
 	git show HEAD^ | grep "A changed" &&
 	test -z "$(git show -s --format=%p HEAD^)"
 '
@@ -1027,9 +1112,11 @@ test_expect_success 'rebase -i --root reword original root commit' '
 test_expect_success 'rebase -i --root reword new root commit' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	git checkout -b reword-now-root-branch master &&
-	set_fake_editor &&
-	FAKE_LINES="reword 3 1" FAKE_COMMIT_MESSAGE="C changed" \
-	git rebase -i --root &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="reword 3 1" FAKE_COMMIT_MESSAGE="C changed" \
+		git rebase -i --root
+	) &&
 	git show HEAD^ | grep "C changed" &&
 	test -z "$(git show -s --format=%p HEAD^)"
 '
@@ -1041,8 +1128,10 @@ test_expect_success 'rebase -i --root when root has untracked file conflict' '
 	git rm file1 &&
 	git commit -m "remove file 1 add file 2" &&
 	echo z >file1 &&
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES="1 2" git rebase -i --root &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="1 2" git rebase -i --root
+	) &&
 	rm file1 &&
 	git rebase --continue &&
 	test "$(git log -1 --format=%B)" = "remove file 1 add file 2" &&
@@ -1052,11 +1141,13 @@ test_expect_success 'rebase -i --root when root has untracked file conflict' '
 test_expect_success 'rebase -i --root reword root when root has untracked file conflict' '
 	test_when_finished "reset_rebase" &&
 	echo z>file1 &&
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES="reword 1 2" \
-		FAKE_COMMIT_MESSAGE="Modified A" git rebase -i --root &&
-	rm file1 &&
-	FAKE_COMMIT_MESSAGE="Reworded A" git rebase --continue &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="reword 1 2" \
+			FAKE_COMMIT_MESSAGE="Modified A" git rebase -i --root &&
+		rm file1 &&
+		FAKE_COMMIT_MESSAGE="Reworded A" git rebase --continue
+	) &&
 	test "$(git log -1 --format=%B HEAD^)" = "Reworded A" &&
 	test "$(git rev-list --count HEAD)" = 2
 '
@@ -1065,19 +1156,23 @@ test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-int
 	git checkout reword-original-root-branch &&
 	git reset --hard &&
 	git checkout conflict-branch &&
-	set_fake_editor &&
-	test_must_fail git rebase --onto HEAD~2 HEAD~ &&
-	test_must_fail git rebase --edit-todo &&
+	(
+		set_fake_editor &&
+		test_must_fail git rebase --onto HEAD~2 HEAD~ &&
+		test_must_fail git rebase --edit-todo
+	) &&
 	git rebase --abort
 '
 
 test_expect_success 'rebase --edit-todo can be used to modify todo' '
 	git reset --hard &&
 	git checkout no-conflict-branch^0 &&
-	set_fake_editor &&
-	FAKE_LINES="edit 1 2 3" git rebase -i HEAD~3 &&
-	FAKE_LINES="2 1" git rebase --edit-todo &&
-	git rebase --continue &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 1 2 3" git rebase -i HEAD~3 &&
+		FAKE_LINES="2 1" git rebase --edit-todo &&
+		git rebase --continue
+	) &&
 	test M = $(git cat-file commit HEAD^ | sed -ne \$p) &&
 	test L = $(git cat-file commit HEAD | sed -ne \$p)
 '
@@ -1106,8 +1201,10 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	sed -e "2,\$s/^/\\\\/" "$1" >"$1.tmp" &&
 	mv "$1.tmp" "$1"
 	EOF
-	test_set_editor "$(pwd)/remove-all-but-first.sh" &&
-	git rebase -i B &&
+	(
+		test_set_editor "$(pwd)/remove-all-but-first.sh" &&
+		git rebase -i B
+	) &&
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
@@ -1116,9 +1213,11 @@ test_expect_success 'rebase -i respects core.commentchar=auto' '
 	write_script copy-edit-script.sh <<-\EOF &&
 	cp "$1" edit-script
 	EOF
-	test_set_editor "$(pwd)/copy-edit-script.sh" &&
 	test_when_finished "git rebase --abort || :" &&
-	git rebase -i HEAD^ &&
+	(
+		test_set_editor "$(pwd)/copy-edit-script.sh" &&
+		git rebase -i HEAD^
+	) &&
 	test -z "$(grep -ve "^#" -e "^\$" -e "^pick" edit-script)"
 '
 
@@ -1153,8 +1252,11 @@ test_expect_success 'interrupted rebase -i with --strategy and -X' '
 	echo five >conflict &&
 	echo Z >file1 &&
 	git commit -a -m "one file conflict" &&
-	set_fake_editor &&
-	FAKE_LINES="edit 1 2" git rebase -i --strategy=recursive -Xours conflict-branch &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 1 2" git rebase -i --strategy=recursive \
+			-Xours conflict-branch
+	) &&
 	git rebase --continue &&
 	test $(git show conflict-branch:conflict) = $(cat conflict) &&
 	test $(cat file1) = Z
@@ -1195,8 +1297,10 @@ test_expect_success 'short SHA-1 collide' '
 
 test_expect_success 'respect core.abbrev' '
 	git config core.abbrev 12 &&
-	set_cat_todo_editor &&
-	test_must_fail git rebase -i HEAD~4 >todo-list &&
+	(
+		set_cat_todo_editor &&
+		test_must_fail git rebase -i HEAD~4 >todo-list
+	) &&
 	test 4 = $(grep -c "pick [0-9a-f]\{12,\}" todo-list)
 '
 
@@ -1204,16 +1308,20 @@ test_expect_success 'todo count' '
 	write_script dump-raw.sh <<-\EOF &&
 		cat "$1"
 	EOF
-	test_set_editor "$(pwd)/dump-raw.sh" &&
-	git rebase -i HEAD~4 >actual &&
+	(
+		test_set_editor "$(pwd)/dump-raw.sh" &&
+		git rebase -i HEAD~4 >actual
+	) &&
 	test_i18ngrep "^# Rebase ..* onto ..* ([0-9]" actual
 '
 
 test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
 	git checkout --force branch2 &&
 	git clean -f &&
-	set_fake_editor &&
-	FAKE_LINES="edit 1 2" git rebase -i A &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 1 2" git rebase -i A
+	) &&
 	test_cmp_rev HEAD F &&
 	test_path_is_missing file6 &&
 	>file6 &&
@@ -1228,8 +1336,10 @@ test_expect_success 'rebase -i commits that overwrite untracked files (squash)'
 	git checkout --force branch2 &&
 	git clean -f &&
 	git tag original-branch2 &&
-	set_fake_editor &&
-	FAKE_LINES="edit 1 squash 2" git rebase -i A &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 1 squash 2" git rebase -i A
+	) &&
 	test_cmp_rev HEAD F &&
 	test_path_is_missing file6 &&
 	>file6 &&
@@ -1244,8 +1354,10 @@ test_expect_success 'rebase -i commits that overwrite untracked files (squash)'
 test_expect_success 'rebase -i commits that overwrite untracked files (no ff)' '
 	git checkout --force branch2 &&
 	git clean -f &&
-	set_fake_editor &&
-	FAKE_LINES="edit 1 2" git rebase -i --no-ff A &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 1 2" git rebase -i --no-ff A
+	) &&
 	test $(git cat-file commit HEAD | sed -ne \$p) = F &&
 	test_path_is_missing file6 &&
 	>file6 &&
@@ -1268,8 +1380,10 @@ test_expect_success 'rebase --continue removes CHERRY_PICK_HEAD' '
 	git tag seq-onto &&
 	git reset --hard HEAD~2 &&
 	git cherry-pick seq-onto &&
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES= git rebase -i seq-onto &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES= git rebase -i seq-onto
+	) &&
 	test -d .git/rebase-merge &&
 	git rebase --continue &&
 	git diff --exit-code seq-onto &&
@@ -1288,8 +1402,10 @@ rebase_setup_and_clean () {
 
 test_expect_success 'drop' '
 	rebase_setup_and_clean drop-test &&
-	set_fake_editor &&
-	FAKE_LINES="1 drop 2 3 d 4 5" git rebase -i --root &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 drop 2 3 d 4 5" git rebase -i --root
+	) &&
 	test E = $(git cat-file commit HEAD | sed -ne \$p) &&
 	test C = $(git cat-file commit HEAD^ | sed -ne \$p) &&
 	test A = $(git cat-file commit HEAD^^ | sed -ne \$p)
@@ -1298,9 +1414,10 @@ test_expect_success 'drop' '
 test_expect_success 'rebase -i respects rebase.missingCommitsCheck = ignore' '
 	test_config rebase.missingCommitsCheck ignore &&
 	rebase_setup_and_clean missing-commit &&
-	set_fake_editor &&
-	FAKE_LINES="1 2 3 4" \
-		git rebase -i --root 2>actual &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 2 3 4" git rebase -i --root 2>actual
+	) &&
 	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
 	test_i18ngrep \
 		"Successfully rebased and updated refs/heads/missing-commit" \
@@ -1316,9 +1433,10 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = warn' '
 	EOF
 	test_config rebase.missingCommitsCheck warn &&
 	rebase_setup_and_clean missing-commit &&
-	set_fake_editor &&
-	FAKE_LINES="1 2 3 4" \
-		git rebase -i --root 2>actual.2 &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 2 3 4" git rebase -i --root 2>actual.2
+	) &&
 	head -n4 actual.2 >actual &&
 	test_i18ncmp expect actual &&
 	test D = $(git cat-file commit HEAD | sed -ne \$p)
@@ -1340,14 +1458,15 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	EOF
 	test_config rebase.missingCommitsCheck error &&
 	rebase_setup_and_clean missing-commit &&
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES="1 2 4" \
-		git rebase -i --root 2>actual &&
-	test_i18ncmp expect actual &&
-	cp .git/rebase-merge/git-rebase-todo.backup \
-		.git/rebase-merge/git-rebase-todo &&
-	FAKE_LINES="1 2 drop 3 4 drop 5" \
-		git rebase --edit-todo &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="1 2 4" \
+			git rebase -i --root 2>actual &&
+		test_i18ncmp expect actual &&
+		cp .git/rebase-merge/git-rebase-todo.backup \
+			.git/rebase-merge/git-rebase-todo &&
+		FAKE_LINES="1 2 drop 3 4 drop 5" git rebase --edit-todo
+	) &&
 	git rebase --continue &&
 	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
@@ -1368,21 +1487,27 @@ test_expect_success 'respects rebase.abbreviateCommands with fixup, squash and e
 	x git show HEAD
 	EOF
 	git checkout abbrevcmd &&
-	set_cat_todo_editor &&
 	test_config rebase.abbreviateCommands true &&
-	test_must_fail git rebase -i --exec "git show HEAD" \
-		--autosquash master >actual &&
+	(
+		set_cat_todo_editor &&
+		test_must_fail git rebase -i --exec "git show HEAD" \
+			--autosquash master >actual
+	) &&
 	test_cmp expected actual
 '
 
 test_expect_success 'static check of bad command' '
 	rebase_setup_and_clean bad-cmd &&
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES="1 2 3 bad 4 5" \
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="1 2 3 bad 4 5" \
 		git rebase -i --root 2>actual &&
-	test_i18ngrep "badcmd $(git rev-list --oneline -1 master~1)" actual &&
-	test_i18ngrep "You can fix this with .git rebase --edit-todo.." actual &&
-	FAKE_LINES="1 2 3 drop 4 5" git rebase --edit-todo &&
+		test_i18ngrep "badcmd $(git rev-list --oneline -1 master~1)" \
+				actual &&
+		test_i18ngrep "You can fix this with .git rebase --edit-todo.." \
+				actual &&
+		FAKE_LINES="1 2 3 drop 4 5" git rebase --edit-todo
+	) &&
 	git rebase --continue &&
 	test E = $(git cat-file commit HEAD | sed -ne \$p) &&
 	test C = $(git cat-file commit HEAD^ | sed -ne \$p)
@@ -1398,19 +1523,24 @@ test_expect_success 'tabs and spaces are accepted in the todolist' '
 	) >"$1.new"
 	mv "$1.new" "$1"
 	EOF
-	test_set_editor "$(pwd)/add-indent.sh" &&
-	git rebase -i HEAD^^^ &&
+	(
+		test_set_editor "$(pwd)/add-indent.sh" &&
+		git rebase -i HEAD^^^
+	) &&
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
 test_expect_success 'static check of bad SHA-1' '
 	rebase_setup_and_clean bad-sha &&
-	set_fake_editor &&
-	test_must_fail env FAKE_LINES="1 2 edit fakesha 3 4 5 #" \
-		git rebase -i --root 2>actual &&
-	test_i18ngrep "edit XXXXXXX False commit" actual &&
-	test_i18ngrep "You can fix this with .git rebase --edit-todo.." actual &&
-	FAKE_LINES="1 2 4 5 6" git rebase --edit-todo &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_LINES="1 2 edit fakesha 3 4 5 #" \
+			git rebase -i --root 2>actual &&
+			test_i18ngrep "edit XXXXXXX False commit" actual &&
+			test_i18ngrep "You can fix this with .git rebase --edit-todo.." \
+					actual &&
+		FAKE_LINES="1 2 4 5 6" git rebase --edit-todo
+	) &&
 	git rebase --continue &&
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
 '
@@ -1430,37 +1560,45 @@ test_expect_success 'editor saves as CR/LF' '
 SQ="'"
 test_expect_success 'rebase -i --gpg-sign=<key-id>' '
 	test_when_finished "test_might_fail git rebase --abort" &&
-	set_fake_editor &&
-	FAKE_LINES="edit 1" git rebase -i --gpg-sign="\"S I Gner\"" HEAD^ \
-		>out 2>err &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 1" git rebase -i --gpg-sign="\"S I Gner\"" \
+			HEAD^ >out 2>err
+	) &&
 	test_i18ngrep "$SQ-S\"S I Gner\"$SQ" err
 '
 
 test_expect_success 'rebase -i --gpg-sign=<key-id> overrides commit.gpgSign' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	test_config commit.gpgsign true &&
-	set_fake_editor &&
-	FAKE_LINES="edit 1" git rebase -i --gpg-sign="\"S I Gner\"" HEAD^ \
-		>out 2>err &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 1" git rebase -i --gpg-sign="\"S I Gner\"" \
+			HEAD^ >out 2>err
+	) &&
 	test_i18ngrep "$SQ-S\"S I Gner\"$SQ" err
 '
 
 test_expect_success 'valid author header after --root swap' '
 	rebase_setup_and_clean author-header no-conflict-branch &&
-	set_fake_editor &&
 	git commit --amend --author="Au ${SQ}thor <author@example.com>" --no-edit &&
 	git cat-file commit HEAD | grep ^author >expected &&
-	FAKE_LINES="5 1" git rebase -i --root &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="5 1" git rebase -i --root
+	) &&
 	git cat-file commit HEAD^ | grep ^author >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'valid author header when author contains single quote' '
 	rebase_setup_and_clean author-header no-conflict-branch &&
-	set_fake_editor &&
 	git commit --amend --author="Au ${SQ}thor <author@example.com>" --no-edit &&
 	git cat-file commit HEAD | grep ^author >expected &&
-	FAKE_LINES="2" git rebase -i HEAD~2 &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="2" git rebase -i HEAD~2
+	) &&
 	git cat-file commit HEAD | grep ^author >actual &&
 	test_cmp expected actual
 '
-- 
gitgitgadget

