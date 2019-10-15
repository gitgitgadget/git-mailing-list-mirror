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
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C411F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 10:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfJOKZl (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 06:25:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46015 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbfJOKZj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 06:25:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so23107658wrm.12
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 03:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qBZ/KlGOBA15srT14zFmcGz1oDS00rztj8OBfm6oPQg=;
        b=qWNcd41AoRZCAuLEvQTm4t/JcXwULqtkxsy+o133tSC8ON9WEGbPjSBqTAoylFBPtw
         1nmngvZvNIiIN8xypkEKMEmM9rIvIRw1fb+0/pTuhugbxYPSl7vhbIQkOacgwrgpgXlA
         oz2zefZWrzwU9DYl4gB4ZJRwJjLRAGYhkrLNz6iRyOM01tA2Qq9hvycTmPpsyLPguZow
         t8+GdYgsAPtvZxbPVEVsP0ktDJ10tN9/iXI84IuUKsml0BrpUxMlxeZad4PNJQQKX1aQ
         HZQV7PXKLrFfuKsKMfvbmq7+59t17ohpj/71sRmv4kYrIylCdJ+xsKsuLAozlRva/pQf
         POPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qBZ/KlGOBA15srT14zFmcGz1oDS00rztj8OBfm6oPQg=;
        b=sv79qsl8fpah+EfX8xFjGzgwAwB6UtT/bFLbHpxSKbIVvem/c5heWNihEY7rUXdRbj
         vm1ggwAdJ1iFi4c5xxpSC8mBZxZ29GOGzmP31/84emPV3iOaD+x7U6HUnuhB88tdnFYV
         RoL6jRdpMym7X14Lj0FyCVYaEW6Piq5TBzf0mAhTEGVGAAcanZiwsV7837CQmI0tHklA
         k8JkdqcHxv0W/hfJDR7hw8ggjcLmQCcXknW3A8n8BLPQVxBIGfMV0PYTPEQLgUB7j5EX
         /ctBulKN5Or8N4tsrnB2B/pTMm+56NDJ5JXJGVLNJ8Mw/8BaY96414hNrTHNTwz7nVdh
         gzwA==
X-Gm-Message-State: APjAAAVYtMpH6o+vpHbL31gOqh8h4WmJhJKwuKyD/sA41jL6YJJ0gX1q
        Yn8vXb+WN3MUzO139wv6ROQgwVYQ
X-Google-Smtp-Source: APXvYqxWrx7shab3lvCqdEeKPuJkqwTN+jHFjLkfgOP5a2imWmlo3nCmiNu4Yg7t9AIRfgzbIsQA9g==
X-Received: by 2002:adf:f188:: with SMTP id h8mr29622682wro.38.1571135136707;
        Tue, 15 Oct 2019 03:25:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r27sm59699223wrc.55.2019.10.15.03.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 03:25:36 -0700 (PDT)
Message-Id: <09857dee784910b2123764be8cced9364dac4844.1571135132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.388.v2.git.1571135132.gitgitgadget@gmail.com>
References: <pull.388.git.gitgitgadget@gmail.com>
        <pull.388.v2.git.1571135132.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 10:25:29 +0000
Subject: [PATCH v2 3/6] t3404: remove uneeded calls to set_fake_editor
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

Some tests were calling set_fake_editor to ensure they had a sane no-op
editor set. Now that all the editor setting is done in subshells these
tests can rely on EDITOR=: and so do not need to call set_fake_editor.

Also add a test at the end to detect any future additions messing with
the exported value of $EDITOR.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/lib-rebase.sh               | 28 ++++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh | 25 +++++--------------------
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 7ea30e5006..e4554db85e 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -118,3 +118,31 @@ make_empty () {
 	git commit --allow-empty -m "$1" &&
 	git tag "$1"
 }
+
+# Call this (inside test_expect_success) at the end of a test file to
+# check that no tests have changed editor related environment
+# variables or config settings
+test_editor_unchanged () {
+	# We're only interested in exported variables hence 'sh -c'
+	sh -c 'cat >actual <<-EOF
+	EDITOR=$EDITOR
+	FAKE_COMMIT_AMEND=$FAKE_COMMIT_AMEND
+	FAKE_COMMIT_MESSAGE=$FAKE_COMMIT_MESSAGE
+	FAKE_LINES=$FAKE_LINES
+	GIT_EDITOR=$GIT_EDITOR
+	GIT_SEQUENCE_EDITOR=$GIT_SEQUENCE_EDITOR
+	core.editor=$(git config core.editor)
+	sequence.editor=$(git config sequence.editor)
+	EOF'
+	cat >expect <<-\EOF
+	EDITOR=:
+	FAKE_COMMIT_AMEND=
+	FAKE_COMMIT_MESSAGE=
+	FAKE_LINES=
+	GIT_EDITOR=
+	GIT_SEQUENCE_EDITOR=
+	core.editor=
+	sequence.editor=
+	EOF
+	test_cmp expect actual
+}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index cb9b210000..c5d0326825 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -189,7 +189,6 @@ test_expect_success 'implicit interactive rebase does not invoke sequence editor
 
 test_expect_success 'no changes are a nop' '
 	git checkout branch2 &&
-	set_fake_editor &&
 	git rebase -i F &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2" &&
 	test $(git rev-parse I) = $(git rev-parse HEAD)
@@ -199,7 +198,6 @@ test_expect_success 'test the [branch] option' '
 	git checkout -b dead-end &&
 	git rm file6 &&
 	git commit -m "stop here" &&
-	set_fake_editor &&
 	git rebase -i F branch2 &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2" &&
 	test $(git rev-parse I) = $(git rev-parse branch2) &&
@@ -208,7 +206,6 @@ test_expect_success 'test the [branch] option' '
 
 test_expect_success 'test --onto <branch>' '
 	git checkout -b test-onto branch2 &&
-	set_fake_editor &&
 	git rebase -i --onto branch1 F &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/test-onto" &&
 	test $(git rev-parse HEAD^) = $(git rev-parse branch1) &&
@@ -218,7 +215,6 @@ test_expect_success 'test --onto <branch>' '
 test_expect_success 'rebase on top of a non-conflicting commit' '
 	git checkout branch1 &&
 	git tag original-branch1 &&
-	set_fake_editor &&
 	git rebase -i branch2 &&
 	test file6 = $(git diff --name-only original-branch1) &&
 	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
@@ -264,7 +260,6 @@ test_expect_success 'stop on conflicting pick' '
 	>>>>>>> 5d18e54... G
 	EOF
 	git tag new-branch1 &&
-	set_fake_editor &&
 	test_must_fail git rebase -i master &&
 	test "$(git rev-parse HEAD~3)" = "$(git rev-parse master)" &&
 	test_cmp expect .git/rebase-merge/patch &&
@@ -293,7 +288,6 @@ test_expect_success 'abort' '
 test_expect_success 'abort with error when new base cannot be checked out' '
 	git rm --cached file1 &&
 	git commit -m "remove file in base" &&
-	set_fake_editor &&
 	test_must_fail git rebase -i master > output 2>&1 &&
 	test_i18ngrep "The following untracked working tree files would be overwritten by checkout:" \
 		output &&
@@ -308,7 +302,6 @@ test_expect_success 'retain authorship' '
 	test_tick &&
 	GIT_AUTHOR_NAME="Twerp Snog" git commit -m "different author" &&
 	git tag twerp &&
-	set_fake_editor &&
 	git rebase -i --onto master HEAD^ &&
 	git show HEAD | grep "^Author: Twerp Snog"
 '
@@ -326,7 +319,6 @@ test_expect_success 'retain authorship w/ conflicts' '
 	test_commit b conflict b conflict-b &&
 	GIT_AUTHOR_NAME=$oGIT_AUTHOR_NAME &&
 
-	set_fake_editor &&
 	test_must_fail git rebase -i conflict-a &&
 	echo resolved >conflict &&
 	git add conflict &&
@@ -357,7 +349,6 @@ test_expect_success 'retain authorship when squashing' '
 
 test_expect_success REBASE_P '-p handles "no changes" gracefully' '
 	HEAD=$(git rev-parse HEAD) &&
-	set_fake_editor &&
 	git rebase -i -p HEAD^ &&
 	git update-index --refresh &&
 	git diff-files --quiet &&
@@ -404,7 +395,6 @@ test_expect_success REBASE_P 'preserve merges with -p' '
 	git commit -m M file1 &&
 	git checkout -b to-be-rebased &&
 	test_tick &&
-	set_fake_editor &&
 	git rebase -i -p --onto branch1 master &&
 	git update-index --refresh &&
 	git diff-files --quiet &&
@@ -450,7 +440,6 @@ test_expect_success '--continue tries to commit' '
 test_expect_success 'verbose flag is heeded, even after --continue' '
 	git reset --hard master@{1} &&
 	test_tick &&
-	set_fake_editor &&
 	test_must_fail git rebase -v -i --onto new-branch1 HEAD^ &&
 	echo resolved > file1 &&
 	git add file1 &&
@@ -750,7 +739,6 @@ test_expect_success 'do "noop" when there is nothing to cherry-pick' '
 	GIT_EDITOR=: git commit --amend \
 		--author="Somebody else <somebody@else.com>" &&
 	test $(git rev-parse branch3) != $(git rev-parse branch4) &&
-	set_fake_editor &&
 	git rebase -i branch3 &&
 	test $(git rev-parse branch3) = $(git rev-parse branch4)
 
@@ -775,7 +763,6 @@ test_expect_success 'submodule rebase setup' '
 		git commit -a -m "submodule second"
 	) &&
 	test_tick &&
-	set_fake_editor &&
 	git commit -a -m "Three changes submodule"
 '
 
@@ -800,7 +787,6 @@ test_expect_success 'submodule conflict setup' '
 '
 
 test_expect_success 'rebase -i continue with only submodule staged' '
-	set_fake_editor &&
 	test_must_fail git rebase -i submodule-base &&
 	git add sub &&
 	git rebase --continue &&
@@ -810,7 +796,6 @@ test_expect_success 'rebase -i continue with only submodule staged' '
 test_expect_success 'rebase -i continue with unstaged submodule' '
 	git checkout submodule-topic &&
 	git reset --hard &&
-	set_fake_editor &&
 	test_must_fail git rebase -i submodule-base &&
 	git reset &&
 	git rebase --continue &&
@@ -823,7 +808,6 @@ test_expect_success 'avoid unnecessary reset' '
 	test-tool chmtime =123456789 file3 &&
 	git update-index --refresh &&
 	HEAD=$(git rev-parse HEAD) &&
-	set_fake_editor &&
 	git rebase -i HEAD~4 &&
 	test $HEAD = $(git rev-parse HEAD) &&
 	MTIME=$(test-tool chmtime --get file3) &&
@@ -858,7 +842,6 @@ test_expect_success 'rebase -i can copy notes' '
 	test_commit n2 &&
 	test_commit n3 &&
 	git notes add -m"a note" n3 &&
-	set_fake_editor &&
 	git rebase -i --onto n1 n2 &&
 	test "a note" = "$(git notes show HEAD)"
 '
@@ -896,7 +879,6 @@ test_tick # Ensure that the rebased commits get a different timestamp.
 test_expect_success 'always cherry-pick with --no-ff' '
 	git checkout no-ff-branch &&
 	git tag original-no-ff-branch &&
-	set_fake_editor &&
 	git rebase -i --no-ff A &&
 	for p in 0 1 2
 	do
@@ -1044,7 +1026,6 @@ test_expect_success 'rebase --exec works without -i ' '
 
 test_expect_success 'rebase -i --exec without <CMD>' '
 	git reset --hard execute &&
-	set_fake_editor &&
 	test_must_fail git rebase -i --exec 2>actual &&
 	test_i18ngrep "requires a value" actual &&
 	git checkout master
@@ -1180,7 +1161,6 @@ test_expect_success 'rebase --edit-todo can be used to modify todo' '
 test_expect_success 'rebase -i produces readable reflog' '
 	git reset --hard &&
 	git branch -f branch-reflog-test H &&
-	set_fake_editor &&
 	git rebase -i --onto I F branch-reflog-test &&
 	cat >expect <<-\EOF &&
 	rebase -i (finish): returning to refs/heads/branch-reflog-test
@@ -1603,4 +1583,9 @@ test_expect_success 'valid author header when author contains single quote' '
 	test_cmp expected actual
 '
 
+# This must be the last test in this file
+test_expect_success '$EDITOR and friends are unchanged' '
+	test_editor_unchanged
+'
+
 test_done
-- 
gitgitgadget

