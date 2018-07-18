Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BBA01F597
	for <e@80x24.org>; Wed, 18 Jul 2018 15:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbeGRPyK (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 11:54:10 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33760 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731251AbeGRPyI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 11:54:08 -0400
Received: by mail-pf0-f196.google.com with SMTP id b17-v6so2371921pfi.0
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=yAHoz9bmBrVM90lg0yL8INmp050HJlYYKsUAbAtcp1Q=;
        b=C17cSEYsk9CQzxgIyPxIKXO4MV/oq9lAlNxk/HwvMcyAFYrb9Owhk8JqD6dW4OMoI7
         Hh41rquYsyHeDX5GH418pFWzNFZ6pXD9k9FjLYHc0LCqjb0jfVyMf5133O9hvV6CPABx
         1J7ajNTyBfpi8wmEIVgvKVwQxOVXOKRDfQp+f4ThdHwgjRRB9uzHIDhhuiJuhSuF5B0l
         qd9VVweQun3Inb1vFNPBZsa1gnMikAw6sCG4dOK+UbBBNFxL0HT8CdkLMLu9nUhy2xsG
         seZLvOcMxTN+fNVCDvinfDhjWTF4Qc6hZ0492E3rnKDx1jiEMN/OVjJZj+XPDc4zSqK2
         lCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=yAHoz9bmBrVM90lg0yL8INmp050HJlYYKsUAbAtcp1Q=;
        b=Fq1uV5zmihqdQ8r6bGbqhGssnZjlqMBrFGYzmv9VSpLchqCmnahO3rxFVvb5ASciGa
         galaW8h8udx7MOjB2Dmhjl3cMZVGkHd2weoA4+BXxXhipo8C5hiwcbQVBcwjoN/qv3F1
         GDpAjqkVxwVGGrVt0utiYHm3+5YDbqD3QOcwb5bZTyxXPLcsIEyyQkxp9abumv66yHOS
         j84wT0X9EsQYyVszjyOcKJ5RMt7XG4Pv3c3pJLNkXbYMMuLUWdIf/NdgsROS2kwyGpzv
         kXkduyTBcuWl5dmWJPiyDV0/aAlcdMJGInrcgj3Dj+RVnGB/iBqlTthGSQxYTaGzXuea
         1eAA==
X-Gm-Message-State: AOUpUlFZmSOFKYyoVznvp3kyhPB21/rBqb4znnlpox8zXlWBxlzxgBTa
        L7tCT5FsUOg25dqAgEbb9whsRurm
X-Google-Smtp-Source: AAOMgpeHYTPs0xTARMkzP1K4gr/YVxYTiu1dFSRVmKURtDXuinNGdW1QkbXijvGOvbDXVfnatYK3gQ==
X-Received: by 2002:a65:5c03:: with SMTP id u3-v6mr5890930pgr.402.1531926946599;
        Wed, 18 Jul 2018 08:15:46 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id o27-v6sm13097086pfj.35.2018.07.18.08.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 08:15:45 -0700 (PDT)
Date:   Wed, 18 Jul 2018 08:15:45 -0700 (PDT)
X-Google-Original-Date: Wed, 18 Jul 2018 15:15:31 GMT
Message-Id: <f4ab234ed20ac813f41cb4be418528d3e59303fd.1531926932.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.11.git.gitgitgadget@gmail.com>
References: <pull.11.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 8/8] commit-graph: close_commit_graph before shallow walk
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Make close_commit_graph() work for arbitrary repositories.

Call close_commit_graph() when about to start a rev-list walk that
includes shallow commits. This is necessary in code paths that "fake"
shallow commits for the sake of fetch. Specifically, test 351 in
t5500-fetch-pack.sh runs

	git fetch --shallow-exclude one origin

with a file-based transfer. When the "remote" has a commit-graph, we do
not prevent the commit-graph from being loaded, but then the commits are
intended to be dynamically transferred into shallow commits during
get_shallow_commits_by_rev_list(). By closing the commit-graph before
this call, we prevent this interaction.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 8 ++++----
 commit-graph.h | 1 +
 upload-pack.c  | 2 ++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 233958e10..237d4e7d1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -256,10 +256,10 @@ static int prepare_commit_graph(struct repository *r)
 	return !!r->objects->commit_graph;
 }
 
-static void close_commit_graph(void)
+void close_commit_graph(struct repository *r)
 {
-	free_commit_graph(the_repository->objects->commit_graph);
-	the_repository->objects->commit_graph = NULL;
+	free_commit_graph(r->objects->commit_graph);
+	r->objects->commit_graph = NULL;
 }
 
 static int bsearch_graph(struct commit_graph *g, struct object_id *oid, uint32_t *pos)
@@ -871,7 +871,7 @@ void write_commit_graph(const char *obj_dir,
 	write_graph_chunk_data(f, GRAPH_OID_LEN, commits.list, commits.nr);
 	write_graph_chunk_large_edges(f, commits.list, commits.nr);
 
-	close_commit_graph();
+	close_commit_graph(the_repository);
 	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
 	commit_lock_file(&lk);
 
diff --git a/commit-graph.h b/commit-graph.h
index 76e098934..13d736cdd 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -59,6 +59,7 @@ void write_commit_graph(const char *obj_dir,
 
 int verify_commit_graph(struct repository *r, struct commit_graph *g);
 
+void close_commit_graph(struct repository *);
 void free_commit_graph(struct commit_graph *);
 
 #endif
diff --git a/upload-pack.c b/upload-pack.c
index 4ca052d0b..52ad6c8e5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -24,6 +24,7 @@
 #include "quote.h"
 #include "upload-pack.h"
 #include "serve.h"
+#include "commit-graph.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -739,6 +740,7 @@ static void deepen_by_rev_list(int ac, const char **av,
 {
 	struct commit_list *result;
 
+	close_commit_graph(the_repository);
 	result = get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHALLOW);
 	send_shallow(result);
 	free_commit_list(result);
-- 
gitgitgadget
