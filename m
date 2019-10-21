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
	by dcvr.yhbt.net (Postfix) with ESMTP id D3BC21F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfJUN4e (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:56:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45819 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfJUN4d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id q13so9141484wrs.12
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/ZKw8/obR5Ihbs8rwzjjHOhiY4JwaEHKEy7Urcr0ub0=;
        b=nI7wlu0tOUsHDSXZ0HcxjIroHu/pOXGD81cVeU3vZJe0IVKegp+1u+QUxNn/xcY08C
         pXulam3QHpptIiBB39OC267a92veymUabpTC3V/QxLcB2TP41PD1a58LpOEokw6ORp7S
         jsto5YF/LwZuKs2AMAesNgCYiyuhhR89kR97e7BAWZwRsW8JscLFC9gspvNZVao359pr
         fFwYGPDFTtvVFxDCl22wRwAz8v610hkJ4KvKlvxm/0BdVZKBWq+6eed5RntE9xma6IZW
         bFH6kQvkLc4VWrDEVyueDws67Kgv7LH6QOHCI5l9K48iQsv0402dTJ11tTlGNyoTA1gQ
         rZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/ZKw8/obR5Ihbs8rwzjjHOhiY4JwaEHKEy7Urcr0ub0=;
        b=XZ5rye9NKt3f3XA0uYyqJyjxtGb/C8WHylpvb7LRVERdmLwzh4YDAwsLActr8eFOri
         TnWv2gLFXFVRP3ifOeOnsSpCsibhnKlI9rN6L86GPfABbUZZBAjQ6ywZofEajubgn7pD
         Arly5ek3mv3Af8pBA9W4I9E9G+9VK8BmdObXjdvMQca0JSiPD5B8iPqIARpfP/ETI6q7
         immB9sBtheEFvr7UgWOtW1I4nMd9xO6xqwYER4MC+z9BMWXBYJKhKqcOp9oSjZ9nao36
         eyoEzUC+ksND4Vj76Q5NUSfJMfG+Y1zUARBeVvRKin2LQXPxJ3NPls9JKim52nUHPzEb
         u22w==
X-Gm-Message-State: APjAAAXz6SYOoxZ9CbD/6DCDbQBjm4y4tgj0FBQLlsZd6abyK6ZNtCS+
        nxpSFsw91cdoDQaaHMmRVG8VDzZ7
X-Google-Smtp-Source: APXvYqxJn3Y+jAp6cJGeDh5LcNLzeZxqeRRqbYKugqGgOg99qHDi4L+NFeijssQAYF04I8n03vcKtw==
X-Received: by 2002:a5d:6585:: with SMTP id q5mr19879289wru.74.1571666192124;
        Mon, 21 Oct 2019 06:56:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q196sm10478742wme.23.2019.10.21.06.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:56:31 -0700 (PDT)
Message-Id: <7d9d66a89f473244af3601e13caa713d929a202d.1571666186.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 13:56:13 +0000
Subject: [PATCH v5 04/17] sparse-checkout: 'set' subcommand
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

The 'git sparse-checkout set' subcommand takes a list of patterns
as arguments and writes them to the sparse-checkout file. Then, it
updates the working directory using 'git read-tree -mu HEAD'.

The 'set' subcommand will replace the entire contents of the
sparse-checkout file. The write_patterns_and_update() method is
extracted from cmd_sparse_checkout() to make it easier to implement
'add' and/or 'remove' subcommands in the future.

If the core.sparseCheckout config setting is disabled, then enable
the config setting in the worktree config. If we set the config
this way and the sparse-checkout fails, then re-disable the config
setting.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt |  6 ++++
 builtin/sparse-checkout.c             | 45 ++++++++++++++++++++++++++-
 t/t1091-sparse-checkout-builtin.sh    | 32 +++++++++++++++++++
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 930a361567..b933043b3d 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -42,6 +42,12 @@ To avoid interfering with other worktrees, it first enables the
 `extensions.worktreeConfig` setting and makes sure to set the
 `core.sparseCheckout` setting in the worktree-specific config file.
 
+'set'::
+	Write a set of patterns to the sparse-checkout file, as given as
+	a list of arguments following the 'set' subcommand. Update the
+	working directory to match the new patterns. Enable the
+	core.sparseCheckout config setting if it is not already enabled.
+
 SPARSE CHECKOUT
 ---------------
 
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 6c336b7ab3..834ee421f0 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout (init|list)"),
+	N_("git sparse-checkout (init|list|set) <options>"),
 	NULL
 };
 
@@ -140,6 +140,47 @@ static int sparse_checkout_init(int argc, const char **argv)
 	return update_working_directory();
 }
 
+static int write_patterns_and_update(struct pattern_list *pl)
+{
+	char *sparse_filename;
+	FILE *fp;
+
+	sparse_filename = get_sparse_checkout_filename();
+	fp = fopen(sparse_filename, "w");
+	write_patterns_to_file(fp, pl);
+	fclose(fp);
+	free(sparse_filename);
+
+	return update_working_directory();
+}
+
+static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
+{
+	static const char *empty_base = "";
+	int i;
+	struct pattern_list pl;
+	int result;
+	int set_config = 0;
+	memset(&pl, 0, sizeof(pl));
+
+	for (i = 1; i < argc; i++)
+		add_pattern(argv[i], empty_base, 0, &pl, 0);
+
+	if (!core_apply_sparse_checkout) {
+		sc_set_config(MODE_ALL_PATTERNS);
+		core_apply_sparse_checkout = 1;
+		set_config = 1;
+	}
+
+	result = write_patterns_and_update(&pl);
+
+	if (result && set_config)
+		sc_set_config(MODE_NO_PATTERNS);
+
+	clear_pattern_list(&pl);
+	return result;
+}
+
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_options[] = {
@@ -162,6 +203,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 			return sparse_checkout_list(argc, argv);
 		if (!strcmp(argv[0], "init"))
 			return sparse_checkout_init(argc, argv);
+		if (!strcmp(argv[0], "set"))
+			return sparse_checkout_set(argc, argv, prefix);
 	}
 
 	usage_with_options(builtin_sparse_checkout_usage,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index cb74715ca6..bf2dc55bb1 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -96,4 +96,36 @@ test_expect_success 'clone --sparse' '
 	test_cmp expect dir
 '
 
+test_expect_success 'set enables config' '
+	git init empty-config &&
+	(
+		cd empty-config &&
+		test_commit test file &&
+		test_path_is_missing .git/config.worktree &&
+		test_must_fail git sparse-checkout set nothing &&
+		test_i18ngrep "sparseCheckout = false" .git/config.worktree &&
+		git sparse-checkout set "/*" &&
+		test_i18ngrep "sparseCheckout = true" .git/config.worktree
+	)
+'
+
+test_expect_success 'set sparse-checkout using builtin' '
+	git -C repo sparse-checkout set "/*" "!/*/" "*folder*" &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+		*folder*
+	EOF
+	git -C repo sparse-checkout list >actual &&
+	test_cmp expect actual &&
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

