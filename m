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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E91F1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 15:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfHTPLM (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 11:11:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34303 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730340AbfHTPLK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 11:11:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id e8so2633089wme.1
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 08:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ah3Eziv2px6nhUGGvMqqO3ct7iFEzVXhY2ZiwueehxU=;
        b=ga6+hQowPJQzzN+3OeUDS3iYlBlkDEGxJsNt1jCy+IUGjq3qggb2oyFFvmTk5tuckP
         UVbkQHJUhp0HX5j65PRM+qwQ4LXzLNQYe+ayQQBHfm6hDwDOYQlL25SOeqVRRIDNV6sj
         7zNQ/WH3cApaCxF8L71GXygj69RzxZWBbt9ApMSyozVvwXaMtS0DJm/4cGou+mCKcStr
         1GFgnrb31dWQ/9uAqi1R8TcyaL1N+vkIyD4Q1ekg5RyD7dPTXMhRqOWtIkRIfIBd5Shp
         ZFX2J4LcsQoupknFZsrCqliQHBEbLFOTkD5oJrYFaWLi5qSW61Q6H9hsvPFdu9gCxLVO
         jlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ah3Eziv2px6nhUGGvMqqO3ct7iFEzVXhY2ZiwueehxU=;
        b=Vo9LDNED6JQLQIK+tr8ChoBiegNVSprIZtm7kMBtFtGAsP6glXwv00Xhzz0fHjRO8Q
         /kDi6e/1tVqoIgOWCtJwpLd8Y0vRQQuRTajMPAWcGocqt6MeSI6tEnz0oUqjdFBDWilF
         sQhFbLnQdbf1idCwnYlQAwCzvhKmo9e/3OgnTTAtnAkquylO9Lw7ilSo2aGEiWzQFM0H
         ojc+gEdvQvY7HMcATuSZqQXKsIMV0I5IKR/9dNKTY7oNPN0dvUIzdi7xHxF62oj5+bs3
         c0sIp9YYEUZZGvucwt8kDLkSNa6Gcsb4AVpc1NBT39TSfctiZ3Tp5gWAODqBNNAahfIv
         +Q4g==
X-Gm-Message-State: APjAAAUB0/Ko7n/4+KOvXmrDjYQ2mznYbknJQeByXCtsjLHqMCzNYgk6
        gsFP/q4DPWtxdZNtiKk2t6HZsPJ3
X-Google-Smtp-Source: APXvYqyDca4I+60kJJ/6ZmX1IKocHfZgsAG8DAz6qqeEDiwC5uiXpkdt2Oo22nfEupTPUQicq+BQbQ==
X-Received: by 2002:a1c:7a14:: with SMTP id v20mr517173wmc.75.1566313868344;
        Tue, 20 Aug 2019 08:11:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm10267426wrq.49.2019.08.20.08.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:11:07 -0700 (PDT)
Date:   Tue, 20 Aug 2019 08:11:07 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Aug 2019 15:10:58 GMT
Message-Id: <e6e982e5a6e4517d97a7a404384057110f3a151d.1566313865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/9] sparse-checkout: create 'init' subcommand
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

Getting started with a sparse-checkout file can be daunting. Help
users start their sparse enlistment using 'git sparse-checkout init'.
This will set 'core.sparseCheckout=true' in their config, write
an initial set of patterns to the sparse-checkout file, and update
their working directory.

Using 'git read-tree' to clear directories does not work cleanly
on Windows, so manually delete directories that are tracked by Git
before running read-tree.

The use of running another process for 'git read-tree' is likely
suboptimal, but that can be improved in a later change, if valuable.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt |   7 ++
 builtin/sparse-checkout.c             | 106 +++++++++++++++++++++++++-
 t/t1091-sparse-checkout-builtin.sh    |  40 ++++++++++
 3 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index ca0ca6a12f..50c53ee60a 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -26,6 +26,13 @@ COMMANDS
 'list'::
 	Provide a list of the contents in the sparse-checkout file.
 
+'init'::
+	Enable the `core.sparseCheckout` setting. If the
+	sparse-checkout file does not exist, then populate it with
+	patterns that match every file in the root directory and
+	no other directories, then will remove all directories tracked
+	by Git. Add patterns to the sparse-checkout file to
+	repopulate the working directory.
 
 SPARSE CHECKOUT
 ----------------
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 6477a6ed9c..86d24e6295 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout [list]"),
+	N_("git sparse-checkout [init|list]"),
 	NULL
 };
 
@@ -64,6 +64,108 @@ static int sparse_checkout_list(int argc, const char **argv)
 	return 0;
 }
 
+static int sc_read_tree(void)
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
+static int sc_enable_config(void)
+{
+	struct argv_array argv = ARGV_ARRAY_INIT;
+	int result = 0;
+	argv_array_pushl(&argv, "config", "--add", "core.sparseCheckout", "true", NULL);
+
+	if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+		error(_("failed to enable core.sparseCheckout"));
+		result = 1;
+	}
+
+	argv_array_clear(&argv);
+	return result;
+}
+
+static int delete_directory(const struct object_id *oid, struct strbuf *base,
+		const char *pathname, unsigned mode, int stage, void *context)
+{
+	struct strbuf dirname = STRBUF_INIT;
+	struct stat sb;
+
+	strbuf_addstr(&dirname, the_repository->worktree);
+	strbuf_addch(&dirname, '/');
+	strbuf_addstr(&dirname, pathname);
+
+	if (stat(dirname.buf, &sb) || !(sb.st_mode & S_IFDIR))
+		return 0;
+
+	if (remove_dir_recursively(&dirname, 0))
+		warning(_("failed to remove directory '%s'"),
+			dirname.buf);
+
+	strbuf_release(&dirname);
+	return 0;
+}
+
+static int sparse_checkout_init(int argc, const char **argv)
+{
+	struct tree *t;
+	struct object_id oid;
+	struct exclude_list el;
+	static struct pathspec pathspec;
+	char *sparse_filename;
+	FILE *fp;
+	int res;
+
+	if (sc_enable_config())
+		return 1;
+
+	memset(&el, 0, sizeof(el));
+
+	sparse_filename = get_sparse_checkout_filename();
+	res = add_excludes_from_file_to_list(sparse_filename, "", 0, &el, NULL);
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
+	fprintf(fp, "/*\n!/*/*\n");
+	fclose(fp);
+
+	/* remove all directories in the root, if tracked by Git */
+	if (get_oid("HEAD", &oid)) {
+		/* assume we are in a fresh repo */
+		return 0;
+	}
+
+	t = parse_tree_indirect(&oid);
+
+	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
+				  ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
+		       PATHSPEC_PREFER_CWD,
+		       "", NULL);
+
+	if (read_tree_recursive(the_repository, t, "", 0, 0, &pathspec,
+				delete_directory, NULL))
+		return 1;
+
+reset_dir:
+	return sc_read_tree();
+}
+
 int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_options[] = {
@@ -83,6 +185,8 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 	if (argc > 0) {
 		if (!strcmp(argv[0], "list"))
 			return sparse_checkout_list(argc, argv);
+		if (!strcmp(argv[0], "init"))
+			return sparse_checkout_init(argc, argv);
 	}
 
 	usage_with_options(builtin_sparse_checkout_usage,
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index ba6928c641..35ab84aabd 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -47,4 +47,44 @@ test_expect_success 'git sparse-checkout list (populated)' '
 	test_cmp expect list
 '
 
+test_expect_success 'git sparse-checkout init' '
+	git -C repo sparse-checkout init &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/*
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
+		!/*/*
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'init with existing sparse-checkout' '
+	echo "/folder1/*" >> repo/.git/info/sparse-checkout &&
+	git -C repo sparse-checkout init &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/*
+		/folder1/*
+	EOF
+	test_cmp expect repo/.git/info/sparse-checkout &&
+	ls repo >dir  &&
+	cat >expect <<-EOF &&
+		a
+		folder1
+	EOF
+	test_cmp expect dir
+'
+
 test_done
\ No newline at end of file
-- 
gitgitgadget

