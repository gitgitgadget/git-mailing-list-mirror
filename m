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
	by dcvr.yhbt.net (Postfix) with ESMTP id CBD681F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 13:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbfJON4S (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 09:56:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43031 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731638AbfJON4P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id j18so23982274wrq.10
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V82XoyRmjxW3G0fVzutbPtUf2mh69dAajlc8+DwfvQs=;
        b=cYcIRl3RliIsB+wTWXr7asv5KWdwYEdCv7ZrsnizjiFQH8xiIsUPo+9byCboy+2/oJ
         nqcKZhp8FnApiab3hrmGJhTWmgLkRMiMNn9TspwHk9GO7aFYgsvS7WRhv1GnGSZ96yYu
         SqkZq8ozglaffQKlIyW15gcmNySdUr131aOevC2CNJQev21w2F2k9jARXfmQooR6qnEM
         UTakzooV+fhfAXmxAT1m7pK7Ci7oJghGotjmJiuFMrcvrMQJXeVtrPMEQQH4vJrx5o0T
         RFZTm1DJiXrwSfS8HVi0oreKgQgwEecydfvLP44aXD2cPi1Hzi1WfODj3j/ri5hT2jaz
         lVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V82XoyRmjxW3G0fVzutbPtUf2mh69dAajlc8+DwfvQs=;
        b=jkwPXlE9q5u6vyUQ/dMpGLRwudYRh/8OM4/yZY6rDDRD1zeK17wFUJkpeXDV1sdWzl
         DOYsYBzHSmpTMVAvqxA75Xdwa2Z1pefGOPswNc7MJhpjGqMKNtNoUFrxL/vP1Oc1ePZ6
         0hY3mHX8dStR1fa+rrpC1vAMYtlbGXQ9Idyk6gRzX9HSytU7nLkpIYUxBBlZvBu3TM55
         teWlodzq+M1YwOaxCpdKqpLLLUGEzzn/TLv/b4j2ikBdBtrf7ZqpE41aNsUVkioOd//4
         LFY5cvGW0PIjpj3K06/OX3vSAsLOpyZroxam9Efv+xjmyeX/dcZT9jcV7h6s03wyWJFp
         EHjQ==
X-Gm-Message-State: APjAAAWr/ZSp53yT7ijCCvtSsy8DrsYUNdSMa6uys4ZR2JZpNmKyCwYn
        MTJFYqmY4nPr8MOhqV6tpwSkSOS8
X-Google-Smtp-Source: APXvYqzuryRXjNJeKDeuDblTJ8L7C3w+rQFZyGqzRedhMQ8ZzgkozxnAW3Vw32ozJ0eLKcEHmB2aFw==
X-Received: by 2002:adf:dd4c:: with SMTP id u12mr3548263wrm.170.1571147772291;
        Tue, 15 Oct 2019 06:56:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t4sm16981799wrm.13.2019.10.15.06.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:56:11 -0700 (PDT)
Message-Id: <55f95f290ef77fa402f3e73f9c3045177bd70e84.1571147765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
        <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 13:55:53 +0000
Subject: [PATCH v4 06/17] sparse-checkout: create 'disable' subcommand
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

The instructions for disabling a sparse-checkout to a full
working directory are complicated and non-intuitive. Add a
subcommand, 'git sparse-checkout disable', to perform those
steps for the user.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt | 27 ++++++++++++---------------
 builtin/sparse-checkout.c             | 26 +++++++++++++++++++++++++-
 t/t1091-sparse-checkout-builtin.sh    | 15 +++++++++++++++
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 163f6c8db0..b0c141b582 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -45,6 +45,10 @@ To avoid interfering with other worktrees, it first enables the
 	a list of arguments following the 'set' subcommand. Update the
 	working directory to match the new patterns.
 
+'disable'::
+	Remove the sparse-checkout file, set `core.sparseCheckout` to
+	`false`, and restore the working directory to include all files.
+
 SPARSE CHECKOUT
 ----------------
 
@@ -62,6 +66,14 @@ directory, it updates the skip-worktree bits in the index based
 on this file. The files matching the patterns in the file will
 appear in the working directory, and the rest will not.
 
+To enable the sparse-checkout feature, run `git sparse-checkout init` to
+initialize a simple sparse-checkout file and enable the `core.sparseCheckout`
+config setting. Then, run `git sparse-checkout set` to modify the patterns in
+the sparse-checkout file.
+
+To repopulate the working directory with all files, use the
+`git sparse-checkout disable` command.
+
 ## FULL PATTERN SET
 
 By default, the sparse-checkout file uses the same syntax as `.gitignore`
@@ -76,21 +88,6 @@ using negative patterns. For example, to remove the file `unwanted`:
 !unwanted
 ----------------
 
-Another tricky thing is fully repopulating the working directory when you
-no longer want sparse checkout. You cannot just disable "sparse
-checkout" because skip-worktree bits are still in the index and your working
-directory is still sparsely populated. You should re-populate the working
-directory with the `$GIT_DIR/info/sparse-checkout` file content as
-follows:
-
-----------------
-/*
-----------------
-
-Then you can disable sparse checkout. Sparse checkout support in 'git
-checkout' and similar commands is disabled by default. You need to
-set `core.sparseCheckout` to `true` in order to have sparse checkout
-support.
 
 SEE ALSO
 --------
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index b747b78d34..78a80ce119 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout [init|list|set] <options>"),
+	N_("git sparse-checkout [init|list|set|disable] <options>"),
 	NULL
 };
 
@@ -207,6 +207,28 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
+static int sparse_checkout_disable(int argc, const char **argv)
+{
+	char *sparse_filename;
+	FILE *fp;
+
+	if (sc_set_config(MODE_ALL_PATTERNS))
+		die(_("failed to change config"));
+
+	sparse_filename = get_sparse_checkout_filename();
+	fp = fopen(sparse_filename, "w");
+	fprintf(fp, "/*\n");
+	fclose(fp);
+
+	if (update_working_directory())
+		die(_("error while refreshing working directory"));
+
+	unlink(sparse_filename);
+	free(sparse_filename);
+
+	return sc_set_config(MODE_NO_PATTERNS);
+}
+
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_options[] = {
@@ -231,6 +253,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 			return sparse_checkout_init(argc, argv);
 		if (!strcmp(argv[0], "set"))
 			return sparse_checkout_set(argc, argv, prefix);
+		if (!strcmp(argv[0], "disable"))
+			return sparse_checkout_disable(argc, argv);
 	}
 
 	usage_with_options(builtin_sparse_checkout_usage,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 2a0137fde3..52d24c66ba 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -147,4 +147,19 @@ test_expect_success 'set sparse-checkout using --stdin' '
 	test_cmp expect dir
 '
 
+test_expect_success 'sparse-checkout disable' '
+	git -C repo sparse-checkout disable &&
+	test_path_is_missing repo/.git/info/sparse-checkout &&
+	git -C repo config --list >config &&
+	test_i18ngrep "core.sparsecheckout=false" config &&
+	ls repo >dir &&
+	cat >expect <<-EOF &&
+		a
+		deep
+		folder1
+		folder2
+	EOF
+	test_cmp expect dir
+'
+
 test_done
-- 
gitgitgadget

