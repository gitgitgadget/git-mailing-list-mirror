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
	by dcvr.yhbt.net (Postfix) with ESMTP id B16881F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfJGUId (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:08:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38519 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfJGUId (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:08:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id w12so16789326wro.5
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mte4WkHKH6ymsAJFJz4FpzNLQTSbPgg/ZJQxgP8yWSk=;
        b=krnWZcpmGB4Xq+iVexwdboyTHtAKA7F3YwnGcjz0JNNNo4DroKdQYcukawxsOMtJ7D
         o3KrmzR0cONH6+/Fq9WDjuNXeLj/8ewQK0NTwbGveacSoZrLIEONiqsIqpTXQIZPW1kw
         yDLyMvVsMBxL4cB0tYdEsAPKXqo5O8AmJdqJgorh8APh+ieK6wMKA99F2gEqY5EHv4d+
         xlPD+8gdfmDKSEmxcr+fO646VvaaVanErDzf86jajLAX78CcTcjzU3ZvVF88pgS1c0e9
         B5sKHu0iJXjNPhQ6W3mVyGXxaJbLvsxLFgcqPq/VhDHJzXkSgAh4tha2Sd7lq/gihN0N
         GP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mte4WkHKH6ymsAJFJz4FpzNLQTSbPgg/ZJQxgP8yWSk=;
        b=gdA1SaJGc3U18ZPTaNZBTep09ma3/h+HlYkypwbnhCg0wJlos6xVV5ugBFWGbfJzhp
         PGP1A8syfFl5Gxx5+2T1yN+wWa2bw8T3bf5bwGvp/9cnFdeLW5+hPlZ9D3HHMtwa767i
         y2j8YXDQvhtaf7bGHyt6Pk/RHrFLLOf9ij3dztz+DuvPkRDii6ICoX/ThPT/9Jos8W0E
         ivHd1he7pK228SRMdbCvMUMlJBVMwZCAnOZeaE+uHFDnUG6gjGFoEh01FmbCr7tj8aEZ
         K5tILJp78bzQTmfamWtMERWV9sgfOrG0RDLHrAmMutkiTuUHPnCBsDRzJRHyOpUuZi2P
         ujgA==
X-Gm-Message-State: APjAAAXAn9ltdpgm/L7cOcHQ6tfo379pA/O//v5FtjbqMxS/G9TvHbMH
        j0KBhzy03D+jFlSAqlWo7FvFGJ0T
X-Google-Smtp-Source: APXvYqzfX9lNXzFzkOlzNFdlV1L34LLVwFDYYQBjXGVNoEb58lWRPkLdA0Nsj6dIRYmr3K5Bq/W5Mg==
X-Received: by 2002:adf:e849:: with SMTP id d9mr24253939wrn.358.1570478911160;
        Mon, 07 Oct 2019 13:08:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11sm373098wml.30.2019.10.07.13.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:08:30 -0700 (PDT)
Date:   Mon, 07 Oct 2019 13:08:30 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 20:08:12 GMT
Message-Id: <6ce1d60b38a249f8d9f85d1b1a1ed556aef2469e.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
        <pull.316.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 04/17] sparse-checkout: 'set' subcommand
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

The 'git sparse-checkout set' subcommand takes a list of patterns
as arguments and writes them to the sparse-checkout file. Then, it
updates the working directory using 'git read-tree -mu HEAD'.

The 'set' subcommand will replace the entire contents of the
sparse-checkout file. The write_patterns_and_update() method is
extracted from cmd_sparse_checkout() to make it easier to implement
'add' and/or 'remove' subcommands in the future.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt |  5 ++++
 builtin/sparse-checkout.c             | 35 ++++++++++++++++++++++++++-
 t/t1091-sparse-checkout-builtin.sh    | 19 +++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index e095c4a98b..f4bd951550 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -39,6 +39,11 @@ and sets the `core.sparseCheckout` setting in the worktree-specific config
 file. This prevents the sparse-checkout feature from interfering with other
 worktrees.
 
+'set'::
+	Write a set of patterns to the sparse-checkout file, as given as
+	a list of arguments following the 'set' subcommand. Update the
+	working directory to match the new patterns.
+
 SPARSE CHECKOUT
 ----------------
 
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 3ecb7ac2e7..52d4f832f3 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout [init|list]"),
+	N_("git sparse-checkout [init|list|set] <options>"),
 	NULL
 };
 
@@ -140,6 +140,37 @@ static int sparse_checkout_init(int argc, const char **argv)
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
+	memset(&pl, 0, sizeof(pl));
+
+	for (i = 1; i < argc; i++)
+		add_pattern(argv[i], empty_base, 0, &pl, 0);
+
+	result = write_patterns_and_update(&pl);
+
+	clear_pattern_list(&pl);
+	return result;
+}
+
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_options[] = {
@@ -162,6 +193,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 			return sparse_checkout_list(argc, argv);
 		if (!strcmp(argv[0], "init"))
 			return sparse_checkout_init(argc, argv);
+		if (!strcmp(argv[0], "set"))
+			return sparse_checkout_set(argc, argv, prefix);
 	}
 
 	usage_with_options(builtin_sparse_checkout_usage,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index d4c145a3af..19e8673c6b 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -101,4 +101,23 @@ test_expect_success 'clone --sparse' '
 	test_cmp expect dir
 '
 
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

