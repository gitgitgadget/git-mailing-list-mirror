Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6891F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 13:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393671AbfJXNkt (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 09:40:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55107 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393664AbfJXNkt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 09:40:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id g7so2895161wmk.4
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ycXzQZeHnvQNpPkmmmc62gmowDhCHgqheuNpvH9yAqs=;
        b=Ny9hJHnv9DwVZbRV9MqxuxVk5dTKzcCakpdEykAZsJlaGkNJxUcAgN3644hV3DwvF7
         rvh2IGxBtg1U0Iah0V6wd3jBZ9oFgUcv3qI5+YMgBLTuHEGwKt2IAetKiwPK9icDCQx6
         LXkF90JQFyWG5tLlTctJD3m/LPPdihp5UqmskOHk4qGGc6UPm9oqInF1phDR3MoKZGN9
         2EiNwjCd3LLVKYycjG9Uxp0sqMiuYl9W8IJocaGknOtmE2pEtMwEOUO4XMAhm8nb5qMY
         RFjcxRdCpzmSdAnFRfQOqLCb5KW7YaqvpSJ8in+TE0ae9XrPCD9Hqt6OCd8p5wTM+ELu
         sBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ycXzQZeHnvQNpPkmmmc62gmowDhCHgqheuNpvH9yAqs=;
        b=MdK/whQuashmZPqTI2GFkDkuZ1JrDKN3/Yww4Tx2Mj2WuYInVTqdlJGJJ7hYPymWis
         Gy/EszzDQ4lShwhlcg7UoUA2txHafszlhkCpMQQjAviN+FZ6azk6o9CnOuAqXHAThf6s
         ko3Bw3xB/vscv/VK+Pgy95iNL+nyLTwnJDkDBUiiVFzyI5aeoBfzUO+H1135Su07gxxv
         p8fPzuy5J4tVrMXqgXXciPu8xj4X5+hVaHkKr95c9ZpBB2M8T4ejZNVMeG0WjhJFVVJQ
         jop5vWJ3bIt8IEAy2eOgO9eptabKBq4AHoM+F3OZdZOn/3Qg4IADRSP/FcuZoj0/5Htx
         9QtA==
X-Gm-Message-State: APjAAAVFAupJZCcMj605Fd4Qw+sOFx+4u2z1dyQeSgewBkPxppllDZ8c
        ViAFtBEfAOzWUdavtr/Wgrqgst06
X-Google-Smtp-Source: APXvYqygq+B/6rKjqPakJIvUoRvL7xjDMLNasStXshugdOAg4TEy4eLVr5VKLMd8dMI+tQ9II8GFcw==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr4855057wmj.91.1571924445894;
        Thu, 24 Oct 2019 06:40:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14sm2703747wrj.35.2019.10.24.06.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 06:40:45 -0700 (PDT)
Message-Id: <6d01e905911bb68b85caa2f151e723aa542eb263.1571924442.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.415.v4.git.1571924442.gitgitgadget@gmail.com>
References: <pull.415.v3.git.1571919488.gitgitgadget@gmail.com>
        <pull.415.v4.git.1571924442.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Oct 2019 13:40:42 +0000
Subject: [PATCH v4 2/2] commit-graph: fix writing first commit-graph during
 fetch
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, peff@peff.net, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous commit includes a failing test for an issue around
fetch.writeCommitGraph and fetching in a repo with a submodule. Here, we
fix that bug and set the test to "test_expect_success".

The problem arises with this set of commands when the remote repo at
<url> has a submodule. Note that --recurse-submodules is not needed to
demonstrate the bug.

	$ git clone <url> test
	$ cd test
	$ git -c fetch.writeCommitGraph=true fetch origin
	Computing commit graph generation numbers: 100% (12/12), done.
	BUG: commit-graph.c:886: missing parent <hash1> for commit <hash2>
	Aborted (core dumped)

As an initial fix, I converted the code in builtin/fetch.c that calls
write_commit_graph_reachable() to instead launch a "git commit-graph
write --reachable --split" process. That code worked, but is not how we
want the feature to work long-term.

That test did demonstrate that the issue must be something to do with
internal state of the 'git fetch' process.

The write_commit_graph() method in commit-graph.c ensures the commits we
plan to write are "closed under reachability" using close_reachable().
This method walks from the input commits, and uses the UNINTERESTING
flag to mark which commits have already been visited. This allows the
walk to take O(N) time, where N is the number of commits, instead of
O(P) time, where P is the number of paths. (The number of paths can be
exponential in the number of commits.)

However, the UNINTERESTING flag is used in lots of places in the
codebase. This flag usually means some barrier to stop a commit walk,
such as in revision-walking to compare histories. It is not often
cleared after the walk completes because the starting points of those
walks do not have the UNINTERESTING flag, and clear_commit_marks() would
stop immediately.

This is happening during a 'git fetch' call with a remote. The fetch
negotiation is comparing the remote refs with the local refs and marking
some commits as UNINTERESTING.

I tested running clear_commit_marks_many() to clear the UNINTERESTING
flag inside close_reachable(), but the tips did not have the flag, so
that did nothing.

It turns out that the calculate_changed_submodule_paths() method is at
fault. Thanks, Peff, for pointing out this detail! More specifically,
for each submodule, the collect_changed_submodules() runs a revision
walk to essentially do file-history on the list of submodules. That
revision walk marks commits UNININTERESTING if they are simplified away
by not changing the submodule.

Instead, I finally arrived on the conclusion that I should use a flag
that is not used in any other part of the code. In commit-reach.c, a
number of flags were defined for commit walk algorithms. The REACHABLE
flag seemed like it made the most sense, and it seems it was not
actually used in the file. The REACHABLE flag was used in early versions
of commit-reach.c, but was removed by 4fbcca4 (commit-reach: make
can_all_from_reach... linear, 2018-07-20).

Add the REACHABLE flag to commit-graph.c and use it instead of
UNINTERESTING in close_reachable(). This fixes the bug in manual
testing.

Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Szeder Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c   | 11 +++++++----
 commit-reach.c   |  1 -
 object.h         |  3 ++-
 t/t5510-fetch.sh |  2 +-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index fc4a43b8d6..0aea7b2ae5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -41,6 +41,9 @@
 #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
 			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
 
+/* Remember to update object flag allocation in object.h */
+#define REACHABLE       (1u<<15)
+
 char *get_commit_graph_filename(const char *obj_dir)
 {
 	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
@@ -1030,11 +1033,11 @@ static void add_missing_parents(struct write_commit_graph_context *ctx, struct c
 {
 	struct commit_list *parent;
 	for (parent = commit->parents; parent; parent = parent->next) {
-		if (!(parent->item->object.flags & UNINTERESTING)) {
+		if (!(parent->item->object.flags & REACHABLE)) {
 			ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
 			oidcpy(&ctx->oids.list[ctx->oids.nr], &(parent->item->object.oid));
 			ctx->oids.nr++;
-			parent->item->object.flags |= UNINTERESTING;
+			parent->item->object.flags |= REACHABLE;
 		}
 	}
 }
@@ -1052,7 +1055,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 		display_progress(ctx->progress, i + 1);
 		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
 		if (commit)
-			commit->object.flags |= UNINTERESTING;
+			commit->object.flags |= REACHABLE;
 	}
 	stop_progress(&ctx->progress);
 
@@ -1089,7 +1092,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
 
 		if (commit)
-			commit->object.flags &= ~UNINTERESTING;
+			commit->object.flags &= ~REACHABLE;
 	}
 	stop_progress(&ctx->progress);
 }
diff --git a/commit-reach.c b/commit-reach.c
index 3ea174788a..4ca7e706a1 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -10,7 +10,6 @@
 #include "commit-reach.h"
 
 /* Remember to update object flag allocation in object.h */
-#define REACHABLE       (1u<<15)
 #define PARENT1		(1u<<16)
 #define PARENT2		(1u<<17)
 #define STALE		(1u<<18)
diff --git a/object.h b/object.h
index 0120892bbd..25f5ab3d54 100644
--- a/object.h
+++ b/object.h
@@ -68,7 +68,8 @@ struct object_array {
  * bisect.c:                                        16
  * bundle.c:                                        16
  * http-push.c:                                     16-----19
- * commit-reach.c:                                15-------19
+ * commit-graph.c:                                15
+ * commit-reach.c:                                  16-----19
  * sha1-name.c:                                              20
  * list-objects-filter.c:                                      21
  * builtin/fsck.c:           0--3
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 195781ce8d..4b60282689 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -583,7 +583,7 @@ test_expect_success 'fetch.writeCommitGraph' '
 	)
 '
 
-test_expect_failure 'fetch.writeCommitGraph with submodules' '
+test_expect_success 'fetch.writeCommitGraph with submodules' '
 	git clone dups super &&
 	(
 		cd super &&
-- 
gitgitgadget
