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
	by dcvr.yhbt.net (Postfix) with ESMTP id C72391F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbfJUN4k (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:56:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44061 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfJUN4g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so14107988wrl.11
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HlIZIXXEGIo6p95Tf1uQT0iuIhvv91TiapywK9qe7Vw=;
        b=BB6hmjmmQB7Za6LpjR06iN/2ednnCeyv2AMuAxd18GnwjbDJYXuJTAy+Tu09wd+oGb
         PCWn8sLsQUcdinfnx5RcoC11yIF2hMUkB3bKil/+pib5cCF55n+7iHkuEIcsJkEQ5jsn
         FU+YlL1k0LfZs0/xpGla+Nsx7RuM9WwSzbOQ6T8GSUB8hbmhc5kDF0HKQxDuBpc6/oPx
         9I72wT6IxRZfFWpF09LcYekEmXIGzPsBkimNGPIVwT3dAcwQNlvtKVxwGnyJfvwUIRT6
         mU7dZLhMjH3Agr41hA9+f8hw6unbjtMKfeRIFjIcoPiHjvOexWfeLPT42O03X3M/4/i1
         Ut2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HlIZIXXEGIo6p95Tf1uQT0iuIhvv91TiapywK9qe7Vw=;
        b=NUl3id25FuQZC14ZOqU9v+nwz09FugXlq+cWqH0a/tlPkhpbKwX3STYleLb9JOlbdX
         sjPocfOUhOi6rwuszucO+Z6nkurDz7E+JCV3PdprVlGpI7sEQSWlPs4haz6qP5Z9l1i8
         EzfAOCjZwLUg8e+kqFDxigqp/PezqTGei+YMGzP+7z6VtT5fxKpTNralTLVASamYq8an
         j3BlQTfVMdITVvm+jxGD4F6bsWwqFn/WTN85JwcrHgp5kNzG3JdUuC1+6vQSRjQNzic2
         7niW2CXG220EIVpGFhWw5rpoUhzB1sNuxpxTv7hIbGwOGWVoEFoHYrAXNK/mOWM7olb8
         rUSA==
X-Gm-Message-State: APjAAAWqPb6XeG7CPMRJmHvpzRPooF+rTVpW09nqAqX1WMFrzIxd6BLW
        wubZ2epdIiggldYi6xvqGT5lwjL5
X-Google-Smtp-Source: APXvYqze5g4p3H+Me7aWSkWZR1ESwbyGLNaP29+Kdg4dSzvOg7JrSWAwhfBhhvOylRuGpA35zGetaA==
X-Received: by 2002:adf:db0e:: with SMTP id s14mr16208321wri.341.1571666193894;
        Mon, 21 Oct 2019 06:56:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm3191187wrs.66.2019.10.21.06.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:56:33 -0700 (PDT)
Message-Id: <c48535cd5c00310403ffccac7507f399fca5a8a4.1571666187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 13:56:15 +0000
Subject: [PATCH v5 06/17] sparse-checkout: create 'disable' subcommand
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
index b933043b3d..f794d4797a 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -48,6 +48,10 @@ To avoid interfering with other worktrees, it first enables the
 	working directory to match the new patterns. Enable the
 	core.sparseCheckout config setting if it is not already enabled.
 
+'disable'::
+	Remove the sparse-checkout file, set `core.sparseCheckout` to
+	`false`, and restore the working directory to include all files.
+
 SPARSE CHECKOUT
 ---------------
 
@@ -65,6 +69,14 @@ directory, it updates the skip-worktree bits in the index based
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
@@ -79,21 +91,6 @@ using negative patterns. For example, to remove the file `unwanted`:
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
index f2e2bd772d..9fdcc6c4ef 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout (init|list|set) <options>"),
+	N_("git sparse-checkout (init|list|set|disable) <options>"),
 	NULL
 };
 
@@ -212,6 +212,28 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
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
+	fp = xfopen(sparse_filename, "w");
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
@@ -236,6 +258,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 			return sparse_checkout_init(argc, argv);
 		if (!strcmp(argv[0], "set"))
 			return sparse_checkout_set(argc, argv, prefix);
+		if (!strcmp(argv[0], "disable"))
+			return sparse_checkout_disable(argc, argv);
 	}
 
 	usage_with_options(builtin_sparse_checkout_usage,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index a9ff5eb9ec..583c232e9e 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -148,4 +148,19 @@ test_expect_success 'set sparse-checkout using --stdin' '
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

