Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 652CE1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 20:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeH1A3m (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 20:29:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36023 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeH1A3m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 20:29:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id e11-v6so121734plb.3
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 13:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qPPZFxjqKY5WNwiF2RtpImDHsE6WEcVyeAP8q2ZJXIA=;
        b=gQGqooAhyYBLMUWY+g6QI6/sbFk3Y2EXGrcR1kUxJqG0c/K1vkP5PKMIg+EH9clK8t
         cNh0KO5/r/ZCtHBtNzVBK7UFXUH9ZOUoQMU8cKglyoJ3LltfQRMwmw1yu5rR610jkCqk
         dOiac57ehZOzOHEWqNnUHEaH3Qn51E8hLaBD1kTgwpIDYfTxKADvrAEvOLWHEFRpdPxB
         mQZUa7h6jyzDfKbvPk9K19+DZB/BFJtt6v0jtgeatYGKcpUAuf7oQVqRrJVaJyNgcpTR
         u0dyZrji6rGphuOQ0faymD0Xft9IJS9VXAM+6chn+fcoQ5EzfxFElyUQlTS5S/2CWdUp
         Dlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qPPZFxjqKY5WNwiF2RtpImDHsE6WEcVyeAP8q2ZJXIA=;
        b=m2Q3YuJxR3t3Fd/SIxyPYTJZdClKDDFD0iUKzkbIRaTOLiRub6wnwyALq9K1c9GD6W
         8VeaatzuTfsITdvkP25EsEJRbUAYGNIjQpvZ71NExXmxraa/gml1ehj9hrTeNT0SqDAP
         7oHrATfkXtMAf8J747l/8SttEJPWZfrKLIAhPTDt9tavDfj4SDwfphOjoo10IdEz2yhu
         fXMYz57fr/Vv6TslK7AUsogcIyqInGFyrWCszKSNlI2v+M+X1G6rjUj62ElPcKoaNwTD
         KCXL0w047M6AIMdO8s6Jc3E/mRcfJDD2VsPy2gwRIk2cL3NUt0zXattKzqlgG03f1lPN
         kW9A==
X-Gm-Message-State: APzg51CpKyV95AgchhMJbfd+SP6d1HYc44gFE6T++Gy52hQuqQbSS+mc
        1tXU1uQAOaWH2GfHbct8TiqmNEeX
X-Google-Smtp-Source: ANB0VdYPjcQ8fXnCGkCZHgmdohnSbZdyJXuCzkp5J3s8GX79TSiQkKdCbtksPM6PE8IIW1wUjYlbDA==
X-Received: by 2002:a17:902:b401:: with SMTP id x1-v6mr14690498plr.310.1535402489265;
        Mon, 27 Aug 2018 13:41:29 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id f75-v6sm178540pfk.85.2018.08.27.13.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 13:41:28 -0700 (PDT)
Date:   Mon, 27 Aug 2018 13:41:28 -0700 (PDT)
X-Google-Original-Date: Mon, 27 Aug 2018 20:41:18 GMT
Message-Id: <a7272f2799d8a04e3ba0479a6ed988322665f436.1535402479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.git.gitgitgadget@gmail.com>
References: <pull.25.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/6] commit/revisions: bookkeeping before refactoring
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
index 32d1234bd7..2dbe187b8c 100644
--- a/commit.c
+++ b/commit.c
@@ -655,11 +655,8 @@ struct commit *pop_commit(struct commit_list **stack)
 /* count number of children that have not been emitted */
 define_commit_slab(indegree_slab, int);
 
-/* record author-date for each commit object */
-define_commit_slab(author_date_slab, unsigned long);
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
index e2c99d9b04..51de10e698 100644
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
index 1db70dc951..565f903e46 100644
--- a/revision.c
+++ b/revision.c
@@ -804,7 +804,8 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 			if (p->object.flags & SEEN)
 				continue;
 			p->object.flags |= SEEN;
-			commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
+			if (list)
+				commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
 		}
 		return 0;
 	}
@@ -843,7 +844,8 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
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

