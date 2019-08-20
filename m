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
	by dcvr.yhbt.net (Postfix) with ESMTP id 331741F461
	for <e@80x24.org>; Tue, 20 Aug 2019 15:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbfHTPLL (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 11:11:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50981 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbfHTPLK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 11:11:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so2956637wml.0
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qQk16PjvUmUETjIR7y11p7IneZnVTzfPZJoqZLD0gy8=;
        b=bdLfYF+o8sIq/g5qtalRFrWI1Y9BuzLeNQ9nFHGnYM81NBSJK7qsLIIvI4RiOWd5jo
         s7BGKvui9uXgfMDpUhafr7wpDkdmB9zijp2QTazKJJSoi8F3p9qNUrNHurBWhPUkPh8z
         PfM0X8zZzSPdzdni74pQ1bbhbxvirzcfZMkzM72EC+RJN8f06HVmEob5r2/Xs9eQXrxB
         /JBj5waV10RQKF71by5Rrn3bQjWrC0iZJ9/odxd8IYRIS2cE9XBsPd4jmNTsbEV3jA/6
         wSi5kTERgejgJSWBrS2C9TCZB1OwUX7M12oJ6bsTIcnHzSbB4/inZlcblpM+QizlHcwP
         0/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qQk16PjvUmUETjIR7y11p7IneZnVTzfPZJoqZLD0gy8=;
        b=Lb/PO57gT/Dus3T5cRNSITI7klWfgCSMFp129cg2u1MyRtoZ2Z99Xfe0v/ftaFyvii
         Im9DBN4SzWy629AVFBlBBvQX0ltME9euiyS8tCRTfvJtAE5S3+/knzN0joakt7Mj13HL
         ZxCY7w7XMlTZbQLEkBuw/eG0rLjjnKTRm4Uhl4t0OHt07KbOzYdZ4M3Z5oY3efesSQmR
         TXTqcOFCZEAzkeEQkx4dxlh4okuhm3noystk7rLIzujjp0DS8ik2LpVmN3J1Iq0dm/F6
         Ykm7aOG4VmcKAmFGeOCIqgmI7NfGQeI6msNpkw/hQ4cDO2abrPYhqD2Hu/WEYjdxyucw
         +xCA==
X-Gm-Message-State: APjAAAUCsRrRvmTXksRdaSoAKENluKbEwDLb+26jdxkXfq6JfJ6Df8ep
        Hmp3kiCTYgv6YgBzgK7svBwKbHEx
X-Google-Smtp-Source: APXvYqwTGf5VI0SeJLPXBqoHhyDFRd3phjseAQ5row9eyqW1l4hA4KWbu6vVhuckb2bjrZPbKBp1lg==
X-Received: by 2002:a1c:13:: with SMTP id 19mr511610wma.162.1566313867441;
        Tue, 20 Aug 2019 08:11:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm10267386wrq.49.2019.08.20.08.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:11:06 -0700 (PDT)
Date:   Tue, 20 Aug 2019 08:11:06 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Aug 2019 15:10:57 GMT
Message-Id: <c37b5f2c29d42e7c0c727596625d4eb50b6ddb4f.1566313865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/9] sparse-checkout: create builtin with 'list' subcommand
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

The sparse-checkout feature is mostly hidden to users, as its
only documentation is supplementary information in the docs for
'git read-tree'. In addition, users need to know how to edit the
.git/info/sparse-checkout file with the right patterns, then run
the appropriate 'git read-tree -mu HEAD' command. Keeping the
working directory in sync with the sparse-checkout file requires
care.

Begin an effort to make the sparse-checkout feature a porcelain
feature by creating a new 'git sparse-checkout' builtin. This
builtin will be the preferred mechanism for manipulating the
sparse-checkout file and syncing the working directory.

For now, create the basics of the builtin. Includes a single
subcommand, "git sparse-checkout list", that lists the patterns
currently in the sparse-checkout file. Test that these patterns
are parsed and written correctly to the output.

The documentation provided is adapted from the "git read-tree"
documentation with a few edits for clarity in the new context.
Extra sections are added to hint toward a future change to
a moer restricted pattern set.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .gitignore                            |  1 +
 Documentation/git-read-tree.txt       |  2 +-
 Documentation/git-sparse-checkout.txt | 90 +++++++++++++++++++++++++++
 Makefile                              |  1 +
 builtin.h                             |  1 +
 builtin/sparse-checkout.c             | 90 +++++++++++++++++++++++++++
 git.c                                 |  1 +
 t/t1091-sparse-checkout-builtin.sh    | 50 +++++++++++++++
 8 files changed, 235 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/git-sparse-checkout.txt
 create mode 100644 builtin/sparse-checkout.c
 create mode 100755 t/t1091-sparse-checkout-builtin.sh

diff --git a/.gitignore b/.gitignore
index 521d8f4fb4..9411522c4f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -158,6 +158,7 @@
 /git-show-branch
 /git-show-index
 /git-show-ref
+/git-sparse-checkout
 /git-stage
 /git-stash
 /git-status
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index d271842608..da33f84f33 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -436,7 +436,7 @@ support.
 SEE ALSO
 --------
 linkgit:git-write-tree[1]; linkgit:git-ls-files[1];
-linkgit:gitignore[5]
+linkgit:gitignore[5]; linkgit:git-sparse-checkout[1];
 
 GIT
 ---
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
new file mode 100644
index 0000000000..ca0ca6a12f
--- /dev/null
+++ b/Documentation/git-sparse-checkout.txt
@@ -0,0 +1,90 @@
+git-sparse-checkout(1)
+=======================
+
+NAME
+----
+git-sparse-checkout - Initialize and modify the sparse-checkout
+configuration, which reduces the checkout to a set of directories
+given by a list of prefixes.
+
+
+SYNOPSIS
+--------
+[verse]
+'git sparse-checkout <subcommand> [options]'
+
+
+DESCRIPTION
+-----------
+
+Initialize and modify the sparse-checkout configuration, which reduces
+the checkout to a set of directories given by a list of prefixes.
+
+
+COMMANDS
+--------
+'list'::
+	Provide a list of the contents in the sparse-checkout file.
+
+
+SPARSE CHECKOUT
+----------------
+
+"Sparse checkout" allows populating the working directory sparsely.
+It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
+Git whether a file in the working directory is worth looking at. If
+the skip-worktree bit is set, then the file is ignored in the working
+directory. Git will not populate the contents of those files, which
+makes a sparse checkout helpful when working in a repository with many
+files, but only a few are important to the current user.
+
+The `$GIT_DIR/info/sparse-checkout` file is used to define the
+skip-worktree reference bitmap. When Git updates the working
+directory, it resets the skip-worktree bit in the index based on this
+file. If an entry
+matches a pattern in this file, skip-worktree will not be set on
+that entry. Otherwise, skip-worktree will be set.
+
+Then it compares the new skip-worktree value with the previous one. If
+skip-worktree turns from set to unset, it will add the corresponding
+file back. If it turns from unset to set, that file will be removed.
+
+## FULL PATTERN SET
+
+By default, the sparse-checkout file uses the same syntax as `.gitignore`
+files.
+
+While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
+files are in, you can also specify what files are _not_ in, using
+negate patterns. For example, to remove the file `unwanted`:
+
+----------------
+/*
+!unwanted
+----------------
+
+Another tricky thing is fully repopulating the working directory when you
+no longer want sparse checkout. You cannot just disable "sparse
+checkout" because skip-worktree bits are still in the index and your working
+directory is still sparsely populated. You should re-populate the working
+directory with the `$GIT_DIR/info/sparse-checkout` file content as
+follows:
+
+----------------
+/*
+----------------
+
+Then you can disable sparse checkout. Sparse checkout support in 'git
+read-tree' and similar commands is disabled by default. You need to
+set `core.sparseCheckout` to `true` in order to have sparse checkout
+support.
+
+SEE ALSO
+--------
+
+linkgit:git-read-tree[1]
+linkgit:gitignore[5]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index f9255344ae..d1d067ab65 100644
--- a/Makefile
+++ b/Makefile
@@ -1126,6 +1126,7 @@ BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-index.o
 BUILTIN_OBJS += builtin/show-ref.o
+BUILTIN_OBJS += builtin/sparse-checkout.o
 BUILTIN_OBJS += builtin/stash.o
 BUILTIN_OBJS += builtin/stripspace.o
 BUILTIN_OBJS += builtin/submodule--helper.o
diff --git a/builtin.h b/builtin.h
index 5cf5df69f7..2b25a80cde 100644
--- a/builtin.h
+++ b/builtin.h
@@ -225,6 +225,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix);
 int cmd_show(int argc, const char **argv, const char *prefix);
 int cmd_show_branch(int argc, const char **argv, const char *prefix);
 int cmd_show_index(int argc, const char **argv, const char *prefix);
+int cmd_sparse_checkout(int argc, const char **argv, const char *prefix);
 int cmd_status(int argc, const char **argv, const char *prefix);
 int cmd_stash(int argc, const char **argv, const char *prefix);
 int cmd_stripspace(int argc, const char **argv, const char *prefix);
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
new file mode 100644
index 0000000000..6477a6ed9c
--- /dev/null
+++ b/builtin/sparse-checkout.c
@@ -0,0 +1,90 @@
+#include "builtin.h"
+#include "config.h"
+#include "dir.h"
+#include "parse-options.h"
+#include "pathspec.h"
+#include "repository.h"
+#include "run-command.h"
+#include "strbuf.h"
+
+static char const * const builtin_sparse_checkout_usage[] = {
+	N_("git sparse-checkout [list]"),
+	NULL
+};
+
+struct opts_sparse_checkout {
+	const char *subcommand;
+	int read_stdin;
+} opts;
+
+static char *get_sparse_checkout_filename(void)
+{
+	return git_pathdup("info/sparse-checkout");
+}
+
+static void write_excludes_to_file(FILE *fp, struct exclude_list *el)
+{
+	int i;
+
+	for (i = 0; i < el->nr; i++) {
+		struct exclude *x = el->excludes[i];
+
+		if (x->flags & EXC_FLAG_NEGATIVE)
+			fprintf(fp, "!");
+
+		fprintf(fp, "%s", x->pattern);
+
+		if (x->flags & EXC_FLAG_MUSTBEDIR)
+			fprintf(fp, "/");
+
+		fprintf(fp, "\n");
+	}
+}
+
+static int sparse_checkout_list(int argc, const char **argv)
+{
+	struct exclude_list el;
+	char *sparse_filename;
+	int res;
+
+	memset(&el, 0, sizeof(el));
+
+	sparse_filename = get_sparse_checkout_filename();
+	res = add_excludes_from_file_to_list(sparse_filename, "", 0, &el, NULL);
+	free(sparse_filename);
+
+	if (res < 0) {
+		warning(_("failed to parse sparse-checkout file; it may not exist"));
+		return 0;
+	}
+
+	write_excludes_to_file(stdout, &el);
+	clear_exclude_list(&el);
+
+	return 0;
+}
+
+int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
+{
+	static struct option builtin_sparse_checkout_options[] = {
+		OPT_END(),
+	};
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_sparse_checkout_usage,
+				   builtin_sparse_checkout_options);
+
+	git_config(git_default_config, NULL);
+	argc = parse_options(argc, argv, prefix,
+			     builtin_sparse_checkout_options,
+			     builtin_sparse_checkout_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc > 0) {
+		if (!strcmp(argv[0], "list"))
+			return sparse_checkout_list(argc, argv);
+	}
+
+	usage_with_options(builtin_sparse_checkout_usage,
+			   builtin_sparse_checkout_options);
+}
diff --git a/git.c b/git.c
index c1ee7124ed..dfb680e15d 100644
--- a/git.c
+++ b/git.c
@@ -573,6 +573,7 @@ static struct cmd_struct commands[] = {
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
 	{ "show-index", cmd_show_index },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
+	{ "sparse-checkout", cmd_sparse_checkout, RUN_SETUP | NEED_WORK_TREE },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 	/*
 	 * NEEDSWORK: Until the builtin stash is thoroughly robust and no
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
new file mode 100755
index 0000000000..ba6928c641
--- /dev/null
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='sparse checkout builtin tests'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git init repo &&
+	(
+		cd repo &&
+		echo "initial" >a &&
+		mkdir folder1 folder2 deep &&
+		mkdir deep/deeper1 deep/deeper2 &&
+		mkdir deep/deeper1/deepest &&
+		cp a folder1 &&
+		cp a folder2 &&
+		cp a deep &&
+		cp a deep/deeper1 &&
+		cp a deep/deeper2 &&
+		cp a deep/deeper1/deepest &&
+		git add . &&
+		git commit -m "initial commit"
+	)
+'
+
+test_expect_success 'git sparse-checkout list (empty)' '
+	git -C repo sparse-checkout list >list 2>err &&
+	test_line_count = 0 list &&
+	test_i18ngrep "failed to parse sparse-checkout file; it may not exist" err
+'
+
+test_expect_success 'git sparse-checkout list (populated)' '
+	test_when_finished rm -f repo/.git/info/sparse-checkout &&
+	cat >repo/.git/info/sparse-checkout <<-EOF &&
+		/folder1/*
+		/deep/
+		**/a
+		!*bin*
+	EOF
+	git -C repo sparse-checkout list >list &&
+	cat >expect <<-EOF &&
+		/folder1/*
+		/deep/
+		**/a
+		!*bin*
+	EOF
+	test_cmp expect list
+'
+
+test_done
\ No newline at end of file
-- 
gitgitgadget

