Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A64861F453
	for <e@80x24.org>; Wed, 31 Oct 2018 20:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbeKAFBh (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 01:01:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34564 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbeKAFBg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 01:01:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id f10-v6so7808122plr.1
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MTfgLLE6aZRtPmxVnVA82L5VD5IWcJEWkb5bDUYIEX8=;
        b=VwM2angu9BhRxBvsKdlUhOeVkNC+byXZRqE0OfIvOVSwklY61U+bQe+M5cxMImxtOa
         Cl540hjM0/2e7dHNVUZ98dpQApsxl3M8lCc6U5HIbvjjhCXPwhG9RcT3XE7YYSjb82jT
         hEfukc7nkNkPWijL0q1j7KRNlmPV79eYRNDUOPqyXqYfXSunv2dxlT8v9TDYNmakdDTR
         vIBU30B/dRUNIW6beQ8GvrBdVolu+Q8wZCIT9YvJUAHnplZ6mK5lQiYbjVPBzf9fVSYz
         pJh9JeYbgjMS6IY99/mIKNSjUsaw/X8kzNtSFGCFVxShANHGgDaHh9BsclxP3p8MQSYF
         EQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MTfgLLE6aZRtPmxVnVA82L5VD5IWcJEWkb5bDUYIEX8=;
        b=aNpRpifxc3u1wlCGOmBe72Q/D9dgcagmGBGFVuAR1rZlyFh5DW4g4tx+DXW9MDmIgh
         Be+nyBcrWS7haRERpl1u/HPEIvV0lAaCZ1h8tVSaOsXA/zL5TdLB8Uzg/iQmsCWZWUDo
         HBrPIOJFBH9eOsGO4ahgBbw6jUPCZIWgjcmzUwW++lo7P35m5L6djghxOtJ/wvvK8NbE
         mu3oAUMTx/LaLDNo4+VdoBmZu0lNhpk07Z2LQGgg/a+DK8Os9ZDINWx5tpcEkGzpLYV+
         4NzGPKOcXcZFHkvNjEeD6ffwEVe8ktkMd17U89Ba3le//VlOGNFZnxWDJk1LWJ18SxUn
         Q60w==
X-Gm-Message-State: AGRZ1gLmJ6xWvwz8bpnNubmwAFt7cjYojIa8OuBDw7YGisilEeycd/UE
        gnPgHxNVnocBRZsE6tt0Bb1v+Esa
X-Google-Smtp-Source: AJdET5dQRm3BruawAZZgJFjuAMRJ/cu1yQnginsBUxKsDuSowtwALfPUCkBKrh/jwMnVKoa02qcw5Q==
X-Received: by 2002:a17:902:8210:: with SMTP id x16-v6mr4885424pln.229.1541016122936;
        Wed, 31 Oct 2018 13:02:02 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id 3-v6sm30701193pga.12.2018.10.31.13.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 13:02:02 -0700 (PDT)
Date:   Wed, 31 Oct 2018 13:02:02 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Oct 2018 20:01:54 GMT
Message-Id: <39734e4805cbd695cd69e7c1a3016de629ac9b3c.1541016115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.63.git.gitgitgadget@gmail.com>
References: <pull.63.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] tests: optionally skip `git rebase -p` tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `--preserve-merges` mode of the `rebase` command is slated to be
deprecated soon, as the more powerful `--rebase-merges` mode is
available now, and the latter was designed with the express intent to
address the shortcomings of `--preserve-merges`' design (e.g. the
inability to reorder commits in an interactive rebase).

As such, we will eventually even remove the `--preserve-merges` support,
and along with it, its tests.

In preparation for this, and also to allow the Windows phase of our
automated tests to save some well-needed time when running the test
suite, this commit introduces a new prerequisite REBASE_P, which can be
forced to being unmet by setting the environment variable
`GIT_TEST_SKIP_REBASE_P` to any non-empty string.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh             |  8 ++---
 t/t3408-rebase-multi-line.sh              |  2 +-
 t/t3409-rebase-preserve-merges.sh         |  5 ++++
 t/t3410-rebase-preserve-dropped-merges.sh |  5 ++++
 t/t3411-rebase-preserve-around-merges.sh  |  5 ++++
 t/t3412-rebase-root.sh                    | 12 ++++----
 t/t3414-rebase-preserve-onto.sh           |  5 ++++
 t/t3418-rebase-continue.sh                |  4 +--
 t/t3421-rebase-topology-linear.sh         | 36 +++++++++++------------
 t/t3425-rebase-topology-merges.sh         |  5 ++++
 t/t5520-pull.sh                           |  6 ++--
 t/t7505-prepare-commit-msg-hook.sh        |  2 +-
 t/t7517-per-repo-email.sh                 |  6 ++--
 t/test-lib.sh                             |  4 +++
 14 files changed, 69 insertions(+), 36 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 99d1fb79a8..68ca8dc9bb 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -312,7 +312,7 @@ test_expect_success 'retain authorship when squashing' '
 	git show HEAD | grep "^Author: Twerp Snog"
 '
 
-test_expect_success '-p handles "no changes" gracefully' '
+test_expect_success REBASE_P '-p handles "no changes" gracefully' '
 	HEAD=$(git rev-parse HEAD) &&
 	set_fake_editor &&
 	git rebase -i -p HEAD^ &&
@@ -322,7 +322,7 @@ test_expect_success '-p handles "no changes" gracefully' '
 	test $HEAD = $(git rev-parse HEAD)
 '
 
-test_expect_failure 'exchange two commits with -p' '
+test_expect_failure REBASE_P 'exchange two commits with -p' '
 	git checkout H &&
 	set_fake_editor &&
 	FAKE_LINES="2 1" git rebase -i -p HEAD~2 &&
@@ -330,7 +330,7 @@ test_expect_failure 'exchange two commits with -p' '
 	test G = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
-test_expect_success 'preserve merges with -p' '
+test_expect_success REBASE_P 'preserve merges with -p' '
 	git checkout -b to-be-preserved master^ &&
 	: > unrelated-file &&
 	git add unrelated-file &&
@@ -373,7 +373,7 @@ test_expect_success 'preserve merges with -p' '
 	test $(git show HEAD:unrelated-file) = 1
 '
 
-test_expect_success 'edit ancestor with -p' '
+test_expect_success REBASE_P 'edit ancestor with -p' '
 	set_fake_editor &&
 	FAKE_LINES="1 2 edit 3 4" git rebase -i -p HEAD~3 &&
 	echo 2 > unrelated-file &&
diff --git a/t/t3408-rebase-multi-line.sh b/t/t3408-rebase-multi-line.sh
index e7292f5b9b..d2bd7c17b0 100755
--- a/t/t3408-rebase-multi-line.sh
+++ b/t/t3408-rebase-multi-line.sh
@@ -52,7 +52,7 @@ test_expect_success rebase '
 	test_cmp expect actual
 
 '
-test_expect_success rebasep '
+test_expect_success REBASE_P rebasep '
 
 	git checkout side-merge &&
 	git rebase -p side &&
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 8c251c57a6..3b340f1ece 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -8,6 +8,11 @@ Run "git rebase -p" and check that merges are properly carried along
 '
 . ./test-lib.sh
 
+if ! test_have_prereq REBASE_P; then
+	skip_all='skipping git rebase -p tests, as asked for'
+	test_done
+fi
+
 GIT_AUTHOR_EMAIL=bogus_email_address
 export GIT_AUTHOR_EMAIL
 
diff --git a/t/t3410-rebase-preserve-dropped-merges.sh b/t/t3410-rebase-preserve-dropped-merges.sh
index 6f73b95558..2e29866993 100755
--- a/t/t3410-rebase-preserve-dropped-merges.sh
+++ b/t/t3410-rebase-preserve-dropped-merges.sh
@@ -11,6 +11,11 @@ rewritten.
 '
 . ./test-lib.sh
 
+if ! test_have_prereq REBASE_P; then
+	skip_all='skipping git rebase -p tests, as asked for'
+	test_done
+fi
+
 # set up two branches like this:
 #
 # A - B - C - D - E
diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
index dc81bf27eb..fb45e7bf7b 100755
--- a/t/t3411-rebase-preserve-around-merges.sh
+++ b/t/t3411-rebase-preserve-around-merges.sh
@@ -10,6 +10,11 @@ a merge to before the merge.
 '
 . ./test-lib.sh
 
+if ! test_have_prereq REBASE_P; then
+	skip_all='skipping git rebase -p tests, as asked for'
+	test_done
+fi
+
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
 set_fake_editor
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 73a39f2923..21632a984e 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -86,14 +86,14 @@ test_expect_success 'pre-rebase got correct input (4)' '
 	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,work4
 '
 
-test_expect_success 'rebase -i -p with linear history' '
+test_expect_success REBASE_P 'rebase -i -p with linear history' '
 	git checkout -b work5 other &&
 	git rebase -i -p --root --onto master &&
 	git log --pretty=tformat:"%s" > rebased5 &&
 	test_cmp expect rebased5
 '
 
-test_expect_success 'pre-rebase got correct input (5)' '
+test_expect_success REBASE_P 'pre-rebase got correct input (5)' '
 	test "z$(cat .git/PRE-REBASE-INPUT)" = z--root,
 '
 
@@ -120,7 +120,7 @@ commit work6~4
 1
 EOF
 
-test_expect_success 'rebase -i -p with merge' '
+test_expect_success REBASE_P 'rebase -i -p with merge' '
 	git checkout -b work6 other &&
 	git rebase -i -p --root --onto master &&
 	log_with_names work6 > rebased6 &&
@@ -155,7 +155,7 @@ commit work7~5
 1
 EOF
 
-test_expect_success 'rebase -i -p with two roots' '
+test_expect_success REBASE_P 'rebase -i -p with two roots' '
 	git checkout -b work7 other &&
 	git rebase -i -p --root --onto master &&
 	log_with_names work7 > rebased7 &&
@@ -261,7 +261,7 @@ commit conflict3~6
 1
 EOF
 
-test_expect_success 'rebase -i -p --root with conflict (first part)' '
+test_expect_success REBASE_P 'rebase -i -p --root with conflict (first part)' '
 	git checkout -b conflict3 other &&
 	test_must_fail git rebase -i -p --root --onto master &&
 	git ls-files -u | grep "B$"
@@ -272,7 +272,7 @@ test_expect_success 'fix the conflict' '
 	git add B
 '
 
-test_expect_success 'rebase -i -p --root with conflict (second part)' '
+test_expect_success REBASE_P 'rebase -i -p --root with conflict (second part)' '
 	git rebase --continue &&
 	log_with_names conflict3 >out &&
 	test_cmp expect-conflict-p out
diff --git a/t/t3414-rebase-preserve-onto.sh b/t/t3414-rebase-preserve-onto.sh
index ee0a6cccfd..72e04b5386 100755
--- a/t/t3414-rebase-preserve-onto.sh
+++ b/t/t3414-rebase-preserve-onto.sh
@@ -10,6 +10,11 @@ aren'"'"'t on top of $ONTO, even if they are on top of $UPSTREAM.
 '
 . ./test-lib.sh
 
+if ! test_have_prereq REBASE_P; then
+	skip_all='skipping git rebase -p tests, as asked for'
+	test_done
+fi
+
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
 # Set up branches like this:
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 031e3d8ddb..f0025c7810 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -106,7 +106,7 @@ test_expect_success 'rebase -i --continue handles merge strategy and options' '
 	test -f funny.was.run
 '
 
-test_expect_success 'rebase passes merge strategy options correctly' '
+test_expect_success REBASE_P 'rebase passes merge strategy options correctly' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
 	test_commit theirs-to-merge &&
@@ -241,6 +241,6 @@ test_rerere_autoupdate
 test_rerere_autoupdate -m
 GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
 test_rerere_autoupdate -i
-test_rerere_autoupdate --preserve-merges
+test_have_prereq !REBASE_P || test_rerere_autoupdate --preserve-merges
 
 test_done
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 99b2aac921..23ad4cff35 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -29,7 +29,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_run_rebase success -p
+test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -43,7 +43,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_run_rebase success -p
+test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -59,7 +59,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_run_rebase failure -p
+test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -73,7 +73,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_run_rebase success -p
+test_have_prereq !REBASE_P || test_run_rebase success -p
 
 #       f
 #      /
@@ -113,7 +113,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase failure -m
 test_run_rebase success -i
-test_run_rebase success -p
+test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -128,7 +128,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase failure -m
 test_run_rebase success -i
-test_run_rebase success -p
+test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -143,7 +143,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase failure -m
 test_run_rebase success -i
-test_run_rebase success -p
+test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -158,7 +158,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_run_rebase success -p
+test_have_prereq !REBASE_P || test_run_rebase success -p
 
 # a---b---c---j!
 #      \
@@ -186,7 +186,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_run_rebase success -p
+test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -201,7 +201,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_run_rebase failure -p
+test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -216,7 +216,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_run_rebase failure -p
+test_have_prereq !REBASE_P || test_run_rebase failure -p
 test_run_rebase success --rebase-merges
 
 #       m
@@ -256,7 +256,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_run_rebase success -p
+test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -271,7 +271,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_run_rebase failure -p
+test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -286,7 +286,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase failure -m
 test_run_rebase success -i
-test_run_rebase success -p
+test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_run_rebase () {
 	result=$1
@@ -302,7 +302,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_run_rebase failure -p
+test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -317,7 +317,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase failure -m
 test_run_rebase success -i
-test_run_rebase failure -p
+test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -331,7 +331,7 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_run_rebase failure -p
+test_have_prereq !REBASE_P || test_run_rebase failure -p
 
 test_run_rebase () {
 	result=$1
@@ -346,6 +346,6 @@ test_run_rebase () {
 test_run_rebase success ''
 test_run_rebase success -m
 test_run_rebase success -i
-test_run_rebase success -p
+test_have_prereq !REBASE_P || test_run_rebase success -p
 
 test_done
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index 846f85c27e..5f892e33d7 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -109,6 +109,11 @@ test_run_rebase success 'd e n o' ''
 test_run_rebase success 'd e n o' -m
 test_run_rebase success 'd n o e' -i
 
+if ! test_have_prereq REBASE_P; then
+	skip_all='skipping git rebase -p tests, as asked for'
+	test_done
+fi
+
 test_expect_success "rebase -p is no-op in non-linear history" "
 	reset_rebase &&
 	git rebase -p d w &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 5e501c8b08..cf4cc32fd0 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -461,7 +461,8 @@ test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
-test_expect_success 'pull.rebase=preserve rebases and merges keep-merge' '
+test_expect_success REBASE_P \
+	'pull.rebase=preserve rebases and merges keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull . copy &&
@@ -514,7 +515,8 @@ test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
-test_expect_success '--rebase=preserve rebases and merges keep-merge' '
+test_expect_success REBASE_P \
+	'--rebase=preserve rebases and merges keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull --rebase=preserve . copy &&
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 1f43b3cd4c..ebfcad9c4c 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -253,7 +253,7 @@ test_rebase () {
 }
 
 test_rebase success -i
-test_rebase success -p
+test_have_prereq !REBASE_P || test_rebase success -p
 
 test_expect_success 'with hook (cherry-pick)' '
 	test_when_finished "git checkout -f master" &&
diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
index 2a22fa7588..231b8cc19d 100755
--- a/t/t7517-per-repo-email.sh
+++ b/t/t7517-per-repo-email.sh
@@ -72,12 +72,14 @@ test_expect_success 'noop interactive rebase does not care about ident' '
 	git rebase -i HEAD^
 '
 
-test_expect_success 'fast-forward rebase does not care about ident (preserve)' '
+test_expect_success REBASE_P \
+	'fast-forward rebase does not care about ident (preserve)' '
 	git checkout -B tmp side-without-commit &&
 	git rebase -p master
 '
 
-test_expect_success 'non-fast-forward rebase refuses to write commits (preserve)' '
+test_expect_success REBASE_P \
+	'non-fast-forward rebase refuses to write commits (preserve)' '
 	test_when_finished "git rebase --abort || true" &&
 	git checkout -B tmp side-with-commit &&
 	test_must_fail git rebase -p master
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 897e6fcc94..8b3d0ca7d1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1268,3 +1268,7 @@ test_lazy_prereq CURL '
 test_lazy_prereq SHA1 '
 	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
 '
+
+test_lazy_prereq REBASE_P '
+	test -z "$GIT_TEST_SKIP_REBASE_P"
+'
-- 
gitgitgadget
