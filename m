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
	by dcvr.yhbt.net (Postfix) with ESMTP id D16161F462
	for <e@80x24.org>; Tue, 18 Jun 2019 18:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbfFRSOZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 14:14:25 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44979 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfFRSOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 14:14:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so23016247edr.11
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 11:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F/Mgfk0oSYgaXr7JjZM/WkER4zxYqqsJsozjOKTWq4E=;
        b=WfWf9hGxNTTuU5qseJBITEb4jRhXLjxWuuk1PI3z2zpHxChqNvSQwDPporWJvybMH0
         bR/yC0GkKVfjO/I9ce7N/WgFot6WMjRpN1Hvtdtzn+eApxq7BpqxU6p7Myr1oQIwWrfE
         snN2ro0MBBkzYSXskGiM/IqJ/9IMUv8z+323ok+aELhNLLpk/up6qfDXrpeXnZLKrDCf
         Ka+UuZCje4uLjm642vC9dWdYfR7M1XlZYoqq5d9kkC5lVZ6BTm4jcm4gsnrfq+nLzX5l
         /Lss9MrSvaHusNrA8uiz3wXopG6puMfziqPV78iiWCQSC3qIDerSWUTjVb38ZsPcOqvH
         BTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F/Mgfk0oSYgaXr7JjZM/WkER4zxYqqsJsozjOKTWq4E=;
        b=iryWKqAfHeCCGVg7vhwMF7dtbMjXweAvFObEJ4H80CJp21+0OKDnyUwjfk0MQBEvwO
         tdUs5mI8pYX9jvjvtu5sLqVqvlWqvYNA0mJfU8AyN9+nkZuk2c7iEk4Ii6QC9bKu5/EF
         FDgom+uZUP/LLt1dCdp0jYMPM++7WK977/AQxo5VWBMM52liMIC33jq5JcyYoa5ytKLo
         G+qCE9jnsqBGhNbtZrhBy5dquTjlysdMZcUyRskIvEwNQ5rPPnBSeANl5C7hvTfKGI8C
         K7C8f3wHFpRpkrz5jF/osgw+6uqJbN+Mmhqy/nBXMckHuBS+IDFAkEwhtQqg8e6z8UHn
         VqbQ==
X-Gm-Message-State: APjAAAUXBMoW1ZZDfe3s5/h/18SwYkE1d4xbJq0+emRYAldYkyoNFvDU
        pBuRORGwuv7T+7aHc/5Bzub8rr6V
X-Google-Smtp-Source: APXvYqwvtgQOEMKYoV1vpkCJUB3tQdltqJm1icqmZlqVRzqM1yKXLwPNaLF+GL7KT6r7HZrgJPwvWQ==
X-Received: by 2002:a17:906:4995:: with SMTP id p21mr102683988eju.140.1560881662851;
        Tue, 18 Jun 2019 11:14:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bs5sm2824232ejb.10.2019.06.18.11.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:14:22 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:14:22 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 18:14:02 GMT
Message-Id: <pull.184.v6.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v5.git.gitgitgadget@gmail.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 00/18] Commit-graph: Write incremental files
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
   
   

Updates in V6:

 * Rebased onto ds/close-object-store and resolved conflicts around
   close_commit_graph().
   
   
 * Updated path normalization to be resilient to double-slashes and trailing
   slashes.
   
   
 * Added a prepare_alt_odb() call in load_commit_graph_one() for
   cross-alternate graph loads during 'verify' subcommands.
   
   

Thanks, -Stolee

[1] 
https://github.com/git/git/commit/43d356180556180b4ef6ac232a14498a5bb2b446
commit-graph write: don't die if the existing graph is corrupt

Derrick Stolee (18):
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
  commit-graph: normalize commit-graph filenames
  commit-graph: test verify across alternates

 Documentation/git-commit-graph.txt            |  26 +-
 .../technical/commit-graph-format.txt         |  11 +-
 Documentation/technical/commit-graph.txt      | 195 +++++
 builtin/commit-graph.c                        |  58 +-
 builtin/commit.c                              |   2 +-
 builtin/gc.c                                  |   3 +-
 commit-graph.c                                | 823 ++++++++++++++++--
 commit-graph.h                                |  25 +-
 t/t5318-commit-graph.sh                       |   2 +-
 t/t5324-split-commit-graph.sh                 | 343 ++++++++
 10 files changed, 1414 insertions(+), 74 deletions(-)
 create mode 100755 t/t5324-split-commit-graph.sh


base-commit: 2d511cfc0bfe1d2b98ba8b272ddd9ba83e84e5f8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-184%2Fderrickstolee%2Fgraph%2Fincremental-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-184/derrickstolee/graph/incremental-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/184

Range-diff vs v5:

  1:  7a0bfaaa6d =  1:  7c3c0df3cd commit-graph: document commit-graph chains
  2:  ce139d80df !  2:  a06428d749 commit-graph: prepare for commit-graph chains
     @@ -44,11 +44,11 @@
      +	free_commit_graph(g);
      +}
      +
     - void close_commit_graph(struct repository *r)
     + void close_commit_graph(struct raw_object_store *o)
       {
     --	free_commit_graph(r->objects->commit_graph);
     -+	close_commit_graph_one(r->objects->commit_graph);
     - 	r->objects->commit_graph = NULL;
     +-	free_commit_graph(o->commit_graph);
     ++	close_commit_graph_one(o->commit_graph);
     + 	o->commit_graph = NULL;
       }
       
      @@
  3:  2470d2b548 =  3:  62af96e62b commit-graph: rename commit_compare to oid_compare
  4:  fc3423046b =  4:  0b236c27eb commit-graph: load commit-graph chains
  5:  d14c79f9d5 =  5:  3c1bfcf30b commit-graph: add base graphs chunk
  6:  5238bbbec3 =  6:  6595617bf1 commit-graph: rearrange chunk count logic
  7:  02b0359571 !  7:  ee8c09fc5e commit-graph: write commit-graph chains
     @@ -263,7 +263,7 @@
       		UNLEAK(ctx->graph_name);
       		error(_("unable to create leading directories of %s"),
      @@
     - 		return errno;
     + 		return -1;
       	}
       
      -	hold_lock_file_for_update(&lk, ctx->graph_name, LOCK_DIE_ON_ERROR);
     @@ -340,7 +340,7 @@
      +		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 2] = new_base_hash;
      +	}
      +
     - 	close_commit_graph(ctx->r);
     + 	close_commit_graph(ctx->r->objects);
      -	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
      +	finalize_hashfile(f, file_hash.hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
      +
     @@ -481,8 +481,8 @@
       #define COMMIT_GRAPH_PROGRESS   (1 << 1)
      +#define COMMIT_GRAPH_SPLIT      (1 << 2)
       
     - int write_commit_graph_reachable(const char *obj_dir, unsigned int flags);
     - int write_commit_graph(const char *obj_dir,
     + /*
     +  * The write_commit_graph* methods return zero on success
      
       diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
       --- a/t/t5318-commit-graph.sh
  8:  a0330ebd2d =  8:  dfca87d146 commit-graph: add --split option to builtin
  9:  28eccfa52b =  9:  cae2eb935a commit-graph: merge commit-graph chains
 10:  2093bab5b1 ! 10:  65b1cc6ae9 commit-graph: allow cross-alternate chains
     @@ -97,6 +97,8 @@
      -	for (i = 0; i < count && valid; i++) {
      -		char *graph_name;
      -		struct commit_graph *g;
     ++	prepare_alt_odb(r);
     ++
      +	for (i = 0; i < count; i++) {
      +		struct object_directory *odb;
       
 11:  554880e3d7 = 11:  2d2977b7df commit-graph: expire commit-graph files
 12:  66be8b03a8 ! 12:  71f3e9fda9 commit-graph: create options for split files
     @@ -119,24 +119,29 @@
       			     builtin_commit_graph_write_options,
       			     builtin_commit_graph_write_usage, 0);
      @@
     + 
       	read_replace_refs = 0;
       
     - 	if (opts.reachable)
     +-	if (opts.reachable)
      -		return write_commit_graph_reachable(opts.obj_dir, flags);
     -+		return write_commit_graph_reachable(opts.obj_dir, flags, &split_opts);
     ++	if (opts.reachable) {
     ++		if (write_commit_graph_reachable(opts.obj_dir, flags, &split_opts))
     ++			return 1;
     ++		return 0;
     ++	}
       
       	string_list_init(&lines, 0);
       	if (opts.stdin_packs || opts.stdin_commits) {
      @@
     - 	result = write_commit_graph(opts.obj_dir,
     - 				    pack_indexes,
     - 				    commit_hex,
     --				    flags);
     -+				    flags,
     -+				    &split_opts);
     + 	if (write_commit_graph(opts.obj_dir,
     + 			       pack_indexes,
     + 			       commit_hex,
     +-			       flags))
     ++			       flags,
     ++			       &split_opts))
     + 		result = 1;
       
       	UNLEAK(lines);
     - 	return result;
      
       diff --git a/builtin/commit.c b/builtin/commit.c
       --- a/builtin/commit.c
     @@ -275,13 +280,19 @@
       #define COMMIT_GRAPH_PROGRESS   (1 << 1)
       #define COMMIT_GRAPH_SPLIT      (1 << 2)
       
     --int write_commit_graph_reachable(const char *obj_dir, unsigned int flags);
      +struct split_commit_graph_opts {
      +	int size_multiple;
      +	int max_commits;
      +	timestamp_t expire_time;
      +};
      +
     + /*
     +  * The write_commit_graph* methods return zero on success
     +  * and a negative value on failure. Note that if the repository
     +  * is not compatible with the commit-graph feature, then the
     +  * methods will return 0 without writing a commit-graph.
     +  */
     +-int write_commit_graph_reachable(const char *obj_dir, unsigned int flags);
      +int write_commit_graph_reachable(const char *obj_dir, unsigned int flags,
      +				 const struct split_commit_graph_opts *split_opts);
       int write_commit_graph(const char *obj_dir,
 13:  9fec4f9a36 ! 13:  5e56632b8b commit-graph: verify chains with --shallow mode
     @@ -194,7 +194,7 @@
      +
      +int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags);
       
     - void close_commit_graph(struct repository *);
     + void close_commit_graph(struct raw_object_store *);
       void free_commit_graph(struct commit_graph *);
      
       diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
 14:  795ea36ff4 = 14:  a4aa473c55 commit-graph: clean up chains after flattened write
 15:  101792b92d = 15:  4877166d2f commit-graph: test octopus merges with --split
 16:  84a3ff7c61 = 16:  be4b83fdaf commit-graph: test --split across alternate without --split
  -:  ---------- > 17:  fba62e7a42 commit-graph: normalize commit-graph filenames
  -:  ---------- > 18:  bad9f13cc2 commit-graph: test verify across alternates

-- 
gitgitgadget
