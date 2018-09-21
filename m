Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A2CD1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 17:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391024AbeIUX33 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 19:29:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43479 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbeIUX33 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 19:29:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so6277206pfi.10
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 10:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L2kxBlA6o09grlg+pOFzgAWNVQtJaXzO8PzA/6R4CRI=;
        b=UrPhzdRE1FAbBlh/RWIyAHF0klCBbvz/dTajPqF5Y2sD037bWGzr1go6ZdFt/j4fBK
         SNs1v0J/UMv2G4zcVcOGqh+P1be8Hw8Awj3ZFMURSCbXOspmb7diLu9KqYRFO0YZAiBM
         yZIKHUx1rEJRneS1NLslQaf5ozWRU+NTtauuG4aAgf/FNGOxBSLLmiqoAXsUjWPInFLf
         XkjCpkemRhqfJZixhA3Y1+b/rQ/2awELGRhEURJpNNJeCTD4N8tRdjTRQuWa/5chuK/1
         A0EmxDsB+ieWZDsu8GPkGomWTC/RtDokDgZeOyW7iW22EoAuhYwnQzCWYyuVspZUNp0e
         MlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L2kxBlA6o09grlg+pOFzgAWNVQtJaXzO8PzA/6R4CRI=;
        b=oKGt7by6gwS6tXAkSQB1XXaGShbQVgAx2u3HvRyEgjTosu9ZeURrlNWyTvNctATufZ
         P2RUdr3a1TZZ7RgLJbV5efKjOpA01c1osgz6rZXJBtakpCUqmQlnLdIpxL/LHvLYU5qN
         qa4cTOw/gn/YiiHOinAzVqgBnXbyUFX0JasR2JozxozCrXFsdnBfeCKElthUw/+Ca19S
         ynN9RntuYy+sZs15DJnBjrqoDyZZ/+DDu0jMA2ecOxBfHyNqtl/yRj72LZhYlsf+S2zG
         72M4Uk536/aYYhCYNXWNCAjRL19Dc/gQCq5in6ThUJf1BKZNBJMNpwP13rmzejq/14U5
         TKyA==
X-Gm-Message-State: APzg51Db9Bus9lEt+tIXqW/UfexbzF7g9VF/AOXaB++UpUIDi0QRLJem
        GSgVUsqldeNSRDKX8R7hrMhyLDkN
X-Google-Smtp-Source: ANB0VdbQf2ApF1aCgUMQ6SOz2ifVf7bZ/GQ39RuFvp1zBqvPaC8MJr6Fbgno9W6WAaWVHtMRZlu4UQ==
X-Received: by 2002:a63:5558:: with SMTP id f24-v6mr13917234pgm.37.1537551574451;
        Fri, 21 Sep 2018 10:39:34 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id l85-v6sm48035392pfk.34.2018.09.21.10.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 10:39:33 -0700 (PDT)
Date:   Fri, 21 Sep 2018 10:39:33 -0700 (PDT)
X-Google-Original-Date: Fri, 21 Sep 2018 17:39:21 GMT
Message-Id: <e86f30408240da12a52858f836134b037e85f7ae.1537551564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v3.git.gitgitgadget@gmail.com>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
        <pull.25.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 5/7] commit/revisions: bookkeeping before refactoring
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>,
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

