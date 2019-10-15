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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9329F1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 13:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbfJON4Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 09:56:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45721 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732267AbfJON4N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so23947035wrm.12
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0wTK7yuEy9Eg2jsCZBPTn5OVS6q1vvp4NDEtThEbo5s=;
        b=T60HxdWiUpepkVwHvgkR2GuwuqgGtJbPiJSvPXOTXu5gcjHx3IacrV8Q/uzwJVFYSC
         QHZHPbDBMRHGlsdiau8j1t2aXcPDl536N9dNT11fUnIno+PHGNYfjM9gatxUeoSkNMq4
         sEiAaKKvxZyfPEqQV6ZYmy5IYVQbOfkgBWlPCUir+ibSdYg8bWJgeH5OAJmV2cEeap7m
         f3atRnICd852eiHfl/+yw77aBtOga9LLtLRpYVyZDN9B0DuVe+37ALONuZjomo9XnqOE
         Yl3XGEH0IzzcD6HXc8R3jjKDt3EZyHs98SQ9t6PRQ8buyeC29C5d5y5PMcb8UEseD+2c
         fwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0wTK7yuEy9Eg2jsCZBPTn5OVS6q1vvp4NDEtThEbo5s=;
        b=nfhUquK6n1x6FnkfbCN8xwY28m4QfKZ7vG9QwcgxecvMVw5EaunvBtRZ6Uh6HyggUK
         O9nCOYRpMkYIiwcZqTsHqCWPGISiqgF4Ud5VRCExJm+nJBKFDaodB0kMSY4eyyCtwRgo
         rHbiFjtVlM9DB+Sbv1lGqsBNY28XHqeAtsNLygHxeyVZtf4QeI/QIOpnWlMAhqlfEmMo
         1+XEnLXEvMSretr6AAcrKF9T+W/M6QUMggkGUiXaylpaRmBn/5p1XDryLsg+4HXCnNif
         dHjiowQ9BtEQ67lNZ9t9zkUxP0wYhT/1lC7Mukxi2Hc8ykpdqxQo3T4Gv/E+13lRb52d
         ZXQw==
X-Gm-Message-State: APjAAAWiS116ulHrbUY00+hiR1WhoUCfcdz2TMEUmHhYvZxK1VUpnpoW
        Ikx37HmPtgeGxxtrzpL7XQsGgJPf
X-Google-Smtp-Source: APXvYqzsn1Ps2JF+MpfNy9dBAUU5pdN0Yu0MbHzau7aDURQbMtrcBAXBMbmVTQM2iBqF6jpcrKI1bg==
X-Received: by 2002:adf:f306:: with SMTP id i6mr2947443wro.209.1571147770756;
        Tue, 15 Oct 2019 06:56:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c18sm19827766wrv.10.2019.10.15.06.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:56:10 -0700 (PDT)
Message-Id: <502b4b08f0a801dd923c5a4e2a84808d9ae6e3c6.1571147765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
        <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 13:55:51 +0000
Subject: [PATCH v4 04/17] sparse-checkout: 'set' subcommand
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
index d5fbbf17a0..163f6c8db0 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -40,6 +40,11 @@ To avoid interfering with other worktrees, it first enables the
 `extensions.worktreeConfig` setting and makes sure to set the
 `core.sparseCheckout` setting in the worktree-specific config file.
 
+'set'::
+	Write a set of patterns to the sparse-checkout file, as given as
+	a list of arguments following the 'set' subcommand. Update the
+	working directory to match the new patterns.
+
 SPARSE CHECKOUT
 ----------------
 
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 4198995d46..2103cbe00c 100644
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

