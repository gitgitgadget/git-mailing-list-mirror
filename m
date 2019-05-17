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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7357D1F461
	for <e@80x24.org>; Fri, 17 May 2019 18:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfEQSlu (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 14:41:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36229 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbfEQSlu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 14:41:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id a8so11931773edx.3
        for <git@vger.kernel.org>; Fri, 17 May 2019 11:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3G7VuOul6piR8Owb9gm9/a1wCOHP1f/nont6CNVc68s=;
        b=BEIwgxTyUJ+f/6OKkSWEpDPhh+TZ8+X1DK/txtabnzXnzRqgxaR9AHDtkdaBHq++Q5
         7n21aqD2T0WcSEltCGRILRcnGWVD1iam9GQOCvq/EknzVsk3egv/Tfmy0FngqO4W1jR1
         wJ1kn/9loqmy46L+ULClhRCLUp6VpERIzwtDzl/5K3/MRMFwu8JhYBU6X9LEA67as4bU
         egzYdgxf56pM7dVMwG/aBIf6Nu7f1OXVoxvWYPB948QA+jc81NR9WXbImbwNyduK/Sud
         VvQtDrf+wsjsrAVdeslRr2lU16rgHoWSAZxqMlI7f7cO39uFWk7SnVhuecD1dpKsfmMN
         EeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3G7VuOul6piR8Owb9gm9/a1wCOHP1f/nont6CNVc68s=;
        b=uR+da0hHquCEE24lGmFNuXFbuP8IQZUSU1RX7S8mceCYJ2ZcI2POaUWJGwsSjROc2P
         dl+B/3jUriuVxsEC8BhDmgW1rfP6hrxSurHRPZSXJ5rHYsMSd/HyWd33pQyInE7Xr0sm
         5wJp/u0ZFdmTfcxLQJBeebI6zFNsUak3mvjdiaUTLhfpmwC5r0I7bv1Oy+zBVv0khnCi
         iJUC1PDhUj/lC/f6NRj/72D84hp8Fz43Zk7/Fs3ihMv5yKUSBCvGdEyEvJcW4kUXB0cx
         T7dWuSMCnYEAzDLxlqc2cM62ILvMygq9PrN2WZ7Bfj4bazrjoC33O8F7r3+cRYcqqc3n
         WAhQ==
X-Gm-Message-State: APjAAAVs+nHpy+k1kOHWi5LNQMuvI/fnQFfavmnUbWm4Lb+Y+OT/s/Sr
        xXMx7JxaZPWdj8Z7iTtBKU6VOrqU
X-Google-Smtp-Source: APXvYqwqO4DLYsVO8cwajETwB7Y4WykrvrCOoTPrZzPvMGZgjHTCAtCvTEjH4biluA3pOfFy2vz5Cg==
X-Received: by 2002:a17:906:488e:: with SMTP id v14mr6487539ejq.216.1558118508420;
        Fri, 17 May 2019 11:41:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t29sm2958370edb.30.2019.05.17.11.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:41:47 -0700 (PDT)
Date:   Fri, 17 May 2019 11:41:47 -0700 (PDT)
X-Google-Original-Date: Fri, 17 May 2019 18:41:44 GMT
Message-Id: <9ff662e5e94d4a157c27e066ee4d01a04f00c295.1558118506.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.208.git.gitgitgadget@gmail.com>
References: <pull.208.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] commit-graph: use raw_object_store when closing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The close_commit_graph() method took a repository struct, but then
only uses the raw_object_store within. Change the function prototype
to make the method more flexible.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 8 ++++----
 commit-graph.h | 2 +-
 upload-pack.c  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 7723156964..e777e269aa 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -359,10 +359,10 @@ int generation_numbers_enabled(struct repository *r)
 	return !!first_generation;
 }
 
-void close_commit_graph(struct repository *r)
+void close_commit_graph(struct raw_object_store *o)
 {
-	free_commit_graph(r->objects->commit_graph);
-	r->objects->commit_graph = NULL;
+	free_commit_graph(o->commit_graph);
+	o->commit_graph = NULL;
 }
 
 static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t *pos)
@@ -1086,7 +1086,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
 
-	close_commit_graph(ctx->r);
+	close_commit_graph(ctx->r->objects);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	commit_lock_file(&lk);
 
diff --git a/commit-graph.h b/commit-graph.h
index 70f4caf0c7..afa3633592 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -76,7 +76,7 @@ int write_commit_graph(const char *obj_dir,
 
 int verify_commit_graph(struct repository *r, struct commit_graph *g);
 
-void close_commit_graph(struct repository *);
+void close_commit_graph(struct raw_object_store *);
 void free_commit_graph(struct commit_graph *);
 
 #endif
diff --git a/upload-pack.c b/upload-pack.c
index d098ef5982..b51bed21e4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -717,7 +717,7 @@ static void deepen_by_rev_list(struct packet_writer *writer, int ac,
 {
 	struct commit_list *result;
 
-	close_commit_graph(the_repository);
+	close_commit_graph(the_repository->objects);
 	result = get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALLOW);
 	send_shallow(writer, result);
 	free_commit_list(result);
-- 
gitgitgadget

