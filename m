Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A47421F462
	for <e@80x24.org>; Thu, 25 Jul 2019 10:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388845AbfGYKLZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 06:11:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46802 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388628AbfGYKLY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 06:11:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so50093593wru.13
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 03:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b9Vd5lQ92BHgCYhkory5LXdpc0y2dVPAGYbbQWvGUjg=;
        b=nj66U+FT4yplMJYXMQ7ti3olrExAWgrnibtbt36U8M0qiFvJ8KVyJ2NwuS4NMkaifU
         jhU5Mk4Ygj1PQIxk9eU1WxR+WPGUIfIMeYaivRyb79TPBqFBNFSZi+UwirGzX4YgTC9z
         Jnr2MIrvYx4zlT6rumcilg+IzEN5E5Ep2/7qSEELm288kEy9GTbRrshg9XDkmeVKbi3A
         9T0g8uZhWcyB1KDdeu8MNMWKsxfzPSaHFXP4WX2DWQODaVmhZx2ZD9vtXOvlb6tUQDji
         yqecIizjfP5tRRbiastQ2T93/5MDR8s1meW5ygPdLYL6Kww9ofW24WWtuTNbt1UNUahi
         j3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b9Vd5lQ92BHgCYhkory5LXdpc0y2dVPAGYbbQWvGUjg=;
        b=WBrQcQHwpblg8R66TqULDHEake6ksADKgYk2ofvy10TXmQ/xQfRiAquHjcIP7XkdlJ
         inxp6LJnRWC4fo498qHap4GkKHEFacSp8vHrEPf3kxH92w1grS0SCsC7KQqK3rTEeClz
         E69kk/8fIbp7DcauhFUPhUCdQn0if3J4uCKN29kQdIMPBvLLKIQ2k6rbEJl6MTcnHz0d
         aZbbzN6mJdzTWlg1ddVjt95xpLguFQryK5HI/drW21YiDiSFaftLOw/YrSsUu+cqKMOD
         QCNdIXKkYSEb+40cuA5RultukeU1RMieHU5Pk2gDCQxeNHCRDFpAyj37dYAuflygwXM0
         taNA==
X-Gm-Message-State: APjAAAXjPfFfNzpLS0CTa4PSNPsWVfQyGtidrsetzFlfU4H2AzJbwZFw
        pnTfuh7ju8WZpuziwwD76c3hTvlD
X-Google-Smtp-Source: APXvYqxcBGHWQlnNQoNX1FXZX5RFHq9EuOwd1YS01dLVqXA5jaGlv1sWrmeDFHoBizM8x7X0afv2Eg==
X-Received: by 2002:a5d:4e8a:: with SMTP id e10mr11524150wru.26.1564049482060;
        Thu, 25 Jul 2019 03:11:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3sm40831028wmg.15.2019.07.25.03.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 03:11:21 -0700 (PDT)
Date:   Thu, 25 Jul 2019 03:11:21 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 10:11:10 GMT
Message-Id: <30405df99ff38466987e64c1dea007ff6fb9b8c8.1564049474.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 09/12] rebase -r: support merge strategies other than
 `recursive`
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

We already support merge strategies in the sequencer, but only for
`pick` commands.

With this commit, we now also support them in `merge` commands. The
approach is simple: if any merge strategy option is specified, or if any
merge strategy other than `recursive` is specified, we simply spawn the
`git merge` command. Otherwise, we handle the merge in-process just as
before.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt           |  2 --
 builtin/rebase.c                       |  9 ---------
 sequencer.c                            | 14 ++++++++++++--
 t/t3422-rebase-incompatible-options.sh | 10 ----------
 t/t3430-rebase-merges.sh               | 21 +++++++++++++++++++++
 5 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f5e6ae3907..f67f96425c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -543,8 +543,6 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --interactive
  * --preserve-merges and --signoff
  * --preserve-merges and --rebase-merges
- * --rebase-merges and --strategy
- * --rebase-merges and --strategy-option
 
 BEHAVIORAL DIFFERENCES
 -----------------------
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 9c52144fc4..c1ea617125 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1815,15 +1815,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			      "'--reschedule-failed-exec'"));
 	}
 
-	if (options.rebase_merges) {
-		if (strategy_options.nr)
-			die(_("cannot combine '--rebase-merges' with "
-			      "'--strategy-option'"));
-		if (options.strategy)
-			die(_("cannot combine '--rebase-merges' with "
-			      "'--strategy'"));
-	}
-
 	if (!options.root) {
 		if (argc < 1) {
 			struct branch *branch;
diff --git a/sequencer.c b/sequencer.c
index 334de14542..d228448cd8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3256,6 +3256,9 @@ static int do_merge(struct repository *r,
 	struct commit *head_commit, *merge_commit, *i;
 	struct commit_list *bases, *j, *reversed = NULL;
 	struct commit_list *to_merge = NULL, **tail = &to_merge;
+	const char *strategy = !opts->xopts_nr &&
+		(!opts->strategy || !strcmp(opts->strategy, "recursive")) ?
+		NULL : opts->strategy;
 	struct merge_options o;
 	int merge_arg_len, oneline_offset, can_fast_forward, ret, k;
 	static struct lock_file lock;
@@ -3404,7 +3407,7 @@ static int do_merge(struct repository *r,
 		goto leave_merge;
 	}
 
-	if (to_merge->next) {
+	if (strategy || to_merge->next) {
 		/* Octopus merge */
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
@@ -3418,7 +3421,14 @@ static int do_merge(struct repository *r,
 		cmd.git_cmd = 1;
 		argv_array_push(&cmd.args, "merge");
 		argv_array_push(&cmd.args, "-s");
-		argv_array_push(&cmd.args, "octopus");
+		if (!strategy)
+			argv_array_push(&cmd.args, "octopus");
+		else {
+			argv_array_push(&cmd.args, strategy);
+			for (k = 0; k < opts->xopts_nr; k++)
+				argv_array_pushf(&cmd.args,
+						 "-X%s", opts->xopts[k]);
+		}
 		argv_array_push(&cmd.args, "--no-edit");
 		argv_array_push(&cmd.args, "--no-ff");
 		argv_array_push(&cmd.args, "--no-log");
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index bb78a6ec86..596caf168a 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -75,14 +75,4 @@ test_expect_success '--preserve-merges incompatible with --rebase-merges' '
 	test_must_fail git rebase --preserve-merges --rebase-merges A
 '
 
-test_expect_success '--rebase-merges incompatible with --strategy' '
-	git checkout B^0 &&
-	test_must_fail git rebase --rebase-merges -s resolve A
-'
-
-test_expect_success '--rebase-merges incompatible with --strategy-option' '
-	git checkout B^0 &&
-	test_must_fail git rebase --rebase-merges -Xignore-space-change A
-'
-
 test_done
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 42ba5b9f09..8ea6ff3548 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -412,4 +412,25 @@ test_expect_success '--continue after resolving conflicts after a merge' '
 	test_path_is_missing .git/MERGE_HEAD
 '
 
+test_expect_success '--rebase-merges with strategies' '
+	git checkout -b with-a-strategy F &&
+	test_tick &&
+	git merge -m "Merge conflicting-G" conflicting-G &&
+
+	: first, test with a merge strategy option &&
+	git rebase -ir -Xtheirs G &&
+	echo conflicting-G >expect &&
+	test_cmp expect G.t &&
+
+	: now, try with a merge strategy other than recursive &&
+	git reset --hard @{1} &&
+	write_script git-merge-override <<-\EOF &&
+	echo overridden$1 >>G.t
+	git add G.t
+	EOF
+	PATH="$PWD:$PATH" git rebase -ir -s override -Xxopt G &&
+	test_write_lines G overridden--xopt >expect &&
+	test_cmp expect G.t
+'
+
 test_done
-- 
gitgitgadget

