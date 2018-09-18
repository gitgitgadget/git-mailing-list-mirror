Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11F081F404
	for <e@80x24.org>; Tue, 18 Sep 2018 04:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbeIRJja (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 05:39:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40816 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeIRJja (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 05:39:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id l63-v6so330214pga.7
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 21:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L2kxBlA6o09grlg+pOFzgAWNVQtJaXzO8PzA/6R4CRI=;
        b=DksIvY9twLcidMw6iBw5vtKbDE6LG+2LpHpfBbJm2uPlOiwNHDh0WvvWdgB8n2YAuI
         yNjThWUc9T+DR8p/AGAUSOH4ldyAPiJYFuZ2GmLMDPpoAi0KPtaT3fCjUEIN+20hi4+f
         DJ1AY7uvtL5bhUVx2h56bQCKb7Jp0mb1uJtKSK5oBVSZkEkfuY3BC6advicC+UXCV38c
         Uu8prROaiaANV8baVtbc52gQSJNOX9yOxhF3TfRYHE9fpvgVgTqto7qz+74LYOaa/NBq
         UlP9uu47OCZarrjAAvjp4PhGQYNZgJNNVWu9DOssOJNKh+1dSNS23Hkm/ObUY8tYrZ0p
         Fi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L2kxBlA6o09grlg+pOFzgAWNVQtJaXzO8PzA/6R4CRI=;
        b=BYdHCTeY7JRYl1kui+ivq2rMhJjSk32fMl5/N8GTrpXjX65dsmmDa4rUMuPPJ7c56t
         tgJPeKHaKbx9W8B8UcBkK/Q+dEARXVJIOztK/fHN4VaemJZc+Xf+AgqaK+jJ4Gs6KP+J
         iljocgrlW3XpauE53C4vvoAzI2IVyHswQ7gvyQQvaYaxubI0fdS/1xTpohv2z0LbhLHS
         X2mSVqTfjgExpJ/3GjWcQBBeK1NHJRtaUMv89LP3zrKViteSoOxoIMTU2k5MNU8nylyY
         Xl35OoQ8Cn5FU0UHuJmBi/yOSH80c9uPNOF/ijiIym+mYzpBJNkUuTkfv8iWlXfv9ROq
         4j/A==
X-Gm-Message-State: APzg51D/FSnO4eisUz3BjVghKVHsb600+vT7ztdsW8c0ftS8RXkPToQ1
        a3dt+TY9XcEyoMSye+XupV2LBJ1a
X-Google-Smtp-Source: ANB0VdZS85XJCBkrlup9vR7P3KPRP77pghvdJdgmFRlcUjytHIBS0BaJwyPzoUdVP00V9rgGHVPOJA==
X-Received: by 2002:a63:2043:: with SMTP id r3-v6mr25841227pgm.105.1537243729656;
        Mon, 17 Sep 2018 21:08:49 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id b73-v6sm25984691pfj.93.2018.09.17.21.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 21:08:48 -0700 (PDT)
Date:   Mon, 17 Sep 2018 21:08:48 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Sep 2018 04:08:38 GMT
Message-Id: <0e64fc144cf4eb8b15c9e8453cf8af83330930e2.1537243720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v2.git.gitgitgadget@gmail.com>
References: <pull.25.git.gitgitgadget@gmail.com>
        <pull.25.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 5/6] commit/revisions: bookkeeping before refactoring
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

There are a few things that need to move around a little before
making a big refactoring in the topo-order logic:

1. We need access to record_author_date() and
   compare_commits_by_author_date() in revision.c. These are used
   currently by sort_in_topological_order() in commit.c.

2. Moving these methods to commit.h requires adding the author_slab
   definition to commit.h.

3. The add_parents_to_list() method in revision.c performs logic
   around the UNINTERESTING flag and other special cases depending
   on the struct rev_info. Allow this method to ignore a NULL 'list'
   parameter, as we will not be populating the list for our walk.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c   | 11 ++++-------
 commit.h   |  8 ++++++++
 revision.c |  6 ++++--
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/commit.c b/commit.c
index d0f199e122..f68e04b2f1 100644
--- a/commit.c
+++ b/commit.c
@@ -655,11 +655,8 @@ struct commit *pop_commit(struct commit_list **stack)
 /* count number of children that have not been emitted */
 define_commit_slab(indegree_slab, int);
 
-/* record author-date for each commit object */
-define_commit_slab(author_date_slab, timestamp_t);
-
-static void record_author_date(struct author_date_slab *author_date,
-			       struct commit *commit)
+void record_author_date(struct author_date_slab *author_date,
+			struct commit *commit)
 {
 	const char *buffer = get_commit_buffer(commit, NULL);
 	struct ident_split ident;
@@ -684,8 +681,8 @@ fail_exit:
 	unuse_commit_buffer(commit, buffer);
 }
 
-static int compare_commits_by_author_date(const void *a_, const void *b_,
-					  void *cb_data)
+int compare_commits_by_author_date(const void *a_, const void *b_,
+				   void *cb_data)
 {
 	const struct commit *a = a_, *b = b_;
 	struct author_date_slab *author_date = cb_data;
diff --git a/commit.h b/commit.h
index 2b1a734388..ff0eb5f8ef 100644
--- a/commit.h
+++ b/commit.h
@@ -8,6 +8,7 @@
 #include "gpg-interface.h"
 #include "string-list.h"
 #include "pretty.h"
+#include "commit-slab.h"
 
 #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
 #define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
@@ -328,6 +329,13 @@ extern int remove_signature(struct strbuf *buf);
  */
 extern int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
 
+/* record author-date for each commit object */
+define_commit_slab(author_date_slab, timestamp_t);
+
+void record_author_date(struct author_date_slab *author_date,
+			struct commit *commit);
+
+int compare_commits_by_author_date(const void *a_, const void *b_, void *unused);
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
 
diff --git a/revision.c b/revision.c
index 2dcde8a8ac..92012d5f45 100644
--- a/revision.c
+++ b/revision.c
@@ -808,7 +808,8 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 			if (p->object.flags & SEEN)
 				continue;
 			p->object.flags |= SEEN;
-			commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
+			if (list)
+				commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
 		}
 		return 0;
 	}
@@ -847,7 +848,8 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 		p->object.flags |= left_flag;
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= SEEN;
-			commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
+			if (list)
+				commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
 		}
 		if (revs->first_parent_only)
 			break;
-- 
gitgitgadget

