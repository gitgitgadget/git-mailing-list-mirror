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
	by dcvr.yhbt.net (Postfix) with ESMTP id B252E1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 18:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbfFGSiZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 14:38:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42876 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfFGSiY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 14:38:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id z25so4320956edq.9
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R9/29dvwsHs5N9VVRP3LwZmlKcDXtRG9a7KY40ukvpU=;
        b=m0kT0k1RLUhl+1aFX9xtzpVOOr1Ok0W6gVzp0pVLQpHlrdm05tiZRmwb9fjag5zq/j
         SKY/3Sa5ue69EiMH8mkhZzXy5KYYJOJtPfGfZFX87eYOKwGu/BQpq4iuB0XwEW9j7Gpb
         GmPyuZoDlI2TeAr1mEjnxmPvMJ0zdv2hpqTOdlQh1A71N32L8P6pxVeAvQZrRs4lYak4
         F4/luI4hcqF18fgpLwUFzxILM2H+UWhfAZTHYG0gIS6Xdlx+7n71qjUGgicQTtJ63/pm
         uR1vGBo+pLEl82xlZivAgpZTg5nyybuX+JiG1vgEGNf0tvWgWTc01O2StDwhNl7i8C7A
         VIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R9/29dvwsHs5N9VVRP3LwZmlKcDXtRG9a7KY40ukvpU=;
        b=fljwtpID0lNVpWzxiy2r8gpj4Kf/+XHMhqC7yE4oOSaFyb6NW1YN2AoydGEg4UCyNh
         nYR7UAaDrW3OHgSOSoMIUQ/r+X6EJZbhqpdiAQANnrYLzXLbk6h03E/yhXWgT90O1kFR
         4xKohRLlPSj10ZbjlTjzIvnAVlIjerxpPRViMyhpAfU7+nMbc2aq52Tp6nCs/wKKPBQY
         Jv9DKgUDuPdHYK3RJqYLUQQ+xoIkk3dNy8X5sZM9UpwO+QGYCFT4asP+mcXhUXpYpBE4
         NSeSFkRkdfAMI9k2581oRKbO9DZoDInGthb+IjffziS5c1fqSRxXHoFHQB7xvHGf1aJp
         Yqig==
X-Gm-Message-State: APjAAAXgL4cwLo/Fo63TAcNu10vWYT6/qEUcaLRGvXOPEaCNhfO4dq99
        pa91wWxNUJTQp3P0Nan9kLxiDaKb
X-Google-Smtp-Source: APXvYqzMH5lMBDS0iV+X5//lOJGJXxJOwIy4MjZDEQeCbm636aHnif6nv6ghXselbuVfKTbFHpCGOg==
X-Received: by 2002:a50:ce06:: with SMTP id y6mr35836799edi.160.1559932700980;
        Fri, 07 Jun 2019 11:38:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f24sm714690edf.30.2019.06.07.11.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:38:20 -0700 (PDT)
Date:   Fri, 07 Jun 2019 11:38:20 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jun 2019 18:38:03 GMT
Message-Id: <pull.184.v5.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v4.git.gitgitgadget@gmail.com>
References: <pull.184.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 00/16] Commit-graph: Write incremental files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version is now ready for review.

The commit-graph is a valuable performance feature for repos with large
commit histories, but suffers from the same problem as git repack: it
rewrites the entire file every time. This can be slow when there are
millions of commits, especially after we stopped reading from the
commit-graph file during a write in 43d3561 (commit-graph write: don't die
if the existing graph is corrupt).

Instead, create a "chain" of commit-graphs in the
.git/objects/info/commit-graphs folder with name graph-{hash}.graph. The
list of hashes is given by the commit-graph-chain file, and also in a "base
graph chunk" in the commit-graph format. As we read a chain, we can verify
that the hashes match the trailing hash of each commit-graph we read along
the way and each hash below a level is expected by that graph file.

When writing, we don't always want to add a new level to the stack. This
would eventually result in performance degradation, especially when
searching for a commit (before we know its graph position). We decide to
merge levels of the stack when the new commits we will write is less than
half of the commits in the level above. This can be tweaked by the
--size-multiple and --max-commits options.

The performance is necessarily amortized across multiple writes, so I tested
by writing commit-graphs from the (non-rc) tags in the Linux repo. My test
included 72 tags, and wrote everything reachable from the tag using 
--stdin-commits. Here are the overall perf numbers:

write --stdin-commits:         8m 12s
write --stdin-commits --split:    28s
write --split && verify --shallow: 60s

Updates in V3:

 * git commit-graph verify now works on commit-graph chains. We do a simple
   test to check the behavior of a new --shallow option.
   
   
 * When someone writes a flat commit-graph, we now expire the old chain
   according to the expire time.
   
   
 * The "max commits" limit is no longer enabled by default, but instead is
   enabled by a --max-commits=<n> option. Ignored if n=0.
   
   

Updates in V4:

Johannes pointed out some test failures on the Windows platform. We found
that the tests were not running on Windows in the gitgitgadget PR builds,
which is now resolved.

 * We need to close commit-graphs recursively down the chain. This prevented
   an unlink() from working because of an open handle.
   
   
 * Creating the alternates file used a path-specification that didn't work
   on Windows.
   
   
 * Renaming a file to the same name failed, but is probably related to the
   unlink() error mentioned above.
   
   

Updates in V5:

 * Responding to multiple items of feedback. Thanks Philip, Junio, and
   Ramsay!
   
   
 * Used the test coverage report to find holes in the test coverage. While
   adding tests, I found a bug in octopus merges. The fix is in the rewrite
   of "deduplicate_commits()" as "sort_and_scan_merged_commits()" and
   covered by the new tests.
   
   

This is based on ds/commit-graph-write-refactor.

Thanks, -Stolee

[1] 
https://github.com/git/git/commit/43d356180556180b4ef6ac232a14498a5bb2b446
commit-graph write: don't die if the existing graph is corrupt

Derrick Stolee (16):
  commit-graph: document commit-graph chains
  commit-graph: prepare for commit-graph chains
  commit-graph: rename commit_compare to oid_compare
  commit-graph: load commit-graph chains
  commit-graph: add base graphs chunk
  commit-graph: rearrange chunk count logic
  commit-graph: write commit-graph chains
  commit-graph: add --split option to builtin
  commit-graph: merge commit-graph chains
  commit-graph: allow cross-alternate chains
  commit-graph: expire commit-graph files
  commit-graph: create options for split files
  commit-graph: verify chains with --shallow mode
  commit-graph: clean up chains after flattened write
  commit-graph: test octopus merges with --split
  commit-graph: test --split across alternate without --split

 Documentation/git-commit-graph.txt            |  26 +-
 .../technical/commit-graph-format.txt         |  11 +-
 Documentation/technical/commit-graph.txt      | 195 +++++
 builtin/commit-graph.c                        |  53 +-
 builtin/commit.c                              |   2 +-
 builtin/gc.c                                  |   3 +-
 commit-graph.c                                | 799 +++++++++++++++++-
 commit-graph.h                                |  25 +-
 t/t5318-commit-graph.sh                       |   2 +-
 t/t5324-split-commit-graph.sh                 | 319 +++++++
 10 files changed, 1365 insertions(+), 70 deletions(-)
 create mode 100755 t/t5324-split-commit-graph.sh


base-commit: 8520d7fc7c6edd4d71582c69a873436029b6cb1b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-184%2Fderrickstolee%2Fgraph%2Fincremental-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-184/derrickstolee/graph/incremental-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/184

Range-diff vs v4:

  1:  b184919255 =  1:  7a0bfaaa6d commit-graph: document commit-graph chains
  2:  d0dc154a27 !  2:  ce139d80df commit-graph: prepare for commit-graph chains
     @@ -14,7 +14,7 @@
           * lexicographic index : the position within the lexicographic
             order in a single commit-graph file.
      
     -     * graph position: the posiiton within the concatenated order
     +     * graph position: the position within the concatenated order
             of multiple commit-graph files
      
          Given the lexicographic index of a commit in a graph, we can
     @@ -22,28 +22,53 @@
          the lower-level graphs. To find the lexicographic index of
          a commit, we subtract the number of commits in lower-level graphs.
      
     +    While here, change insert_parent_or_die() to take a uint32_t
     +    position, as that is the type used by its only caller and that
     +    makes more sense with the limits in the commit-graph format.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/commit-graph.c b/commit-graph.c
       --- a/commit-graph.c
       +++ b/commit-graph.c
     +@@
     + 	return !!first_generation;
     + }
     + 
     ++static void close_commit_graph_one(struct commit_graph *g)
     ++{
     ++	if (!g)
     ++		return;
     ++
     ++	close_commit_graph_one(g->base_graph);
     ++	free_commit_graph(g);
     ++}
     ++
     + void close_commit_graph(struct repository *r)
     + {
     +-	free_commit_graph(r->objects->commit_graph);
     ++	close_commit_graph_one(r->objects->commit_graph);
     + 	r->objects->commit_graph = NULL;
     + }
     + 
      @@
       			    g->chunk_oid_lookup, g->hash_len, pos);
       }
       
     -+static void load_oid_from_graph(struct commit_graph *g, int pos, struct object_id *oid)
     ++static void load_oid_from_graph(struct commit_graph *g,
     ++				uint32_t pos,
     ++				struct object_id *oid)
      +{
      +	uint32_t lex_index;
      +
     ++	while (g && pos < g->num_commits_in_base)
     ++		g = g->base_graph;
     ++
      +	if (!g)
      +		BUG("NULL commit-graph");
      +
     -+	while (pos < g->num_commits_in_base)
     -+		g = g->base_graph;
     -+
      +	if (pos >= g->num_commits + g->num_commits_in_base)
     -+		BUG("position %d is beyond the scope of this commit-graph (%d local + %d base commits)",
     -+		    pos, g->num_commits, g->num_commits_in_base);
     ++		die(_("invalid commit position. commit-graph is likely corrupt"));
      +
      +	lex_index = pos - g->num_commits_in_base;
      +
     @@ -52,14 +77,17 @@
      +
       static struct commit_list **insert_parent_or_die(struct repository *r,
       						 struct commit_graph *g,
     - 						 uint64_t pos,
     -@@
     +-						 uint64_t pos,
     ++						 uint32_t pos,
     + 						 struct commit_list **pptr)
     + {
       	struct commit *c;
       	struct object_id oid;
       
      -	if (pos >= g->num_commits)
     +-		die("invalid parent position %"PRIu64, pos);
      +	if (pos >= g->num_commits + g->num_commits_in_base)
     - 		die("invalid parent position %"PRIu64, pos);
     ++		die("invalid parent position %"PRIu32, pos);
       
      -	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
      +	load_oid_from_graph(g, pos, &oid);
     @@ -95,8 +123,7 @@
      +		g = g->base_graph;
      +
      +	if (pos >= g->num_commits + g->num_commits_in_base)
     -+		BUG("position %d is beyond the scope of this commit-graph (%d local + %d base commits)",
     -+		    pos, g->num_commits, g->num_commits_in_base);
     ++		die(_("invalid commit position. commit-graph is likely corrupt"));
      +
      +	/*
      +	 * Store the "full" position, but then use the
  3:  f35b04224a =  3:  2470d2b548 commit-graph: rename commit_compare to oid_compare
  4:  ca670536df !  4:  fc3423046b commit-graph: load commit-graph chains
     @@ -82,32 +82,30 @@
      +	struct strbuf line = STRBUF_INIT;
      +	struct stat st;
      +	struct object_id *oids;
     -+	int i = 0, valid = 1;
     ++	int i = 0, valid = 1, count;
      +	char *chain_name = get_chain_filename(obj_dir);
      +	FILE *fp;
     -+
     -+	if (stat(chain_name, &st)) {
     -+		free(chain_name);
     -+		return NULL;
     -+	}
     -+
     -+	if (st.st_size <= the_hash_algo->hexsz) {
     -+		free(chain_name);
     -+		return NULL;
     -+	}
     ++	int stat_res;
      +
      +	fp = fopen(chain_name, "r");
     ++	stat_res = stat(chain_name, &st);
      +	free(chain_name);
      +
     -+	if (!fp)
     ++	if (!fp ||
     ++	    stat_res ||
     ++	    st.st_size <= the_hash_algo->hexsz)
      +		return NULL;
      +
     -+	oids = xcalloc(st.st_size / (the_hash_algo->hexsz + 1), sizeof(struct object_id));
     ++	count = st.st_size / (the_hash_algo->hexsz + 1);
     ++	oids = xcalloc(count, sizeof(struct object_id));
      +
     -+	while (strbuf_getline_lf(&line, fp) != EOF && valid) {
     ++	for (i = 0; i < count && valid; i++) {
      +		char *graph_name;
      +		struct commit_graph *g;
      +
     ++		if (strbuf_getline_lf(&line, fp) == EOF)
     ++			break;
     ++
      +		if (get_oid_hex(line.buf, &oids[i])) {
      +			warning(_("invalid commit-graph chain: line '%s' not a hash"),
      +				line.buf);
  5:  df44cbc1bf !  5:  d14c79f9d5 commit-graph: add base graphs chunk
     @@ -88,12 +88,12 @@
       	while (n) {
       		n--;
      +
     -+		if (!oideq(&oids[n], &cur_g->oid) ||
     ++		if (!cur_g ||
     ++		    !oideq(&oids[n], &cur_g->oid) ||
      +		    !hasheq(oids[n].hash, g->chunk_base_graphs + g->hash_len * n)) {
      +			warning(_("commit-graph chain does not match"));
      +			return 0;
      +		}
     -+
      +
       		cur_g = cur_g->base_graph;
       	}
  6:  e65f9e841d =  6:  5238bbbec3 commit-graph: rearrange chunk count logic
  7:  fe0aa343cd =  7:  02b0359571 commit-graph: write commit-graph chains
  8:  c42e683ef6 !  8:  a0330ebd2d commit-graph: add --split option to builtin
     @@ -9,7 +9,7 @@
          are not in the existing commit-graph or commit-graph chain. Later changes
          will allow merging the chain and expiring out-dated files.
      
     -    Add a new test script (t5323-split-commit-graph.sh) that demonstrates this
     +    Add a new test script (t5324-split-commit-graph.sh) that demonstrates this
          behavior.
      
          Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
     @@ -92,10 +92,10 @@
       		} else {
       			char *graph_name = get_commit_graph_filename(ctx->obj_dir);
      
     - diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
     + diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
       new file mode 100755
       --- /dev/null
     - +++ b/t/t5323-split-commit-graph.sh
     + +++ b/t/t5324-split-commit-graph.sh
      @@
      +#!/bin/sh
      +
  9:  d065758454 !  9:  28eccfa52b commit-graph: merge commit-graph chains
     @@ -242,30 +242,27 @@
      +	return oidcmp(&a->object.oid, &b->object.oid);
      +}
      +
     -+static void deduplicate_commits(struct write_commit_graph_context *ctx)
     ++static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
      +{
     -+	uint32_t i, num_parents, last_distinct = 0, duplicates = 0;
     ++	uint32_t i, num_parents;
      +	struct commit_list *parent;
      +
      +	if (ctx->report_progress)
      +		ctx->progress = start_delayed_progress(
     -+					_("De-duplicating merged commits"),
     ++					_("Scanning merged commits"),
      +					ctx->commits.nr);
      +
      +	QSORT(ctx->commits.list, ctx->commits.nr, commit_compare);
      +
      +	ctx->num_extra_edges = 0;
     -+	for (i = 1; i < ctx->commits.nr; i++) {
     ++	for (i = 0; i < ctx->commits.nr; i++) {
      +		display_progress(ctx->progress, i);
      +
     -+		if (oideq(&ctx->commits.list[last_distinct]->object.oid,
     ++		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
      +			  &ctx->commits.list[i]->object.oid)) {
     -+			duplicates++;
     ++			die(_("unexpected duplicate commit id %s"),
     ++			    oid_to_hex(&ctx->commits.list[i]->object.oid));
      +		} else {
     -+			if (duplicates)
     -+				ctx->commits.list[last_distinct + 1] = ctx->commits.list[i];
     -+			last_distinct++;
     -+
      +			num_parents = 0;
      +			for (parent = ctx->commits.list[i]->parents; parent; parent = parent->next)
      +				num_parents++;
     @@ -275,7 +272,6 @@
      +		}
      +	}
      +
     -+	ctx->commits.nr -= duplicates;
      +	stop_progress(&ctx->progress);
      +}
      +
     @@ -308,7 +304,7 @@
      +	if (ctx->new_base_graph)
      +		ctx->base_graph_name = xstrdup(ctx->new_base_graph->filename);
      +
     -+	deduplicate_commits(ctx);
     ++	sort_and_scan_merged_commits(ctx);
      +}
      +
       int write_commit_graph(const char *obj_dir,
     @@ -340,9 +336,9 @@
       
       	compute_generation_numbers(ctx);
      
     - diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
     - --- a/t/t5323-split-commit-graph.sh
     - +++ b/t/t5323-split-commit-graph.sh
     + diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
     + --- a/t/t5324-split-commit-graph.sh
     + +++ b/t/t5324-split-commit-graph.sh
      @@
       
       graph_git_behavior 'three-layer commit-graph: commit 11 vs 6' commits/11 commits/6
 10:  62b3fca582 ! 10:  2093bab5b1 commit-graph: allow cross-alternate chains
     @@ -18,7 +18,7 @@
          3. When writing a new commit-graph chain based on a commit-graph file
             in another object directory, do not allow success if the base file
             has of the name "commit-graph" instead of
     -       "commit-graphs/graoh-{hash}.graph".
     +       "commit-graphs/graph-{hash}.graph".
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -91,15 +91,17 @@
       }
       
      @@
     - 	oids = xcalloc(st.st_size / (the_hash_algo->hexsz + 1), sizeof(struct object_id));
     + 	count = st.st_size / (the_hash_algo->hexsz + 1);
     + 	oids = xcalloc(count, sizeof(struct object_id));
       
     - 	while (strbuf_getline_lf(&line, fp) != EOF && valid) {
     +-	for (i = 0; i < count && valid; i++) {
      -		char *graph_name;
      -		struct commit_graph *g;
     ++	for (i = 0; i < count; i++) {
      +		struct object_directory *odb;
       
     - 		if (get_oid_hex(line.buf, &oids[i])) {
     - 			warning(_("invalid commit-graph chain: line '%s' not a hash"),
     + 		if (strbuf_getline_lf(&line, fp) == EOF)
     + 			break;
      @@
       			break;
       		}
     @@ -107,6 +109,7 @@
      -		graph_name = get_split_graph_filename(obj_dir, line.buf);
      -		g = load_commit_graph_one(graph_name);
      -		free(graph_name);
     ++		valid = 0;
      +		for (odb = r->objects->odb; odb; odb = odb->next) {
      +			char *graph_name = get_split_graph_filename(odb->path, line.buf);
      +			struct commit_graph *g = load_commit_graph_one(graph_name);
     @@ -120,13 +123,18 @@
      +			if (g) {
      +				g->obj_dir = odb->path;
      +
     -+				if (add_graph_to_chain(g, graph_chain, oids, i))
     ++				if (add_graph_to_chain(g, graph_chain, oids, i)) {
      +					graph_chain = g;
     -+				else
     -+					valid = 0;
     ++					valid = 1;
     ++				}
      +
      +				break;
      +			}
     ++		}
     ++
     ++		if (!valid) {
     ++			warning(_("unable to find all commit-graph files"));
     ++			break;
      +		}
       	}
       
     @@ -182,9 +190,9 @@
       	uint32_t num_commits_in_base;
       	struct commit_graph *base_graph;
      
     - diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
     - --- a/t/t5323-split-commit-graph.sh
     - +++ b/t/t5323-split-commit-graph.sh
     + diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
     + --- a/t/t5324-split-commit-graph.sh
     + +++ b/t/t5324-split-commit-graph.sh
      @@
       	graph_read_expect 12
       '
     @@ -195,7 +203,7 @@
      +	(
      +		cd fork &&
      +		rm .git/objects/info/commit-graph &&
     -+		echo "$(pwd)"/../.git/objects >.git/objects/info/alternates &&
     ++		echo "$(pwd)/../.git/objects" >.git/objects/info/alternates &&
      +		test_commit new-commit &&
      +		git commit-graph write --reachable --split &&
      +		test_path_is_file $graphdir/commit-graph-chain &&
     @@ -217,7 +225,7 @@
      +		cd fork &&
      +		git config core.commitGraph true &&
      +		rm -rf $graphdir &&
     -+		echo "$(pwd)"/../.git/objects >.git/objects/info/alternates &&
     ++		echo "$(pwd)/../.git/objects" >.git/objects/info/alternates &&
      +		test_commit 13 &&
      +		git branch commits/13 &&
      +		git commit-graph write --reachable --split &&
 11:  b5aeeed909 ! 11:  554880e3d7 commit-graph: expire commit-graph files
     @@ -46,27 +46,7 @@
       --- a/commit-graph.c
       +++ b/commit-graph.c
      @@
     - 	return !!first_generation;
     - }
     - 
     -+static void close_commit_graph_one(struct commit_graph *g)
     -+{
     -+	if (!g)
     -+		return;
     -+
     -+	close_commit_graph_one(g->base_graph);
     -+	free_commit_graph(g);
     -+}
     -+
     - void close_commit_graph(struct repository *r)
     - {
     --	free_commit_graph(r->objects->commit_graph);
     -+	close_commit_graph_one(r->objects->commit_graph);
     - 	r->objects->commit_graph = NULL;
     - }
     - 
     -@@
     - 	deduplicate_commits(ctx);
     + 	sort_and_scan_merged_commits(ctx);
       }
       
      +static void mark_commit_graphs(struct write_commit_graph_context *ctx)
     @@ -129,6 +109,7 @@
      +
      +		if (!found)
      +			unlink(path.buf);
     ++
      +	}
      +}
      +
     @@ -148,9 +129,9 @@
       	free(ctx->graph_name);
       	free(ctx->commits.list);
      
     - diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
     - --- a/t/t5323-split-commit-graph.sh
     - +++ b/t/t5323-split-commit-graph.sh
     + diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
     + --- a/t/t5324-split-commit-graph.sh
     + +++ b/t/t5324-split-commit-graph.sh
      @@
       	test_path_is_file $graphdir/commit-graph-chain &&
       	test_line_count = 2 $graphdir/commit-graph-chain &&
 12:  ac5586a20f ! 12:  66be8b03a8 commit-graph: create options for split files
     @@ -94,7 +94,7 @@
       }
       
       extern int read_replace_refs;
     -+struct split_commit_graph_opts split_opts;
     ++static struct split_commit_graph_opts split_opts;
       
       static int graph_write(int argc, const char **argv)
       {
     @@ -294,9 +294,9 @@
       int verify_commit_graph(struct repository *r, struct commit_graph *g);
       
      
     - diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
     - --- a/t/t5323-split-commit-graph.sh
     - +++ b/t/t5323-split-commit-graph.sh
     + diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
     + --- a/t/t5324-split-commit-graph.sh
     + +++ b/t/t5324-split-commit-graph.sh
      @@
       
       graph_git_behavior 'alternate: commit 13 vs 6' commits/13 commits/6
     @@ -333,6 +333,18 @@
      +		test_line_count = 1 $graphdir/commit-graph-chain &&
      +		ls $graphdir/graph-*.graph >graph-files &&
      +		test_line_count = 3 graph-files
     ++	) &&
     ++	git clone --no-hardlinks . max-commits &&
     ++	(
     ++		cd max-commits &&
     ++		git config core.commitGraph true &&
     ++		test_line_count = 2 $graphdir/commit-graph-chain &&
     ++		test_commit 16 &&
     ++		test_commit 17 &&
     ++		git commit-graph write --reachable --split --max-commits=1 &&
     ++		test_line_count = 1 $graphdir/commit-graph-chain &&
     ++		ls $graphdir/graph-*.graph >graph-files &&
     ++		test_line_count = 1 graph-files
      +	)
      +'
      +
 13:  548ec69d01 ! 13:  9fec4f9a36 commit-graph: verify chains with --shallow mode
     @@ -197,9 +197,9 @@
       void close_commit_graph(struct repository *);
       void free_commit_graph(struct commit_graph *);
      
     - diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
     - --- a/t/t5323-split-commit-graph.sh
     - +++ b/t/t5323-split-commit-graph.sh
     + diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
     + --- a/t/t5324-split-commit-graph.sh
     + +++ b/t/t5324-split-commit-graph.sh
      @@
       	)
       '
     @@ -211,18 +211,59 @@
      +	printf "$data" | dd of="$file" bs=1 seek="$pos" conv=notrunc
      +}
      +
     -+test_expect_success 'verify shallow' '
     -+	git clone . verify &&
     ++test_expect_success 'verify hashes along chain, even in shallow' '
     ++	git clone --no-hardlinks . verify &&
      +	(
      +		cd verify &&
      +		git commit-graph verify &&
      +		base_file=$graphdir/graph-$(head -n 1 $graphdir/commit-graph-chain).graph &&
      +		corrupt_file "$base_file" 1760 "\01" &&
     ++		test_must_fail git commit-graph verify --shallow 2>test_err &&
     ++		grep -v "^+" test_err >err &&
     ++		test_i18ngrep "incorrect checksum" err
     ++	)
     ++'
     ++
     ++test_expect_success 'verify --shallow does not check base contents' '
     ++	git clone --no-hardlinks . verify-shallow &&
     ++	(
     ++		cd verify-shallow &&
     ++		git commit-graph verify &&
     ++		base_file=$graphdir/graph-$(head -n 1 $graphdir/commit-graph-chain).graph &&
     ++		corrupt_file "$base_file" 1000 "\01" &&
      +		git commit-graph verify --shallow &&
      +		test_must_fail git commit-graph verify 2>test_err &&
      +		grep -v "^+" test_err >err &&
      +		test_i18ngrep "incorrect checksum" err
      +	)
      +'
     ++
     ++test_expect_success 'warn on base graph chunk incorrect' '
     ++	git clone --no-hardlinks . base-chunk &&
     ++	(
     ++		cd base-chunk &&
     ++		git commit-graph verify &&
     ++		base_file=$graphdir/graph-$(tail -n 1 $graphdir/commit-graph-chain).graph &&
     ++		corrupt_file "$base_file" 1376 "\01" &&
     ++		git commit-graph verify --shallow 2>test_err &&
     ++		grep -v "^+" test_err >err &&
     ++		test_i18ngrep "commit-graph chain does not match" err
     ++	)
     ++'
     ++
     ++test_expect_success 'verify after commit-graph-chain corruption' '
     ++	git clone --no-hardlinks . verify-chain &&
     ++	(
     ++		cd verify-chain &&
     ++		corrupt_file "$graphdir/commit-graph-chain" 60 "G" &&
     ++		git commit-graph verify 2>test_err &&
     ++		grep -v "^+" test_err >err &&
     ++		test_i18ngrep "invalid commit-graph chain" err &&
     ++		corrupt_file "$graphdir/commit-graph-chain" 60 "A" &&
     ++		git commit-graph verify 2>test_err &&
     ++		grep -v "^+" test_err >err &&
     ++		test_i18ngrep "unable to find all commit-graph files" err
     ++	)
     ++'
      +
       test_done
 14:  6084bbd164 ! 14:  795ea36ff4 commit-graph: clean up chains after flattened write
     @@ -42,9 +42,9 @@
       cleanup:
       	free(ctx->graph_name);
      
     - diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
     - --- a/t/t5323-split-commit-graph.sh
     - +++ b/t/t5323-split-commit-graph.sh
     + diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
     + --- a/t/t5324-split-commit-graph.sh
     + +++ b/t/t5324-split-commit-graph.sh
      @@
       	)
       '
  -:  ---------- > 15:  101792b92d commit-graph: test octopus merges with --split
  -:  ---------- > 16:  84a3ff7c61 commit-graph: test --split across alternate without --split

-- 
gitgitgadget
