Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B65C41F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfJUN4d (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:56:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41062 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfJUN4c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id p4so14113229wrm.8
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MdttcHwYY98Nj6YWdfs9E5YtG7PCh3prnOQCnJGwcms=;
        b=aN8uiJFpAnxS9dtoA4ZHEiopTP0xljBn2Ie/VUPwUVFLOkZHvD+qVyKM5j/lp6VUS9
         BDSqd+ENql4NUMJ+r/l/+3nO/ot+MlJT9xxai9kCZ4sXTTSJaqwD4JbewFqKdaFv3yVH
         qcaDx3kkmwu7Z52fDtrZ/ARUd25oOcqpWU6cdNIvzyXd0eMs9moOhmkqtik8kotqvsJc
         Wx6xWbbJF+tXIDp9K+5e3oq+ppVYjHI8FE2PAuM0NH9nnK1j2qxbuOYKTGM403K9FxEF
         NeEjKNqx9vZIbHS6z/7xg+UHjI2zfjLjqhjne86vPIn4LgEE6uPnAyUcL2I7hmzbTG4Q
         EuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MdttcHwYY98Nj6YWdfs9E5YtG7PCh3prnOQCnJGwcms=;
        b=huVinnFDfzEkSxd2TyE0d3QU1VI+P3kXrAvqUUoXQ9w259HhXFxlnA5+UQLzuc/bba
         5XXpW9Whftj7VzW15BaCr3n9fMtqRS+AHumxmuErhUr+6KbjsshSv/R6oS/vP7+EeW2L
         8BUz2eCZu+JFTE7axY+tyXej8AsiG/FNs9o+iTyPdcNKSoF9MblrzfaWJnn9DVMkD1Kp
         6GxNxN6jPwEmEribURsF6YUdD771Ztg+OX10hsndSK9eVs6cpLI/HjH4BLRxN/La5KsZ
         dqztDsr56dLyma0VPwy1BZ8SkSuA4kKsu2AJ7jvLggJRARBOvu+sr2IjfabUW/9iEdhK
         702Q==
X-Gm-Message-State: APjAAAUxFeQONShCbt/eF/Pp0i8A6W5CLab2fPCJOaDnbqyo3fIiZ9RP
        wOUz/AgnPNj3b1fZmK8U04XiTJu5
X-Google-Smtp-Source: APXvYqy2Iop77NCzjI3NRLGOk0i1pm/qTXAAQ4lw3nGOqkI9Wg1YWKgvbPmnIutpDdgYHXuj2A/5Bg==
X-Received: by 2002:adf:93e1:: with SMTP id 88mr10062764wrp.198.1571666190410;
        Mon, 21 Oct 2019 06:56:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 143sm24158728wmb.33.2019.10.21.06.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:56:30 -0700 (PDT)
Message-Id: <a161cee0dfec76e7a08253083f488e2e6d26299e.1571666186.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 13:56:11 +0000
Subject: [PATCH v5 02/17] sparse-checkout: create 'init' subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
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
index 9d6ca22917..930a361567 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -30,6 +30,17 @@ COMMANDS
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
 ---------------
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 5717c9b2cb..77aa52ca01 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout list"),
+	N_("git sparse-checkout (init|list)"),
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
+	fp = xfopen(sparse_filename, "w");
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
index 9b73d44907..cd56cc384b 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -42,4 +42,45 @@ test_expect_success 'git sparse-checkout list (populated)' '
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

