Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5121F463
	for <e@80x24.org>; Thu, 19 Sep 2019 14:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389260AbfISOnW (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 10:43:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33615 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388859AbfISOnS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 10:43:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id r17so7348080wme.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WWtbC5nTP7f/ZxACRDMdPISN1ij1tPLUd2relRVCRwg=;
        b=df/tl8ODno5bALxRAmIpsmwFi105Me/KCBaGMXWR4TD4HRjvH6xlY7WRnz998wneGC
         FVEkqtZ2TFfqqaRl/JROb9GNFoADLrIHzVM73exaCRELUlsBqDGihf42YS+dD4Q5SwH9
         nwGnX4oklAZCZEaycwv36X/Xl0RKy8RsRgoavubrwtdsrFI2idIaiSvTl96hdT8ErtnP
         /2bzUOKNREAxFR9S8pvSkcVhPf0rRuDOQRcbVimJYs96VLXRlrx1wTqLYYgfrU0uwjIX
         V45/PETJfIdAq0mNNJGyaybALKZpjV9i4JnnBt0YVYU+9NgTdgucBIU9AGUnDsSxNp69
         K2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WWtbC5nTP7f/ZxACRDMdPISN1ij1tPLUd2relRVCRwg=;
        b=QBt/OcdU9LfrQNT9DOzCs1P4Xzp4zfe0FAMZD+6NLLHFghvOudZdVTBDRx7Rad5Xz+
         FRNXzQQrWIMVTRiirYvILXBJRwp65qVMVlj+gieJ14BY/jColkJ7DpC5/RRJFdmjG3i9
         Tt/DXKNyyaxdffN6RDlkgBD8aedeqW4lAOMG4gAqACpNam4VoSBHAnEfnalx2t8gK4wy
         807z/yClaDngpNK1FfRMupecPt5mL2EpUBLIG3GHFQY4J4hRwQMyBqDRkuScJo6dnaWD
         rUm3kawfuwDcA8LluulP7hka4729f3slnjurkhZ8+iSQKGaaXxD7Lj7ydXxw0FshvY5P
         h9Vg==
X-Gm-Message-State: APjAAAUK0x8yOtJ4Uj+ctYdcWChScfyShqNugD51hq26Sp7+/SxbGIUd
        EqPiDObPOqju3TsfjwPGHxbNfvkN
X-Google-Smtp-Source: APXvYqz8FTNswUyqlwnI/Nb5J9x6olVVFRpyi/9kGcM46k/FwXqW7940fvm8Ea/59PLuqNjEQnpzJw==
X-Received: by 2002:a1c:9e46:: with SMTP id h67mr3304073wme.48.1568904195020;
        Thu, 19 Sep 2019 07:43:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q66sm8716353wme.39.2019.09.19.07.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 07:43:14 -0700 (PDT)
Date:   Thu, 19 Sep 2019 07:43:14 -0700 (PDT)
X-Google-Original-Date: Thu, 19 Sep 2019 14:43:03 GMT
Message-Id: <b62b76013f98e57089c9b0c03209e28757977dd7.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v2.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
        <pull.316.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 06/11] sparse-checkout: create 'disable' subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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
 Documentation/git-sparse-checkout.txt | 26 ++++++++-----------
 builtin/sparse-checkout.c             | 37 ++++++++++++++++++++++++---
 t/t1091-sparse-checkout-builtin.sh    | 15 +++++++++++
 3 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 87813e5797..da95b28b1c 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -39,6 +39,10 @@ COMMANDS
 	a list of arguments following the 'set' subcommand. Update the
 	working directory to match the new patterns.
 
+'disable'::
+	Remove the sparse-checkout file, set `core.sparseCheckout` to
+	`false`, and restore the working directory to include all files.
+
 SPARSE CHECKOUT
 ----------------
 
@@ -61,6 +65,13 @@ Then it compares the new skip-worktree value with the previous one. If
 skip-worktree turns from set to unset, it will add the corresponding
 file back. If it turns from unset to set, that file will be removed.
 
+To repopulate the working directory with all files, use the
+`git sparse-checkout disable` command.
+
+Sparse checkout support in 'git checkout' and similar commands is
+disabled by default. You need to set `core.sparseCheckout` to `true`
+in order to have sparse checkout support.
+
 ## FULL PATTERN SET
 
 By default, the sparse-checkout file uses the same syntax as `.gitignore`
@@ -75,21 +86,6 @@ using negative patterns. For example, to remove the file `unwanted`:
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
-read-tree' and similar commands is disabled by default. You need to
-set `core.sparseCheckout` to `true` in order to have sparse checkout
-support.
 
 SEE ALSO
 --------
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index f726fcd6b8..f858f0b1b5 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout [init|list|set] <options>"),
+	N_("git sparse-checkout [init|list|set|disable] <options>"),
 	NULL
 };
 
@@ -74,7 +74,7 @@ static int update_working_directory(void)
 	return result;
 }
 
-static int sc_enable_config(void)
+static int sc_set_config(int mode)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
@@ -83,7 +83,12 @@ static int sc_enable_config(void)
 		return 1;
 	}
 
-	argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", "true", NULL);
+	argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", NULL);
+
+	if (mode)
+		argv_array_pushl(&argv, "true", NULL);
+	else
+		argv_array_pushl(&argv, "false", NULL);
 
 	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
 		error(_("failed to enable core.sparseCheckout"));
@@ -101,7 +106,7 @@ static int sparse_checkout_init(int argc, const char **argv)
 	int res;
 	struct object_id oid;
 
-	if (sc_enable_config())
+	if (sc_set_config(1))
 		return 1;
 
 	memset(&pl, 0, sizeof(pl));
@@ -188,6 +193,28 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 	return write_patterns_and_update(&pl);
 }
 
+static int sparse_checkout_disable(int argc, const char **argv)
+{
+	char *sparse_filename;
+	FILE *fp;
+
+	if (sc_set_config(1))
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
+	return sc_set_config(0);
+}
+
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_options[] = {
@@ -212,6 +239,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 			return sparse_checkout_init(argc, argv);
 		if (!strcmp(argv[0], "set"))
 			return sparse_checkout_set(argc, argv, prefix);
+		if (!strcmp(argv[0], "disable"))
+			return sparse_checkout_disable(argc, argv);
 	}
 
 	usage_with_options(builtin_sparse_checkout_usage,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 02ba9ec314..22fa032d6d 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -140,5 +140,20 @@ test_expect_success 'set sparse-checkout using --stdin' '
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

