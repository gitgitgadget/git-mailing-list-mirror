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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ED0D1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 16:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfKLQ62 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 11:58:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34371 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKLQ62 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 11:58:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id j18so2798345wmk.1
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 08:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=26BF5aoR4aQ2VhDhQvpEZbvzy3xeNIdu0CYCqwmQ6nM=;
        b=J64NP/mpNTwVEPXgDQ3plQm1brs2kzlV/XSRPKd1JAh7B9KnuquC6rH71CYRgpGwbQ
         /OxcqNaD+yVycmJsDWI6y9vzzAdCaymC0pxFSHePeUyVVLeAW2JO1YCiDbL8sydW+4YH
         JI1U2JsaKCfQgFxK8v4icjYqijSMIkWHGq68kmQ/5ycdD009jm/dTr6R4CvtWHUirtV1
         6f6BZtgOubSzcfbEG31SK1r5EEBqLNAUwJwfc1ipcm51E/YuzIQMMmlFVP7Qg4xY3rmD
         RzBczWNNXNFGuoytBaaAFt2za12Iv0k57rwiZNkLQU9eYBo78S1I0I0vQBRF/zT4abhh
         vOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=26BF5aoR4aQ2VhDhQvpEZbvzy3xeNIdu0CYCqwmQ6nM=;
        b=uTNdy+CVvHlopCqVexBdNqUqoDf0bVMTE4fW5Fy7TvCwPNuhVpKsjjzQRRj79F04tq
         7I2j39Fdz3goHk1lmo8U3KtVdGyur3P9sDmvKrGPGX/CsL8OofNqeycY6UnkUeWjg1KY
         pg0dn8YKbwEGJ/cdvh2Fn/uvUX8DgjR/PI8C5NPWmS38CgJ+0X66jjMJQY20BwjFmhzZ
         eYgk30hx7hMBZAhzannXOSRGxekcZAR+qcTA3FH+E2VVRO+Nc/9tH55nOayCcovHIeV6
         LPdc937zhEJOh8ZAeYpS2JGmGb0eWzlh/z+d8jl21GFPAM/v/VqXvZCnf9yjhHTUtLIz
         RhMA==
X-Gm-Message-State: APjAAAVu+IWf42mLnnHSzxyP1RqBvgvIO1CETcLWWXy97H1LPOwNRCFI
        OOLDSGj5+Cv4Yr2CeRSHT/Ef/NAx
X-Google-Smtp-Source: APXvYqxhiHTqfBE1oTawZVbH5VCfITz8UH8e8fD3rg+7vtDcyJXuVm0ydP1/a/ShW2hOz+6lG9v16w==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr4525683wmf.24.1573577902718;
        Tue, 12 Nov 2019 08:58:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q17sm3371340wmj.12.2019.11.12.08.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 08:58:22 -0800 (PST)
Message-Id: <bdbc7b71884cba192c67c2bc26db5b9b3a040043.1573577900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.460.git.1573577900.gitgitgadget@gmail.com>
References: <pull.460.git.1573577900.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Nov 2019 16:58:20 +0000
Subject: [PATCH 1/1] test-tool: use 'read-graph' helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git commit-graph read' subcommand is used in test scripts to check
that the commit-graph contents match the expected data. Mostly, this
helps check the header information and the list of chunks. Users do not
need this information, so move the functionality to a test helper.

Reported-by: Bryan Turner <bturner@atlassian.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt | 12 ------
 Makefile                           |  1 +
 builtin/commit-graph.c             | 68 ------------------------------
 t/helper/test-read-graph.c         | 53 +++++++++++++++++++++++
 t/helper/test-tool.c               |  1 +
 t/helper/test-tool.h               |  1 +
 t/t5318-commit-graph.sh            |  2 +-
 t/t5324-split-commit-graph.sh      |  2 +-
 8 files changed, 58 insertions(+), 82 deletions(-)
 create mode 100644 t/helper/test-read-graph.c

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 8c708a7a16..bcd85c1976 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -9,7 +9,6 @@ git-commit-graph - Write and verify Git commit-graph files
 SYNOPSIS
 --------
 [verse]
-'git commit-graph read' [--object-dir <dir>]
 'git commit-graph verify' [--object-dir <dir>] [--shallow] [--[no-]progress]
 'git commit-graph write' <options> [--object-dir <dir>] [--[no-]progress]
 
@@ -74,11 +73,6 @@ Finally, if `--expire-time=<datetime>` is not specified, let `datetime`
 be the current time. After writing the split commit-graph, delete all
 unused commit-graph whose modified times are older than `datetime`.
 
-'read'::
-
-Read the commit-graph file and output basic details about it.
-Used for debugging purposes.
-
 'verify'::
 
 Read the commit-graph file and verify its contents against the object
@@ -118,12 +112,6 @@ $ git show-ref -s | git commit-graph write --stdin-commits
 $ git rev-parse HEAD | git commit-graph write --stdin-commits --append
 ------------------------------------------------
 
-* Read basic information from the commit-graph file.
-+
-------------------------------------------------
-$ git commit-graph read
-------------------------------------------------
-
 
 GIT
 ---
diff --git a/Makefile b/Makefile
index 58b92af54b..44997f6f57 100644
--- a/Makefile
+++ b/Makefile
@@ -727,6 +727,7 @@ TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-progress.o
 TEST_BUILTINS_OBJS += test-reach.o
 TEST_BUILTINS_OBJS += test-read-cache.o
+TEST_BUILTINS_OBJS += test-read-graph.o
 TEST_BUILTINS_OBJS += test-read-midx.o
 TEST_BUILTINS_OBJS += test-ref-store.o
 TEST_BUILTINS_OBJS += test-regex.o
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index ec0fc93d39..e0c6fc4bbf 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -8,7 +8,6 @@
 #include "object-store.h"
 
 static char const * const builtin_commit_graph_usage[] = {
-	N_("git commit-graph read [--object-dir <objdir>]"),
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
 	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
 	NULL
@@ -19,11 +18,6 @@ static const char * const builtin_commit_graph_verify_usage[] = {
 	NULL
 };
 
-static const char * const builtin_commit_graph_read_usage[] = {
-	N_("git commit-graph read [--object-dir <objdir>]"),
-	NULL
-};
-
 static const char * const builtin_commit_graph_write_usage[] = {
 	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
 	NULL
@@ -93,66 +87,6 @@ static int graph_verify(int argc, const char **argv)
 	return verify_commit_graph(the_repository, graph, flags);
 }
 
-static int graph_read(int argc, const char **argv)
-{
-	struct commit_graph *graph = NULL;
-	char *graph_name;
-	int open_ok;
-	int fd;
-	struct stat st;
-
-	static struct option builtin_commit_graph_read_options[] = {
-		OPT_STRING(0, "object-dir", &opts.obj_dir,
-			N_("dir"),
-			N_("The object directory to store the graph")),
-		OPT_END(),
-	};
-
-	trace2_cmd_mode("read");
-
-	argc = parse_options(argc, argv, NULL,
-			     builtin_commit_graph_read_options,
-			     builtin_commit_graph_read_usage, 0);
-
-	if (!opts.obj_dir)
-		opts.obj_dir = get_object_directory();
-
-	graph_name = get_commit_graph_filename(opts.obj_dir);
-
-	open_ok = open_commit_graph(graph_name, &fd, &st);
-	if (!open_ok)
-		die_errno(_("Could not open commit-graph '%s'"), graph_name);
-
-	graph = load_commit_graph_one_fd_st(fd, &st);
-	if (!graph)
-		return 1;
-
-	FREE_AND_NULL(graph_name);
-
-	printf("header: %08x %d %d %d %d\n",
-		ntohl(*(uint32_t*)graph->data),
-		*(unsigned char*)(graph->data + 4),
-		*(unsigned char*)(graph->data + 5),
-		*(unsigned char*)(graph->data + 6),
-		*(unsigned char*)(graph->data + 7));
-	printf("num_commits: %u\n", graph->num_commits);
-	printf("chunks:");
-
-	if (graph->chunk_oid_fanout)
-		printf(" oid_fanout");
-	if (graph->chunk_oid_lookup)
-		printf(" oid_lookup");
-	if (graph->chunk_commit_data)
-		printf(" commit_metadata");
-	if (graph->chunk_extra_edges)
-		printf(" extra_edges");
-	printf("\n");
-
-	UNLEAK(graph);
-
-	return 0;
-}
-
 extern int read_replace_refs;
 static struct split_commit_graph_opts split_opts;
 
@@ -268,8 +202,6 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = 0;
 
 	if (argc > 0) {
-		if (!strcmp(argv[0], "read"))
-			return graph_read(argc, argv);
 		if (!strcmp(argv[0], "verify"))
 			return graph_verify(argc, argv);
 		if (!strcmp(argv[0], "write"))
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
new file mode 100644
index 0000000000..d2884efe0a
--- /dev/null
+++ b/t/helper/test-read-graph.c
@@ -0,0 +1,53 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "commit-graph.h"
+#include "repository.h"
+#include "object-store.h"
+
+int cmd__read_graph(int argc, const char **argv)
+{
+	struct commit_graph *graph = NULL;
+	char *graph_name;
+	int open_ok;
+	int fd;
+	struct stat st;
+	const char *object_dir;
+
+	setup_git_directory();
+	object_dir = get_object_directory();
+
+	graph_name = get_commit_graph_filename(object_dir);
+
+	open_ok = open_commit_graph(graph_name, &fd, &st);
+	if (!open_ok)
+		die_errno(_("Could not open commit-graph '%s'"), graph_name);
+
+	graph = load_commit_graph_one_fd_st(fd, &st);
+	if (!graph)
+		return 1;
+
+	FREE_AND_NULL(graph_name);
+
+	printf("header: %08x %d %d %d %d\n",
+		ntohl(*(uint32_t*)graph->data),
+		*(unsigned char*)(graph->data + 4),
+		*(unsigned char*)(graph->data + 5),
+		*(unsigned char*)(graph->data + 6),
+		*(unsigned char*)(graph->data + 7));
+	printf("num_commits: %u\n", graph->num_commits);
+	printf("chunks:");
+
+	if (graph->chunk_oid_fanout)
+		printf(" oid_fanout");
+	if (graph->chunk_oid_lookup)
+		printf(" oid_lookup");
+	if (graph->chunk_commit_data)
+		printf(" commit_metadata");
+	if (graph->chunk_extra_edges)
+		printf(" extra_edges");
+	printf("\n");
+
+	UNLEAK(graph);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 19ee26d931..f20989d449 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -45,6 +45,7 @@ static struct test_cmd cmds[] = {
 	{ "progress", cmd__progress },
 	{ "reach", cmd__reach },
 	{ "read-cache", cmd__read_cache },
+	{ "read-graph", cmd__read_graph },
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
 	{ "regex", cmd__regex },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index c2aa56ef50..8ed2af71d1 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -35,6 +35,7 @@ int cmd__prio_queue(int argc, const char **argv);
 int cmd__progress(int argc, const char **argv);
 int cmd__reach(int argc, const char **argv);
 int cmd__read_cache(int argc, const char **argv);
+int cmd__read_graph(int argc, const char **argv);
 int cmd__read_midx(int argc, const char **argv);
 int cmd__ref_store(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d42b3efe39..798968374f 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -85,7 +85,7 @@ graph_read_expect() {
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
 	EOF
-	git commit-graph read >output &&
+	test-tool read-graph >output &&
 	test_cmp expect output
 }
 
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 115aabd141..c24823431f 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -25,7 +25,7 @@ graph_read_expect() {
 	num_commits: $1
 	chunks: oid_fanout oid_lookup commit_metadata
 	EOF
-	git commit-graph read >output &&
+	test-tool read-graph >output &&
 	test_cmp expect output
 }
 
-- 
gitgitgadget
