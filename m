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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5888B1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfJGUIg (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:08:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40300 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbfJGUIf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:08:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so8044053wrv.7
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KeGMbRfWq35qGoB01h+OKt/QCL6R7U6GtY5OifdqwGo=;
        b=IwAdt3yB30SuO8d1wgWdiJMuFr/UD5i+IbPXdrx+2GlaQtT3PboXbO/XSRMXJzOacn
         Z6a6hmeBcZtqjVHql7z+9rSx+tpPyHrlHHvmQEf2uOfFbbuoaOIJDJRYBkFcoGih/GBD
         iUznaoKC9Xq2HP1DbTXpVmKe1/TTmmvfOCw2yxvkPweTmJpfjMzy+Acw6zO+fw5ELJ5E
         17pxT1KqHXYKH1yWO8HGfgAe3XjU6Ib7EmnxjhbkMbctd/fBVTLndZwi52E13W0RXsvu
         jvRngF9KtFALWLG1IcNf/roEbp2/7sHs/WcjC3H/0/HcVLwk06sD705zOEwzlpz4qpTn
         6EHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KeGMbRfWq35qGoB01h+OKt/QCL6R7U6GtY5OifdqwGo=;
        b=Poiru0SXj4YbqAQjZgPG23suElBwZ7ZBWslifRC9ji8ZPuDDmpU+Lpna3zTI3IHQuM
         KWOibqe0M8wihwO/FdJY3yP5d+1aFtMhVtAkdeuc2na/nkId85Li1iOruqypmJt0D45t
         5bHIiVoyVCrx5GrMD3c4RH1Kbsv+ydhZCllbT86tjOsEqgrC+3Abaj0djtBM0hKk4Vh7
         imy7aAaMqEW36qEa+zjb14/IN/cx3CQuA4DzJ69Slr/Lm+i/wCtaH1jJxH/Qon7x9rjw
         HBSXLAHwaqfoFNERiIuiAQAlEac4FK+DItZi6SJ7nfUf1FoxT/3ALB69jljOo1H1DF+V
         ojEQ==
X-Gm-Message-State: APjAAAX3LYLq8eve9uw+Levgrdb8aAdGv8XW/gDC1Wt3jODesnABef+Y
        zG/z1xqhvKnc2ELzfdM+7YGQlYIo
X-Google-Smtp-Source: APXvYqzBE002w00rnH7ZxiQati8/z5Iahe02COaVkDfMwqXx0mrp4RWaxcmvMQsoWAeVxPDeP6U12w==
X-Received: by 2002:a05:6000:128e:: with SMTP id f14mr23357080wrx.73.1570478909101;
        Mon, 07 Oct 2019 13:08:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5sm498973wma.14.2019.10.07.13.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:08:28 -0700 (PDT)
Date:   Mon, 07 Oct 2019 13:08:28 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 20:08:10 GMT
Message-Id: <08bb6fb7f31b92395df4db10bf47e9a9c01257f4.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
        <pull.316.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 02/17] sparse-checkout: create 'init' subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Junio C Hamano <gitster@pobox.com>,
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
 Documentation/git-sparse-checkout.txt | 12 ++++
 builtin/sparse-checkout.c             | 79 ++++++++++++++++++++++++++-
 t/t1091-sparse-checkout-builtin.sh    | 41 ++++++++++++++
 3 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 81676b1d33..e095c4a98b 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -26,6 +26,18 @@ COMMANDS
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
+The init subcommand also enables the 'extensions.worktreeConfig' setting
+and sets the `core.sparseCheckout` setting in the worktree-specific config
+file. This prevents the sparse-checkout feature from interfering with other
+worktrees.
 
 SPARSE CHECKOUT
 ----------------
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index eed9625a05..64b2bb2b8c 100644
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
+	MODE_NONE = 0,
+	MODE_FULL = 1,
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
+	if (sc_set_config(MODE_FULL))
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

