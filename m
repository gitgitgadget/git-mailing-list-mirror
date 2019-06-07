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
	by dcvr.yhbt.net (Postfix) with ESMTP id DB3221F462
	for <e@80x24.org>; Fri,  7 Jun 2019 18:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbfFGSik (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 14:38:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38660 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731897AbfFGSie (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 14:38:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id g13so4346709edu.5
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 11:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8822DnailxATikVLI+VQv86G1kYEmG1fgr6fxbg9rX0=;
        b=jmG32clg/ctFK9fyR/68cY+xHWLeqvb5ilSS1CcsOqsyIJnMRF3HHApxZvShaEL4Y6
         4rUV7iXQuKI6T6a7cdo42WmNziPJ9CPnVz+gvOO0iynDjl96g8TEtYT5o1KoeyQbnNsX
         OG/NQ7Ap18dDkmy/mwAuBZ7+v+vcHxce4yVDHcPAb+cmeMujGwJAnX9V7RLCCYbRrVdg
         UXpRjyTI7Vih4Kth2WEqPx0h71YlAm7ENBhq/eKu2rTR2OV+PuAuep1xFz0zmQr74mHc
         ItY7DNdkWr1dGfzN6P83PLOt2Q2PJJlbhkiFbbf+QlEvEoLwQJf3drN8MxDo9TkJIM9k
         FWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8822DnailxATikVLI+VQv86G1kYEmG1fgr6fxbg9rX0=;
        b=T2FnxXP0Yq4eEabKDPhD0A+ol/Bg5ucCJSzCW84Kp6KSyN8MBt+WEAi1/gOBAbonVm
         qEJO9ll6dRU0WpGT3pyGDXTambYEybhGuRlVFcMiVPbOhOOf236ca7I94pG82E9eORn9
         3QW8ornuYAsY/wVCTITUEvZrqr9dXxNHyKSU45h8WRvz/VrWF8Rjrtoq5MnCY+ROFmdL
         c0Atssz6BS7Au7Klrt5qTrAAvo7ye8MKYQWuW72HN3N/ZTyDrGYrZ/39m9/kOT3bO2cF
         I24D66SL+fqjGkZT4i6Y6w/KRkRsvZa+T8vjchNXg3N3aJ7v1Urt1LWbDvTw0qy4qS7r
         dkZQ==
X-Gm-Message-State: APjAAAWMl97kkmoSRKGADcpSeTq2JxA9CGqerOfEQLR8EVdaGya351I6
        NvEnCc6FZJnDoUYR+UX0LFewyrZc
X-Google-Smtp-Source: APXvYqz7JsR9Lqc0wn5SnP/dwOLdMoPjkHpnmFvjjW/hzv5hkIEg2hxSEUMVhZFfQc8YsZ29i4KAdg==
X-Received: by 2002:aa7:da4b:: with SMTP id w11mr51000682eds.36.1559932711103;
        Fri, 07 Jun 2019 11:38:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s5sm685717edh.3.2019.06.07.11.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:38:30 -0700 (PDT)
Date:   Fri, 07 Jun 2019 11:38:30 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jun 2019 18:38:16 GMT
Message-Id: <9fec4f9a36fafdb2b3d7148ec00ccbbce74b6fff.1559932699.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v5.git.gitgitgadget@gmail.com>
References: <pull.184.v4.git.gitgitgadget@gmail.com>
        <pull.184.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 13/16] commit-graph: verify chains with --shallow mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, philipoakley@iee.org,
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
 Documentation/git-commit-graph.txt |  5 ++-
 builtin/commit-graph.c             | 27 +++++++++----
 commit-graph.c                     | 15 ++++++--
 commit-graph.h                     |  6 ++-
 t/t5324-split-commit-graph.sh      | 62 ++++++++++++++++++++++++++++++
 5 files changed, 101 insertions(+), 14 deletions(-)

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
index cc4af67820..2e8e4abf57 100644
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
index 888eaa7d03..431ad2cf1d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -426,7 +426,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r, const
 	return graph_chain;
 }
 
-static struct commit_graph *read_commit_graph_one(struct repository *r, const char *obj_dir)
+struct commit_graph *read_commit_graph_one(struct repository *r, const char *obj_dir)
 {
 	struct commit_graph *g = load_commit_graph_v1(r, obj_dir);
 
@@ -1885,7 +1885,7 @@ static void graph_report(const char *fmt, ...)
 #define GENERATION_ZERO_EXISTS 1
 #define GENERATION_NUMBER_EXISTS 2
 
-int verify_commit_graph(struct repository *r, struct commit_graph *g)
+int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 {
 	uint32_t i, cur_fanout_pos = 0;
 	struct object_id prev_oid, cur_oid, checksum;
@@ -1893,6 +1893,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 	struct hashfile *f;
 	int devnull;
 	struct progress *progress = NULL;
+	int local_error = 0;
 
 	if (!g) {
 		graph_report("no commit-graph file loaded");
@@ -1987,6 +1988,9 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 				break;
 			}
 
+			/* parse parent in case it is in a base graph */
+			parse_commit_in_graph_one(r, g, graph_parents->item);
+
 			if (!oideq(&graph_parents->item->object.oid, &odb_parents->item->object.oid))
 				graph_report(_("commit-graph parent for %s is %s != %s"),
 					     oid_to_hex(&cur_oid),
@@ -2038,7 +2042,12 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
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
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 1b699a543c..3df90ae58f 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -216,4 +216,66 @@ test_expect_success 'test merge stragety constants' '
 	)
 '
 
+corrupt_file() {
+	file=$1
+	pos=$2
+	data="${3:-\0}"
+	printf "$data" | dd of="$file" bs=1 seek="$pos" conv=notrunc
+}
+
+test_expect_success 'verify hashes along chain, even in shallow' '
+	git clone --no-hardlinks . verify &&
+	(
+		cd verify &&
+		git commit-graph verify &&
+		base_file=$graphdir/graph-$(head -n 1 $graphdir/commit-graph-chain).graph &&
+		corrupt_file "$base_file" 1760 "\01" &&
+		test_must_fail git commit-graph verify --shallow 2>test_err &&
+		grep -v "^+" test_err >err &&
+		test_i18ngrep "incorrect checksum" err
+	)
+'
+
+test_expect_success 'verify --shallow does not check base contents' '
+	git clone --no-hardlinks . verify-shallow &&
+	(
+		cd verify-shallow &&
+		git commit-graph verify &&
+		base_file=$graphdir/graph-$(head -n 1 $graphdir/commit-graph-chain).graph &&
+		corrupt_file "$base_file" 1000 "\01" &&
+		git commit-graph verify --shallow &&
+		test_must_fail git commit-graph verify 2>test_err &&
+		grep -v "^+" test_err >err &&
+		test_i18ngrep "incorrect checksum" err
+	)
+'
+
+test_expect_success 'warn on base graph chunk incorrect' '
+	git clone --no-hardlinks . base-chunk &&
+	(
+		cd base-chunk &&
+		git commit-graph verify &&
+		base_file=$graphdir/graph-$(tail -n 1 $graphdir/commit-graph-chain).graph &&
+		corrupt_file "$base_file" 1376 "\01" &&
+		git commit-graph verify --shallow 2>test_err &&
+		grep -v "^+" test_err >err &&
+		test_i18ngrep "commit-graph chain does not match" err
+	)
+'
+
+test_expect_success 'verify after commit-graph-chain corruption' '
+	git clone --no-hardlinks . verify-chain &&
+	(
+		cd verify-chain &&
+		corrupt_file "$graphdir/commit-graph-chain" 60 "G" &&
+		git commit-graph verify 2>test_err &&
+		grep -v "^+" test_err >err &&
+		test_i18ngrep "invalid commit-graph chain" err &&
+		corrupt_file "$graphdir/commit-graph-chain" 60 "A" &&
+		git commit-graph verify 2>test_err &&
+		grep -v "^+" test_err >err &&
+		test_i18ngrep "unable to find all commit-graph files" err
+	)
+'
+
 test_done
-- 
gitgitgadget

