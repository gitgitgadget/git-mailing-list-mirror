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
	by dcvr.yhbt.net (Postfix) with ESMTP id 719A61F462
	for <e@80x24.org>; Tue, 18 Jun 2019 18:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfFRSOn (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 14:14:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43221 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbfFRSOg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 14:14:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id e3so22988914edr.10
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jCG9MeU6Pr2JGVAkThTfRqY0myjtdAy/XJ89NpL6s1E=;
        b=fc9qB97f/WuBx01HUoBiur0CgXegouuWh0Tky0w4b8h3u6UoojOKqNRles0UEWrUo9
         FOVc0wXm+bk94BJBQUnbmjewnMOEPf6PPeQHrQME2IF65pon1EFNjCgjnd/wffqv3IRr
         ICtTPomjnizNGAN1LrBSHfSvCog+XgEW4K3feKnn+a70Qb/i5FAxdhKdNFWQukIt8YSU
         UPy9Cb8dps6Q9jh4UXz6DcpSEsdmUjYGGeYeQLO1fup0UDqUhSFhojT4Df9uMl8ik3Ds
         ZLxOj/hP9JGAQZapvD0wfD5NR9krkCRf5yRij0XVwdlaOdUvllM+HTlCsEKgUuWsF+DX
         grww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jCG9MeU6Pr2JGVAkThTfRqY0myjtdAy/XJ89NpL6s1E=;
        b=NxKuKDYV7Ne+6mCtplrHDdPFY6+/+tQReHd8tm9fNDHHWDmr018z7q+YjmsRZ3TraJ
         EUlk7oYioqRhcFYmvVb2MfjRgzeGydTbOdys2DKy5Jl5YsRvEtgMLr1VHy4qeHrnxGw7
         g1aRE5XKKH19yMxQAMtp3ivg+0dAuymStDbhn1Gt0uh1OAFYJzn0dse4I4v+B+m8wn2Z
         HWqAbO5qWZS/bNqE15gNwaAR/DasVHf1p5OfDJDvfh9WJwkAiDEB9+ZfCWZ4xJwQWwwR
         Xl4Rcj0n+sY5Q6gmfgMmou9hJJeLSDfLX1rEirVj1O3pmiJYG9yTg1w2V1IbtkZrNJhw
         XUSQ==
X-Gm-Message-State: APjAAAWPrC4XhURnIgYuRS7A2WX+hHg/LIf3RUzvlvkFGAvJsbswFzVp
        AuLtEvKJoAulyt8szziNFu50TNOJ
X-Google-Smtp-Source: APXvYqxE4kyUenQO1FetK53c4mQXHEDDDoH1n2VKnOb23ApFbe3AQls6+WNDACVDFnNH1yf1ivFyhg==
X-Received: by 2002:a17:906:c4b:: with SMTP id t11mr23593728ejf.33.1560881673490;
        Tue, 18 Jun 2019 11:14:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e33sm4965246eda.83.2019.06.18.11.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:14:32 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:14:32 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 18:14:15 GMT
Message-Id: <5e56632b8b2ec768379a9ebc42a6e5525bca337a.1560881661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v6.git.gitgitgadget@gmail.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
        <pull.184.v6.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 13/18] commit-graph: verify chains with --shallow mode
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
index 6c0b5b17e0..38027b83d9 100644
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
index 315088d205..f33f4fe009 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -428,7 +428,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r, const
 	return graph_chain;
 }
 
-static struct commit_graph *read_commit_graph_one(struct repository *r, const char *obj_dir)
+struct commit_graph *read_commit_graph_one(struct repository *r, const char *obj_dir)
 {
 	struct commit_graph *g = load_commit_graph_v1(r, obj_dir);
 
@@ -1887,7 +1887,7 @@ static void graph_report(const char *fmt, ...)
 #define GENERATION_ZERO_EXISTS 1
 #define GENERATION_NUMBER_EXISTS 2
 
-int verify_commit_graph(struct repository *r, struct commit_graph *g)
+int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 {
 	uint32_t i, cur_fanout_pos = 0;
 	struct object_id prev_oid, cur_oid, checksum;
@@ -1895,6 +1895,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 	struct hashfile *f;
 	int devnull;
 	struct progress *progress = NULL;
+	int local_error = 0;
 
 	if (!g) {
 		graph_report("no commit-graph file loaded");
@@ -1989,6 +1990,9 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 				break;
 			}
 
+			/* parse parent in case it is in a base graph */
+			parse_commit_in_graph_one(r, g, graph_parents->item);
+
 			if (!oideq(&graph_parents->item->object.oid, &odb_parents->item->object.oid))
 				graph_report(_("commit-graph parent for %s is %s != %s"),
 					     oid_to_hex(&cur_oid),
@@ -2040,7 +2044,12 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
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
index a84c22a560..df9a3b20e4 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -61,7 +61,7 @@ struct commit_graph {
 };
 
 struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
-
+struct commit_graph *read_commit_graph_one(struct repository *r, const char *obj_dir);
 struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 					size_t graph_size);
 
@@ -95,7 +95,9 @@ int write_commit_graph(const char *obj_dir,
 		       unsigned int flags,
 		       const struct split_commit_graph_opts *split_opts);
 
-int verify_commit_graph(struct repository *r, struct commit_graph *g);
+#define COMMIT_GRAPH_VERIFY_SHALLOW	(1 << 0)
+
+int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags);
 
 void close_commit_graph(struct raw_object_store *);
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

