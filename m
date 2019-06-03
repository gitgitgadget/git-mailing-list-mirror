Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD721F462
	for <e@80x24.org>; Mon,  3 Jun 2019 16:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfFCQEH (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 12:04:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36733 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbfFCQEG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 12:04:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so9629338wrs.3
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q9JPBJaCw5IB2N7WIscp6jNUscPeTa0U/cBVU7xG668=;
        b=X8m2HZYiMudwfQ74U5QKfjfPmmDlUpOGoz0a5m0fjbOrpo6IeG+wnT6Ju+0IUr0Nbu
         QWj+GB0sj09AEdK2WFRAShIKQ+ODxH8WVrdMBG5QLSBp7Zn/oIW4d/cd29gLOkvPzTvD
         ki0jV+EYHOUEVQFLHfwf6f2R4NuGZsnqFtmL2PKIIg7ToHI67tEXnFwtHze+6tt5JNA+
         sN9DrVQdQW8Zlup+/Jz/xS5IBPbHLfyq5IJUbDiQyQeMt62gkUn3/0PY32O3Pxcnzo9P
         l1vwWeIf2NueEtbSqTUC7SAFeE8owaYd+6Y+40hWG908i/7LgIR0QY4ASQZLOX6TfFlJ
         D5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q9JPBJaCw5IB2N7WIscp6jNUscPeTa0U/cBVU7xG668=;
        b=JNte0pnPhAvTpW4AKXoUd/kNK2Al9qDCBse27xpSjBUlJwyoNqtl6W4hMqbrWpaFqy
         cTlKpdY3TE0mUpjA/ZN5CvAROt2GmSmq3X7oLJtHX27olIT9l8hL3riwY9dEoL91yEcJ
         yKXs4gr5X6Io2owEmPKaceIF3WgKMzo3fFdnFmJK1KsBohwFiKEE0rS0y4vrWV+8QQmP
         /4rr/P/huJR1NbEeE+sQPj12qAzB8H3w4GMWAmGIYK+2LrTnvTzv8HjJfO9ZFqI0DOVl
         5+BCMtTuJGp2a8MnrcquoYCjFt4dGRjrMJia0XEOtRwdEDD0RlmSHDzaQilFZ1dJlYJt
         /X9g==
X-Gm-Message-State: APjAAAXyf61lSadw84JNAxs/QQEY8hTslYANfMQYgwp71xN3rTwo+8sA
        fPT7T0d47fmFl0qdcYLgcMpMJEH0
X-Google-Smtp-Source: APXvYqyZXzS7yJor0MZSn4mQPkaekMqOYSyQQ8wuowhBFMDAjfzgLULwtoYPMMaMoo5Hf93uLIDXKA==
X-Received: by 2002:adf:de06:: with SMTP id b6mr1603403wrm.0.1559577841383;
        Mon, 03 Jun 2019 09:04:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t63sm2298994wmt.6.2019.06.03.09.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:04:00 -0700 (PDT)
Date:   Mon, 03 Jun 2019 09:04:00 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 16:03:45 GMT
Message-Id: <fe91ff5fca48e54cd24f840f6bca9cead4eb3718.1559577826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v3.git.gitgitgadget@gmail.com>
References: <pull.184.v2.git.gitgitgadget@gmail.com>
        <pull.184.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 13/14] commit-graph: verify chains with --shallow mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If we wrote a commit-graph chain, we only modified the tip file in
the chain. It is valuable to verify what we wrote, but not waste
time checking files we did not write.

Add a '--shallow' option to the 'git commit-graph verify' subcommand
and check that it does not read the base graph in a two-file chain.

Making the verify subcommand read from a chain of commit-graphs takes
some rearranging of the builtin code.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-commit-graph.txt |  5 ++++-
 builtin/commit-graph.c             | 27 +++++++++++++++++++--------
 commit-graph.c                     | 15 ++++++++++++---
 commit-graph.h                     |  6 ++++--
 t/t5323-split-commit-graph.sh      | 21 +++++++++++++++++++++
 5 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 365e145e82..eb5e7865f0 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit-graph read' [--object-dir <dir>]
-'git commit-graph verify' [--object-dir <dir>]
+'git commit-graph verify' [--object-dir <dir>] [--shallow]
 'git commit-graph write' <options> [--object-dir <dir>]
 
 
@@ -80,6 +80,9 @@ Used for debugging purposes.
 
 Read the commit-graph file and verify its contents against the object
 database. Used to check for corrupted data.
++
+With the `--shallow` option, only check the tip commit-graph file in
+a chain of split commit-graphs.
 
 
 EXAMPLES
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 18e3b61fb6..7cde1e1aaa 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -5,17 +5,18 @@
 #include "parse-options.h"
 #include "repository.h"
 #include "commit-graph.h"
+#include "object-store.h"
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph [--object-dir <objdir>]"),
 	N_("git commit-graph read [--object-dir <objdir>]"),
-	N_("git commit-graph verify [--object-dir <objdir>]"),
+	N_("git commit-graph verify [--object-dir <objdir>] [--shallow]"),
 	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] <split options>"),
 	NULL
 };
 
 static const char * const builtin_commit_graph_verify_usage[] = {
-	N_("git commit-graph verify [--object-dir <objdir>]"),
+	N_("git commit-graph verify [--object-dir <objdir>] [--shallow]"),
 	NULL
 };
 
@@ -36,6 +37,7 @@ static struct opts_commit_graph {
 	int stdin_commits;
 	int append;
 	int split;
+	int shallow;
 } opts;
 
 static int graph_verify(int argc, const char **argv)
@@ -45,11 +47,14 @@ static int graph_verify(int argc, const char **argv)
 	int open_ok;
 	int fd;
 	struct stat st;
+	int flags = 0;
 
 	static struct option builtin_commit_graph_verify_options[] = {
 		OPT_STRING(0, "object-dir", &opts.obj_dir,
 			   N_("dir"),
 			   N_("The object directory to store the graph")),
+		OPT_BOOL(0, "shallow", &opts.shallow,
+			 N_("if the commit-graph is split, only verify the tip file")),
 		OPT_END(),
 	};
 
@@ -59,21 +64,27 @@ static int graph_verify(int argc, const char **argv)
 
 	if (!opts.obj_dir)
 		opts.obj_dir = get_object_directory();
+	if (opts.shallow)
+		flags |= COMMIT_GRAPH_VERIFY_SHALLOW;
 
 	graph_name = get_commit_graph_filename(opts.obj_dir);
 	open_ok = open_commit_graph(graph_name, &fd, &st);
-	if (!open_ok && errno == ENOENT)
-		return 0;
-	if (!open_ok)
+	if (!open_ok && errno != ENOENT)
 		die_errno(_("Could not open commit-graph '%s'"), graph_name);
-	graph = load_commit_graph_one_fd_st(fd, &st);
+
 	FREE_AND_NULL(graph_name);
 
+	if (open_ok)
+		graph = load_commit_graph_one_fd_st(fd, &st);
+	 else
+		graph = read_commit_graph_one(the_repository, opts.obj_dir);
+
+	/* Return failure if open_ok predicted success */
 	if (!graph)
-		return 1;
+		return !!open_ok;
 
 	UNLEAK(graph);
-	return verify_commit_graph(the_repository, graph);
+	return verify_commit_graph(the_repository, graph, flags);
 }
 
 static int graph_read(int argc, const char **argv)
diff --git a/commit-graph.c b/commit-graph.c
index 9d1e7393e4..f7459d40f2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -422,7 +422,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r, const
 	return graph_chain;
 }
 
-static struct commit_graph *read_commit_graph_one(struct repository *r, const char *obj_dir)
+struct commit_graph *read_commit_graph_one(struct repository *r, const char *obj_dir)
 {
 	struct commit_graph *g = load_commit_graph_v1(r, obj_dir);
 
@@ -1872,7 +1872,7 @@ static void graph_report(const char *fmt, ...)
 #define GENERATION_ZERO_EXISTS 1
 #define GENERATION_NUMBER_EXISTS 2
 
-int verify_commit_graph(struct repository *r, struct commit_graph *g)
+int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 {
 	uint32_t i, cur_fanout_pos = 0;
 	struct object_id prev_oid, cur_oid, checksum;
@@ -1880,6 +1880,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 	struct hashfile *f;
 	int devnull;
 	struct progress *progress = NULL;
+	int local_error = 0;
 
 	if (!g) {
 		graph_report("no commit-graph file loaded");
@@ -1974,6 +1975,9 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 				break;
 			}
 
+			/* parse parent in case it is in a base graph */
+			parse_commit_in_graph_one(r, g, graph_parents->item);
+
 			if (!oideq(&graph_parents->item->object.oid, &odb_parents->item->object.oid))
 				graph_report(_("commit-graph parent for %s is %s != %s"),
 					     oid_to_hex(&cur_oid),
@@ -2025,7 +2029,12 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 	}
 	stop_progress(&progress);
 
-	return verify_commit_graph_error;
+	local_error = verify_commit_graph_error;
+
+	if (!(flags & COMMIT_GRAPH_VERIFY_SHALLOW) && g->base_graph)
+		local_error |= verify_commit_graph(r, g->base_graph, flags);
+
+	return local_error;
 }
 
 void free_commit_graph(struct commit_graph *g)
diff --git a/commit-graph.h b/commit-graph.h
index 194acab2b7..84e5e91fc6 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -61,7 +61,7 @@ struct commit_graph {
 };
 
 struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
-
+struct commit_graph *read_commit_graph_one(struct repository *r, const char *obj_dir);
 struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 					size_t graph_size);
 
@@ -89,7 +89,9 @@ int write_commit_graph(const char *obj_dir,
 		       unsigned int flags,
 		       const struct split_commit_graph_opts *split_opts);
 
-int verify_commit_graph(struct repository *r, struct commit_graph *g);
+#define COMMIT_GRAPH_VERIFY_SHALLOW	(1 << 0)
+
+int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags);
 
 void close_commit_graph(struct repository *);
 void free_commit_graph(struct commit_graph *);
diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
index 2f9f1bf0dd..b70dc90706 100755
--- a/t/t5323-split-commit-graph.sh
+++ b/t/t5323-split-commit-graph.sh
@@ -204,4 +204,25 @@ test_expect_success 'test merge stragety constants' '
 	)
 '
 
+corrupt_file() {
+	file=$1
+	pos=$2
+	data="${3:-\0}"
+	printf "$data" | dd of="$file" bs=1 seek="$pos" conv=notrunc
+}
+
+test_expect_success 'verify shallow' '
+	git clone . verify &&
+	(
+		cd verify &&
+		git commit-graph verify &&
+		base_file=$graphdir/graph-$(head -n 1 $graphdir/commit-graph-chain).graph &&
+		corrupt_file "$base_file" 1760 "\01" &&
+		git commit-graph verify --shallow &&
+		test_must_fail git commit-graph verify 2>test_err &&
+		grep -v "^+" test_err >err &&
+		test_i18ngrep "incorrect checksum" err
+	)
+'
+
 test_done
-- 
gitgitgadget

