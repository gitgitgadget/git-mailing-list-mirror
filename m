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
	by dcvr.yhbt.net (Postfix) with ESMTP id 340321F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfGaPS7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:18:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40499 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbfGaPSu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so60217978wmj.5
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fDhcbLFegpFzgu6PRtAdOTyb6claf7pEsvDqo1JY5fU=;
        b=UPOqebkrmLDF+EUxZaAFVLHdSrwvozEEOkdvkr25oXlKXMOQ7qyVlP2fgflefc9pID
         p2OiQd/mLkOI0SARLuD/Awn5t+Xd2c5yepH8wz7K0iiblVs6dSscWrbmKzrODPMsIndY
         Q7lWUsLH/hGCdtYlokXBjnOkZt0SOJRiPUj2jnvN0/mFEpz+ht1zOSgoOXivPAslc/W4
         D1IiLqGhnc+A1IYqek+FcIOVO+NjXv2BhrkoMrRo2aa80m+2oPlAdhCJYfhlM59F/5Up
         zfoiYwXdTQ0BeWb4vJZxk67SaDHPjuO6ALQuNmv50Tq9XWyI8bOq/lyW5AXwkObejjXR
         5Xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fDhcbLFegpFzgu6PRtAdOTyb6claf7pEsvDqo1JY5fU=;
        b=J66spIcKxxr3fs71dfPVFRxS8ZUcLRzXXkFuxLddmDyDDx6asuHzyW1cQUZ57kJCPE
         87F7oPSgPzWuApV9mpENw1jAqiuN3LW85EaOySD6Q/v5oKNKp2cfB5BYOOtfC6O7sxQN
         7pE7y43MkV69dXLYr6hkLVsjvRAhNvmfZ14/Nyt/G9schfOcwK3OlVdy7wED7csg8vWa
         zI0m0vaWQ9avAiZeBscZX2aCTv0VzfnSiStDzmuYPM4OZMpyjJXE/rZ5DakrVMrG2/KD
         xrp+kBVLV6MbyuudIceKq85M1bpdL99CQbpqNtTUTezJNGRsN9rPkFPAnh7eG7gJ3PvD
         UDDQ==
X-Gm-Message-State: APjAAAWWiAo+jBIfAYQT9tHllyjC4IeAvokzds853jJlxUiaFUfv5YNx
        AHP2PACaX+JHCsT/V3BlxcrYOglQ
X-Google-Smtp-Source: APXvYqwG5aJByReP0HWszckTYkxamPVi+2Onl3zTa4YWjIH1uUxL4DCUmM4sfIfe2PipzAOJpxNEcg==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr11994710wma.120.1564586327869;
        Wed, 31 Jul 2019 08:18:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t24sm65038548wmj.14.2019.07.31.08.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 08:18:47 -0700 (PDT)
Date:   Wed, 31 Jul 2019 08:18:47 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 15:18:33 GMT
Message-Id: <75b1395dae5f2fac28d3b200b12833821b7b1862.1564586316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.294.v2.git.gitgitgadget@gmail.com>
References: <pull.294.git.gitgitgadget@gmail.com>
        <pull.294.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 13/16] rebase -r: support merge strategies other than
 `recursive`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
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
index 5e4e927647..bc620c44e9 100644
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
index 74a60e8c83..625f50c637 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1811,15 +1811,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
index a5868ea152..50e7960702 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -76,14 +76,4 @@ test_expect_success REBASE_P \
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

