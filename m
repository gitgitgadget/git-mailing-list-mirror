Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 367351F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 13:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbfJON4M (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 09:56:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52873 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732229AbfJON4M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so20998074wmh.2
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 06:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Byw8ehyrPE+IxHgcdaigirzAjJqYnFExcpGO8N8R1cw=;
        b=hXLlORly4J8PKNelo1W5KeFuKAU7oG+nFS0m53eMSBpxf3Xj/T2qjmo7t/bOVIRPRj
         bkoVJh1VaEo+9IEZ/woDnRY2ko7EzvFIgNro9uJ9ZVkGGO+Bt7fN13rgV/SOUFGpUlQV
         +HkPj6nE++zIp4HKBz8DZ8rmxei2xbLRd5jORs9UUxKPZB7N0BfvsPnkv/z0NOqS53cH
         TH4prk9/H/mMqxdLuZF/hVJ2E3dluneclSsgqyLgU8ThkfKtBrEmDnRIez14g2hBuuww
         kMvD4Eyt2vpIVahmLEYZLul7IpdvubjAWIqTtsfcl0G6LDcruNVLaUIS9SDURL0XpDHC
         DTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Byw8ehyrPE+IxHgcdaigirzAjJqYnFExcpGO8N8R1cw=;
        b=PuxWfyFg25JipxRDx7vNq2+Oca8i/9gL2T2ad5d3QRupe5UVdK21anbIn46PqrTdTc
         rxiRV48Rme/mXUxo5fWIFw2WC4DgvaSCfFiWuWVoWuVA+ZW3RJdLihknIcls74R0JanS
         uy959sIMfOsjB9ztJYGcAWaBTpstaTSMxTduERh5g7BdnNa4eAb2eNtlFGk9GntAcrc5
         3CzsByKzohAedAmnrDcj5TDOCZ9iW5mc3U5LAiiJ5IPU180wvi+XPIhMQaxt8u+rzjiy
         4GDaknZ3KTAqDqLvTV5pIIsPWreVuWbL8JuVUtDUpWIIxyjRYr6+j+6XJdvTZfhM0ejX
         1+dA==
X-Gm-Message-State: APjAAAV9TJzNVczP3b86RBnwffVVgSrVlBeYMguLdK15Gzta6lfoDo9n
        lqcrepoPQP8JXW3kCt7C/dblWvUL
X-Google-Smtp-Source: APXvYqyKFZDjKjMkh0ZzJdnqoN3DEu8tzSdhpmEwTLuSjixSISAzddhg99x3Yc4S4vdqBPS4EB5/ag==
X-Received: by 2002:a1c:7418:: with SMTP id p24mr18631788wmc.132.1571147768780;
        Tue, 15 Oct 2019 06:56:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18sm2556134wrm.11.2019.10.15.06.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:56:08 -0700 (PDT)
Message-Id: <65d26de1c2724750a51592d02466a4b9ecdea743.1571147765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
        <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 13:55:49 +0000
Subject: [PATCH v4 02/17] sparse-checkout: create 'init' subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Getting started with a sparse-checkout file can be daunting. Help
users start their sparse enlistment using 'git sparse-checkout init'.
This will set 'core.sparseCheckout=true' in their config, write
an initial set of patterns to the sparse-checkout file, and update
their working directory.

Make sure to use the `extensions.worktreeConfig` setting and write
the sparse checkout config to the worktree-specific config file.
This avoids confusing interactions with other worktrees.

The use of running another process for 'git read-tree' is sub-
optimal. This will be removed in a later change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt | 11 ++++
 builtin/sparse-checkout.c             | 79 ++++++++++++++++++++++++++-
 t/t1091-sparse-checkout-builtin.sh    | 41 ++++++++++++++
 3 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 46d3dc3cb1..d5fbbf17a0 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -28,6 +28,17 @@ COMMANDS
 'list'::
 	Provide a list of the contents in the sparse-checkout file.
 
+'init'::
+	Enable the `core.sparseCheckout` setting. If the
+	sparse-checkout file does not exist, then populate it with
+	patterns that match every file in the root directory and
+	no other directories, then will remove all directories tracked
+	by Git. Add patterns to the sparse-checkout file to
+	repopulate the working directory.
++
+To avoid interfering with other worktrees, it first enables the
+`extensions.worktreeConfig` setting and makes sure to set the
+`core.sparseCheckout` setting in the worktree-specific config file.
 
 SPARSE CHECKOUT
 ----------------
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index eed9625a05..1d2327111a 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout [list]"),
+	N_("git sparse-checkout [init|list]"),
 	NULL
 };
 
@@ -59,6 +59,81 @@ static int sparse_checkout_list(int argc, const char **argv)
 	return 0;
 }
 
+static int update_working_directory(void)
+{
+	struct argv_array argv = ARGV_ARRAY_INIT;
+	int result = 0;
+	argv_array_pushl(&argv, "read-tree", "-m", "-u", "HEAD", NULL);
+
+	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+		error(_("failed to update index with new sparse-checkout paths"));
+		result = 1;
+	}
+
+	argv_array_clear(&argv);
+	return result;
+}
+
+enum sparse_checkout_mode {
+	MODE_NO_PATTERNS = 0,
+	MODE_ALL_PATTERNS = 1,
+};
+
+static int sc_set_config(enum sparse_checkout_mode mode)
+{
+	struct argv_array argv = ARGV_ARRAY_INIT;
+
+	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
+		error(_("failed to set extensions.worktreeConfig setting"));
+		return 1;
+	}
+
+	argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", NULL);
+
+	if (mode)
+		argv_array_pushl(&argv, "true", NULL);
+	else
+		argv_array_pushl(&argv, "false", NULL);
+
+	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+		error(_("failed to enable core.sparseCheckout"));
+		return 1;
+	}
+
+	return 0;
+}
+
+static int sparse_checkout_init(int argc, const char **argv)
+{
+	struct pattern_list pl;
+	char *sparse_filename;
+	FILE *fp;
+	int res;
+
+	if (sc_set_config(MODE_ALL_PATTERNS))
+		return 1;
+
+	memset(&pl, 0, sizeof(pl));
+
+	sparse_filename = get_sparse_checkout_filename();
+	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL);
+
+	/* If we already have a sparse-checkout file, use it. */
+	if (res >= 0) {
+		free(sparse_filename);
+		goto reset_dir;
+	}
+
+	/* initial mode: all blobs at root */
+	fp = fopen(sparse_filename, "w");
+	free(sparse_filename);
+	fprintf(fp, "/*\n!/*/\n");
+	fclose(fp);
+
+reset_dir:
+	return update_working_directory();
+}
+
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_options[] = {
@@ -79,6 +154,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 	if (argc > 0) {
 		if (!strcmp(argv[0], "list"))
 			return sparse_checkout_list(argc, argv);
+		if (!strcmp(argv[0], "init"))
+			return sparse_checkout_init(argc, argv);
 	}
 
 	usage_with_options(builtin_sparse_checkout_usage,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index a9b04b1a88..c70085a759 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -47,4 +47,45 @@ test_expect_success 'git sparse-checkout list (populated)' '
 	test_cmp expect list
 '
 
+test_expect_success 'git sparse-checkout init' '
+	git -C repo sparse-checkout init &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	git -C repo config --list >config &&
+	test_i18ngrep "core.sparsecheckout=true" config &&
+	ls repo >dir  &&
+	echo a >expect &&
+	test_cmp expect dir
+'
+
+test_expect_success 'git sparse-checkout list after init' '
+	git -C repo sparse-checkout list >actual &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'init with existing sparse-checkout' '
+	echo "*folder*" >> repo/.git/info/sparse-checkout &&
+	git -C repo sparse-checkout init &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+		*folder*
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	ls repo >dir  &&
+	cat >expect <<-EOF &&
+		a
+		folder1
+		folder2
+	EOF
+	test_cmp expect dir
+'
+
 test_done
-- 
gitgitgadget

