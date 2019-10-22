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
	by dcvr.yhbt.net (Postfix) with ESMTP id 18A471F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 17:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfJVR3B (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 13:29:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41386 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbfJVR3B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 13:29:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id p4so19003783wrm.8
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 10:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d8DttUfMMt8z4XyxYPgCxye/kNmF+imJ6trAlAfXwBM=;
        b=a8GZ2smwANrCyqIKA5CBY8+1MwJ+6fPAb806rO8t6P21YUMiRzMjdqIKux2sVq7VXR
         xKmD+8Byehq4iOarsayWkVvjY6528/ihswo9Uz9f+lwe6iNAt+GWXr+W9a8VeJSRrUkq
         kc391bnGNm8T58g4s76tVRxb/6I5RJn3sBHP4yKzSMA/dc8oEUVMRdK/j5vnLIq/vg8A
         wqyEjcZ2pAT0cxr9IhFqWUwoAcEs4JO8Dbp2Yjvg7Dtcis+xr5iY0a4yzDpG2U+bZblf
         avpSgRy3UGEdhm+67kNgOrNgv05CB1Vd3pqK4V01V6k3Vr6MVTnWX5ynFBfnzsm4rfXQ
         XYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d8DttUfMMt8z4XyxYPgCxye/kNmF+imJ6trAlAfXwBM=;
        b=XFpZ5JDEDoE4tkysL59beb2x7nYjUJtKlViDKJU1okfoPK32lRy0zli5IpaFgTzm1v
         tSPyYeIMqO5u4Yf1C6zx7QnElrVlScTRA2Y64M6RkcdGWS+LOMkn14G2B3iTSVvJQFwO
         brJ7fXU+ApsL1nBsZsc6IokXZlSduKYK5p3zk1+v/vKjzlk58ntU9a4I1hPRYGsyfd7M
         AKk4YSFUhOFsYT7KTRoddpX1VxVheNHO3MOk+Hj613bkeTpYiZh+6Pcg7bWzAmNNcLFa
         geJGgux07+JV7wMqYJaGAGIQOBFS3wet9fFZ8CIWMkV2bR9zTKSQ7C35tVyZt4d39Wb2
         SALg==
X-Gm-Message-State: APjAAAXWCrNsvCnaXL9Yy7FEnQNK/1MyEzkc0lxuGYIWjbFb3PsbLtXG
        Oxo6iETgdtlK3pWbX05a4m2bLMfw
X-Google-Smtp-Source: APXvYqw71lMN04eIyowodJOShade9+3aPjCqfXPZAUQGGXksu4jjct8WzvEOV10LR8kT/vHywRywlA==
X-Received: by 2002:a5d:50c2:: with SMTP id f2mr4525105wrt.147.1571765337749;
        Tue, 22 Oct 2019 10:28:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm15510953wrn.4.2019.10.22.10.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 10:28:57 -0700 (PDT)
Message-Id: <a1e5280d4b61a972426063574f1ea890a7dab73b.1571765336.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.415.git.1571765335.gitgitgadget@gmail.com>
References: <pull.415.git.1571765335.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Oct 2019 17:28:55 +0000
Subject: [PATCH 1/1] commit-graph: fix writing first commit-graph during fetch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

While dogfooding, Johannes found a bug in the fetch.writeCommitGraph
config behavior. While his example initially happened during a clone
with --recurse-submodules, we found that it is actually a problem with
the first fetch after a new clone and no existing commit-graph file:

	$ git clone <url> test
	$ cd test
	$ git -c fetch.writeCommitGraph=true fetch origin
	Computing commit graph generation numbers: 100% (12/12), done.
	BUG: commit-graph.c:886: missing parent <hash1> for commit <hash2>
	Aborted (core dumped)

In the repo I had cloned, there were really 60 commits to scan, but
only 12 were in the list to write when calling
compute_generation_numbers(). A commit in the list expects to see a
parent, but that parent is not in the list.

As an initial test, I converted the code in builtin/fetch.c that calls
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

You may ask: did this feature ever work at all? Yes, it did, as long as
you had a commit-graph covering all of your local refs. My testing was
unfortunately limited to this scenario. The UNINTERESTING commits are
always part of the "old" commit-graph, and when we add new commits to a
top layer of the commit-graph chain those are not needed. If we happen
to merge layers of the chain, then the commits are added as a list, not
using a commit walk. Further, the test added for this config option in
t5510-fetch.sh uses local filesystem clones, which somehow avoids this
logic.

I tested running clear_commit_marks_many() to clear the UNINTERESTING
flag inside close_reachable(), but the tips did not have the flag, so
that did nothing.

Instead, I finally arrived on the conclusion that I should use a flag
that is not used in any other part of the code. In commit-reach.c, a
number of flags were defined for commit walk algorithms. The REACHABLE
flag seemed like it made the most sense, and it seems it was not
actually used in the file.

Add the REACHABLE flag to commit-graph.c and use it instead of
UNINTERESTING in close_reachable(). This fixes the bug in manual
testing.

I have failed to produce a test using the file:// protocol that
demonstrates this bug.

Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 11 +++++++----
 commit-reach.c |  1 -
 object.h       |  3 ++-
 3 files changed, 9 insertions(+), 6 deletions(-)

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
-- 
gitgitgadget
