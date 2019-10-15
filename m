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
	by dcvr.yhbt.net (Postfix) with ESMTP id CF6461F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 13:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbfJON4M (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 09:56:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54053 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732266AbfJON4L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so20990253wmd.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+eU+ByW1+OD6D1CST/co3Dhp1wIg3rtHR4rzKEbNjBI=;
        b=JPspXROBGvbJwF/oRN5mDZZkVrvzal6chqVtg7G2BsDy1hW+48dns81ZnocZoh8dxy
         hDD5hyQb9Llx1u76cW/dVGELR268U6M7+8GMsWY+kkew+CnvS3s3S2GILndE1VJ9ALay
         BGHL8Y/w8XpzVyhVcl508xIqMILt2BB82JY4Qo+rvlvkLgwvketkTS37Ix7PYlSvocN1
         /RA4UT9T4H1JIYNMYOgagrknMu9WQOYWcWFNDjfIEOssDCc9dS1fDnRIjnnt/C8SBxZv
         nMKCxf+aKJYp7986T43ecA+HITieuPlgRIZcb7BhINWIbmiFuWFql5E4SLcMhqk7D74C
         nHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+eU+ByW1+OD6D1CST/co3Dhp1wIg3rtHR4rzKEbNjBI=;
        b=WkApc//NeeRVCMq1CBEtAK50JoJ0Py7g6HQ28I1qeCU9ZaDvhYrdJKg3I5biw9rn9o
         K9bkcrIenkfdUcqwsEbr0h0aSLK0Tel2LkUoXCP0Y2XCJS6QmdiTRH8M49Gh9WxmU5/8
         ORkNQsMlyGd3t9MFPO+KpADAE2JRvyuMUFP/HQbvFIDO3V8VTLT7f/GZD0w0CM0H3q5h
         yHR+AhjPfgDZofiKUmpbiW2A1iUb1lppKHIP1TX/CxAIiUFCO1uG5mLdYynWC8qMwUv8
         Y9gllYCqsLqmVBt4BRbyF7To4tWSK4mYppE+5ogkHGTzdITAU9AOKZpA7kXQZxV23CNK
         q2pw==
X-Gm-Message-State: APjAAAUZCepFHumB8s9NFJ8zM+H9RlK3fSDh05/X4Y1Ly0NTgFAlGgS2
        GZve85TUwuIx9p4kjeW+1ObGqZiH
X-Google-Smtp-Source: APXvYqzsrUKw2ntWr3FJaIynkRXIaqFPZtYFPqqIRb5cf8FK/2TP+SG2qmUMtlbpXY3IVO89qrbuug==
X-Received: by 2002:a1c:6a0b:: with SMTP id f11mr20853040wmc.78.1571147767834;
        Tue, 15 Oct 2019 06:56:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q10sm39873198wrd.39.2019.10.15.06.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:56:07 -0700 (PDT)
Message-Id: <63626e109767c268ee81b50abd21b95b1f1b5bfb.1571147765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
        <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 13:55:48 +0000
Subject: [PATCH v4 01/17] sparse-checkout: create builtin with 'list'
 subcommand
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

The documentation provided is adapted from the "git read-tree"
documentation with a few edits for clarity in the new context.
Extra sections are added to hint toward a future change to
a more restricted pattern set.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .gitignore                            |  1 +
 Documentation/git-read-tree.txt       |  2 +-
 Documentation/git-sparse-checkout.txt | 87 +++++++++++++++++++++++++++
 Makefile                              |  1 +
 builtin.h                             |  1 +
 builtin/sparse-checkout.c             | 86 ++++++++++++++++++++++++++
 git.c                                 |  1 +
 t/t1091-sparse-checkout-builtin.sh    | 50 +++++++++++++++
 8 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/git-sparse-checkout.txt
 create mode 100644 builtin/sparse-checkout.c
 create mode 100755 t/t1091-sparse-checkout-builtin.sh

diff --git a/.gitignore b/.gitignore
index 89b3b79c1a..aebe7c0908 100644
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
index 0000000000..46d3dc3cb1
--- /dev/null
+++ b/Documentation/git-sparse-checkout.txt
@@ -0,0 +1,87 @@
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
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
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
+directory, it updates the skip-worktree bits in the index based
+on this file. The files matching the patterns in the file will
+appear in the working directory, and the rest will not.
+
+## FULL PATTERN SET
+
+By default, the sparse-checkout file uses the same syntax as `.gitignore`
+files.
+
+While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
+files are included, you can also specify what files are _not_ included,
+using negative patterns. For example, to remove the file `unwanted`:
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
+checkout' and similar commands is disabled by default. You need to
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
index de60c8e7aa..adefc229fe 100644
--- a/Makefile
+++ b/Makefile
@@ -1125,6 +1125,7 @@ BUILTIN_OBJS += builtin/shortlog.o
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
index 0000000000..eed9625a05
--- /dev/null
+++ b/builtin/sparse-checkout.c
@@ -0,0 +1,86 @@
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
+static char *get_sparse_checkout_filename(void)
+{
+	return git_pathdup("info/sparse-checkout");
+}
+
+static void write_patterns_to_file(FILE *fp, struct pattern_list *pl)
+{
+	int i;
+
+	for (i = 0; i < pl->nr; i++) {
+		struct path_pattern *p = pl->patterns[i];
+
+		if (p->flags & PATTERN_FLAG_NEGATIVE)
+			fprintf(fp, "!");
+
+		fprintf(fp, "%s", p->pattern);
+
+		if (p->flags & PATTERN_FLAG_MUSTBEDIR)
+			fprintf(fp, "/");
+
+		fprintf(fp, "\n");
+	}
+}
+
+static int sparse_checkout_list(int argc, const char **argv)
+{
+	struct pattern_list pl;
+	char *sparse_filename;
+	int res;
+
+	memset(&pl, 0, sizeof(pl));
+
+	sparse_filename = get_sparse_checkout_filename();
+	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL);
+	free(sparse_filename);
+
+	if (res < 0) {
+		warning(_("this worktree is not sparse (sparse-checkout file may not exist)"));
+		return 0;
+	}
+
+	write_patterns_to_file(stdout, &pl);
+	clear_pattern_list(&pl);
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
+	argc = parse_options(argc, argv, prefix,
+			     builtin_sparse_checkout_options,
+			     builtin_sparse_checkout_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	git_config(git_default_config, NULL);
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
index ce6ab0ece2..7be7ad34bd 100644
--- a/git.c
+++ b/git.c
@@ -572,6 +572,7 @@ static struct cmd_struct commands[] = {
 	{ "show-branch", cmd_show_branch, RUN_SETUP },
 	{ "show-index", cmd_show_index },
 	{ "show-ref", cmd_show_ref, RUN_SETUP },
+	{ "sparse-checkout", cmd_sparse_checkout, RUN_SETUP | NEED_WORK_TREE },
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 	/*
 	 * NEEDSWORK: Until the builtin stash is thoroughly robust and no
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
new file mode 100755
index 0000000000..a9b04b1a88
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
+	test_i18ngrep "this worktree is not sparse (sparse-checkout file may not exist)" err
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
-- 
gitgitgadget

