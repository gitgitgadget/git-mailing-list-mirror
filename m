Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BDBD1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 15:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbfHTPLO (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 11:11:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33723 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbfHTPLN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 11:11:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id p77so2634189wme.0
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L+LEPHcTOjgUQy0Kzsi4hjg11l09ygxX10YA9QE0E8E=;
        b=L7WyG2f5uY4SrWqCguLAHzUcUDEQ6mFwdSbOixNnnbnR1/pQtlOU3E3SAfYodajnPK
         ZdMayAfszjikd3FJwEuqS0kzgscWZjfX1wpRKbyY3mYAPtBE51lRH+9Uxj39snMzj/Ar
         IVJn+iKpvA4ignQuqFinaD5xqOIGKnz/mhPsJFbAsokfv7cAeoSeDxNAyD4yCbuL7Tdn
         EOeGsPsQ0YYvN+sqjGGd38mljHjLgtjPmUEpKDoEHefHDm6ONYkbW9CmP3oavY1MtQhW
         vcHs+JP3kRXJ/GKntDwRZbFHxF5C2/ObhsnNY5LJ2KraR3aVe3e1Ic8CzqIHWlNtCPct
         jMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L+LEPHcTOjgUQy0Kzsi4hjg11l09ygxX10YA9QE0E8E=;
        b=sKPohDZhqNzrw9T2PVCSwBmRwG0J0eqOymxPIvxJ+FlODbyJMvZ8gN0aLVYJjaF08E
         u7n4BBPIqHQSObsqNUYzppJ/hICzxSb4V0vYe5A/ylxyo1EdMkmYLHO1df9u47jmbKNv
         bqs/nuHiTCpkLkjO7/2VYhI0H4R2zIHPnGSzFeKKAcSvnXy9UGDnKlIwzOGlqVVJLziu
         lPwzvBaAYthobhVUtvCerXppv4ZnImQTrvIr5NR8Q5iHOZb2/cB3SC335gRC+3EsxGKF
         hGFZiVM7/ghxC2dxdhOMvjoYpwm4HbD/FLy0ZCuCH8M7TWdhLqxShJ0AP+GtJg/qP+0O
         NUOQ==
X-Gm-Message-State: APjAAAWfZwhaJqJ6q81y/fLi2jAMlkf4KpGaXDHLeYuj3WE369WmU2CB
        JNqmCmyNzP6GI8qNt3yRFt/dL+5x
X-Google-Smtp-Source: APXvYqxMFO7Icgt+LiWAR365CA2fG1bQmAOgTbRS+KeELvs46iaLjtrzMwqBNTpqC0TtcsFPy/xMFA==
X-Received: by 2002:a1c:45:: with SMTP id 66mr533789wma.40.1566313870644;
        Tue, 20 Aug 2019 08:11:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e15sm10855660wrj.74.2019.08.20.08.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:11:10 -0700 (PDT)
Date:   Tue, 20 Aug 2019 08:11:10 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Aug 2019 15:11:01 GMT
Message-Id: <5f332b799f90b64e2c0720fd0aba0e163d41587a.1566313865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/9] sparse-checkout: create 'disable' subcommand
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
 Documentation/git-sparse-checkout.txt | 26 +++++++---------
 builtin/sparse-checkout.c             | 45 ++++++++++++++++++++++++---
 t/t1091-sparse-checkout-builtin.sh    | 15 +++++++++
 3 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 6f540a3443..de04b768ae 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -38,6 +38,10 @@ COMMANDS
 	Add a set of patterns to the sparse-checkout file, as given over
 	stdin. Updates the working directory to match the new patterns.
 
+'disable'::
+	Remove the sparse-checkout file, set `core.sparseCheckout` to
+	`false`, and restore the working directory to include all files.
+
 SPARSE CHECKOUT
 ----------------
 
@@ -60,6 +64,13 @@ Then it compares the new skip-worktree value with the previous one. If
 skip-worktree turns from set to unset, it will add the corresponding
 file back. If it turns from unset to set, that file will be removed.
 
+To repopulate the working directory with all files, use the
+`git sparse-checkout disable` command.
+
+Sparse checkout support in 'git read-tree' and similar commands is
+disabled by default. You need to set `core.sparseCheckout` to `true`
+in order to have sparse checkout support.
+
 ## FULL PATTERN SET
 
 By default, the sparse-checkout file uses the same syntax as `.gitignore`
@@ -74,21 +85,6 @@ negate patterns. For example, to remove the file `unwanted`:
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
index ec6134fecc..8f97c27ec7 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout [init|add|list]"),
+	N_("git sparse-checkout [init|add|list|disable]"),
 	NULL
 };
 
@@ -79,11 +79,24 @@ static int sc_read_tree(void)
 	return result;
 }
 
-static int sc_enable_config(void)
+static int sc_set_config(int mode)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	int result = 0;
-	argv_array_pushl(&argv, "config", "--add", "core.sparseCheckout", "true", NULL);
+	argv_array_pushl(&argv, "config", "--add", "core.sparseCheckout", NULL);
+
+	switch (mode) {
+	case 1:
+		argv_array_pushl(&argv, "true", NULL);
+		break;
+
+	case 0:
+		argv_array_pushl(&argv, "false", NULL);
+		break;
+
+	default:
+		die(_("invalid config mode"));
+	}
 
 	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
 		error(_("failed to enable core.sparseCheckout"));
@@ -125,7 +138,7 @@ static int sparse_checkout_init(int argc, const char **argv)
 	FILE *fp;
 	int res;
 
-	if (sc_enable_config())
+	if (sc_set_config(1))
 		return 1;
 
 	memset(&el, 0, sizeof(el));
@@ -194,6 +207,28 @@ static int sparse_checkout_add(int argc, const char **argv)
 	return sc_read_tree();
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
+	if (sc_read_tree())
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
@@ -217,6 +252,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 			return sparse_checkout_init(argc, argv);
 		if (!strcmp(argv[0], "add"))
 			return sparse_checkout_add(argc, argv);
+		if (!strcmp(argv[0], "disable"))
+			return sparse_checkout_disable(argc, argv);
 	}
 
 	usage_with_options(builtin_sparse_checkout_usage,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 499bd8d6d0..68ca63a6f6 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -120,4 +120,19 @@ test_expect_success 'add to existing sparse-checkout' '
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
\ No newline at end of file
-- 
gitgitgadget

