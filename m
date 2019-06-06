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
	by dcvr.yhbt.net (Postfix) with ESMTP id 330461F462
	for <e@80x24.org>; Thu,  6 Jun 2019 14:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfFFOPh (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 10:15:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40913 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfFFOPf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 10:15:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id r18so3555272edo.7
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OqCXYRcMeKqsZMB3Y33NXjxUoMSHWEttFombG9rJOZU=;
        b=PmYKe8df97GDp1Spl4lzsD+9FBjHpjW9+zJaL1A1NVjztH4ObrtJnMYzCxs43GhNWq
         rlhd12YKota9hSvMqmfGIWpXNXOxt4Ts10dS7eEq13+Aa8aYbnrSDlzAY0RALfyy9C/0
         /QhyZ3TZz29eno5ivyBbsNw/M4LkGtjVcvJ7LChMUavrWJ+eDtgRfv1cLigCHUSUIzfk
         g2/wj/b54J/8gEbUKvj18g0+W1HJKJuyCz8/ncrmiBtf4hkVczs91gYMxKAVqzMBPXde
         cxqPCiCco8S213mX7/dZm2mMf6ggz9pKH71BuJRssV0mOpOOVFLwlDL4bC9YaRL4sqfZ
         lC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OqCXYRcMeKqsZMB3Y33NXjxUoMSHWEttFombG9rJOZU=;
        b=h8C1LwB3ilt8iUEs2QicTiSNqKu12JQSiL1uJB9onnP3rzeLmhnkNV1MWUtOCxmzOB
         2QYFd2nWHpL2f9wfRrrKGfCj3HV8eeMUScbQCF2HoNsIgYRHXO9A2YlcUbxNh8kKnSbY
         WdIQzkh07cFzWcb57hk3KB5NWn5j1fWeLluqMUiSmOG3iHv7lTU0PCq1gQVIZbfcnN0Y
         zR1g6NLkXVwWzt+eujEiJPA5r5SpXavzOKM7GhO9FLPx6cqFfQB/ZezjdpWwTMmLj91K
         bhnK7k62MVNWcAF/U6dw7siEkhlqBYtRzB53PQ/omWIc/5D2D5zZ6G/NeyHii0zXrKvQ
         iFZg==
X-Gm-Message-State: APjAAAXL/6ok9e6WAOPvHqmDtn1T/tVXxQXJdRip0Mxhoo58ulM5C8MR
        nJuvry3mAm8Z4VxLnjDSEDa+Uoo7
X-Google-Smtp-Source: APXvYqzcxIJp/TzkKicEzgl3a23dz4WTfGzsF6R83ZXHn1omVxO7PSVk6xpSy6YLs11au4eTC79xOA==
X-Received: by 2002:a50:f599:: with SMTP id u25mr17212915edm.195.1559830533718;
        Thu, 06 Jun 2019 07:15:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f26sm476893edm.11.2019.06.06.07.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 07:15:33 -0700 (PDT)
Date:   Thu, 06 Jun 2019 07:15:33 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jun 2019 14:15:18 GMT
Message-Id: <df44cbc1bf6e18c3682652c2de69de7a9caf5fc2.1559830527.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v4.git.gitgitgadget@gmail.com>
References: <pull.184.v3.git.gitgitgadget@gmail.com>
        <pull.184.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 05/14] commit-graph: add base graphs chunk
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

To quickly verify a commit-graph chain is valid on load, we will
read from the new "Base Graphs Chunk" of each file in the chain.
This will prevent accidentally loading incorrect data from manually
editing the commit-graph-chain file or renaming graph-{hash}.graph
files.

The commit_graph struct already had an object_id struct "oid", but
it was never initialized or used. Add a line to read the hash from
the end of the commit-graph file and into the oid member.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .../technical/commit-graph-format.txt         | 11 ++++++++--
 commit-graph.c                                | 22 +++++++++++++++++++
 commit-graph.h                                |  1 +
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index 16452a0504..a4f17441ae 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -44,8 +44,9 @@ HEADER:
 
   1-byte number (C) of "chunks"
 
-  1-byte (reserved for later use)
-     Current clients should ignore this value.
+  1-byte number (B) of base commit-graphs
+      We infer the length (H*B) of the Base Graphs chunk
+      from this value.
 
 CHUNK LOOKUP:
 
@@ -92,6 +93,12 @@ CHUNK DATA:
       positions for the parents until reaching a value with the most-significant
       bit on. The other bits correspond to the position of the last parent.
 
+  Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
+      This list of H-byte hashes describe a set of B commit-graph files that
+      form a commit-graph chain. The graph position for the ith commit in this
+      file's OID Lookup chunk is equal to i plus the number of commits in all
+      base graphs.  If B is non-zero, this chunk must exist.
+
 TRAILER:
 
 	H-byte HASH-checksum of all of the above.
diff --git a/commit-graph.c b/commit-graph.c
index 3ed930159e..909c841db5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -22,6 +22,7 @@
 #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
 #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
 #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
+#define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
@@ -262,6 +263,12 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 			else
 				graph->chunk_extra_edges = data + chunk_offset;
 			break;
+
+		case GRAPH_CHUNKID_BASE:
+			if (graph->chunk_base_graphs)
+				chunk_repeated = 1;
+			else
+				graph->chunk_base_graphs = data + chunk_offset;
 		}
 
 		if (chunk_repeated) {
@@ -280,6 +287,8 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 		last_chunk_offset = chunk_offset;
 	}
 
+	hashcpy(graph->oid.hash, graph->data + graph->data_len - graph->hash_len);
+
 	if (verify_commit_graph_lite(graph))
 		return NULL;
 
@@ -315,8 +324,21 @@ static int add_graph_to_chain(struct commit_graph *g,
 {
 	struct commit_graph *cur_g = chain;
 
+	if (n && !g->chunk_base_graphs) {
+		warning(_("commit-graph has no base graphs chunk"));
+		return 0;
+	}
+
 	while (n) {
 		n--;
+
+		if (!oideq(&oids[n], &cur_g->oid) ||
+		    !hasheq(oids[n].hash, g->chunk_base_graphs + g->hash_len * n)) {
+			warning(_("commit-graph chain does not match"));
+			return 0;
+		}
+
+
 		cur_g = cur_g->base_graph;
 	}
 
diff --git a/commit-graph.h b/commit-graph.h
index f9fe32ebe3..80f4917ddb 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -55,6 +55,7 @@ struct commit_graph {
 	const unsigned char *chunk_oid_lookup;
 	const unsigned char *chunk_commit_data;
 	const unsigned char *chunk_extra_edges;
+	const unsigned char *chunk_base_graphs;
 };
 
 struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
-- 
gitgitgadget

