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
	by dcvr.yhbt.net (Postfix) with ESMTP id E1F121F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfJGUIf (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:08:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40313 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbfJGUIf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:08:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so8044275wrv.7
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SZcEvuR6QVLwmN9HXy6iQrqATf60zpUxSM3CvIyi71c=;
        b=IWv4iAdeChzTU9h+vw4OKNVDmAW5GxRg7JazI6Ak3NDyNNwmzDMB8GOfAHfBuK/lcr
         GfFNEo32SIKAQaSuTBG6c1vvJEtLvx82jhTWIihDrrGv+1WinQ/Q4vZ18tKkFLkeMDzk
         6xdqPFSaPO1PNukdazoeEBXoxFIOJxii8uf3jS6nJeh78/i2I2FFJdlble8WT0XDJ499
         kqsgfkFLCETPqhG2/KAlC7j/4kdo8IWn6qdHoE4cnxjUjSu5HmJtoJdv32kUjwIUP+lv
         Q+KOKQLr7qKEyhv6PtHerD6yOnoZ8a7L7SQBGU055C3/mjwUSNTbZYvxnX3IVpDq0X0x
         Jv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SZcEvuR6QVLwmN9HXy6iQrqATf60zpUxSM3CvIyi71c=;
        b=TJUpe0LwQq1wU8Dy1w0HBYfT8UYNo42zofTSmZbErfrD9DCFnXHzB90sx1gum4Ctsv
         l/4fFx4Qw9SxZHCGjUuInUALFKIegmYNZsW5zn2Pw3Jvtt+sg7k9mB8C+0knmHteoTz1
         /6/XSPFx8LgSPkQLYt4d/WqDub6haqCPid5RvQ8hwLyOuqZpp9Ix1J1DtldTkvt8AH9i
         ViTCPQ8YRAJOmbDSSBRRvCFyZ0mI16e/uW0/UQw8Zmy/hfSAJkraI0zcDkRpTmRxgoGm
         D0ua9PS18Q+JC/TMu6zVdRPHPW582U/3YBkYcMPVG34tcmzg9RVa73Ik4BZVyBkCznV6
         mcKw==
X-Gm-Message-State: APjAAAWt+Qro5GVEz4RVyXvUOZMfmhu2pusKUfeIr/beBIm+peFPH4jn
        PzBfZbJKWaAHxn837B0HBSR45PtH
X-Google-Smtp-Source: APXvYqzdWsW3uNB5PQYNOnW6169vloM72l5aPaicSqVnPMVwHBsDjeRpBWSkhw6uGVilT1uGE/GgsA==
X-Received: by 2002:a5d:4dd1:: with SMTP id f17mr8500539wru.375.1570478913310;
        Mon, 07 Oct 2019 13:08:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18sm357171wmh.43.2019.10.07.13.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:08:32 -0700 (PDT)
Date:   Mon, 07 Oct 2019 13:08:32 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 20:08:14 GMT
Message-Id: <22b9bd21f44cc219b7b8bc0665a5e3a17a5542c3.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
        <pull.316.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 06/17] sparse-checkout: create 'disable' subcommand
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
index f4bd951550..b12bf385ae 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -44,6 +44,10 @@ worktrees.
 	a list of arguments following the 'set' subcommand. Update the
 	working directory to match the new patterns.
 
+'disable'::
+	Remove the sparse-checkout file, set `core.sparseCheckout` to
+	`false`, and restore the working directory to include all files.
+
 SPARSE CHECKOUT
 ----------------
 
@@ -61,6 +65,14 @@ directory, it updates the skip-worktree bits in the index based
 ont this file. The files matching the patterns in the file will
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
@@ -75,21 +87,6 @@ using negative patterns. For example, to remove the file `unwanted`:
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
index 68f3d8433e..ab02acc125 100644
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
+	if (sc_set_config(MODE_FULL))
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
+	return sc_set_config(MODE_NONE);
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

