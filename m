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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7617B1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 18:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfFRSOa (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 14:14:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44992 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730171AbfFRSO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 14:14:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so23016512edr.11
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=erV2XL5I78GAjsYCMjs1gZXCEmZbTa9BQFXgmKPhPXg=;
        b=miJMBYs2PeL7f2RtKMx1Srad8WQLli23Rv5K5lwccUdUPVzdlLHRWW+0M8dQahEZfB
         PuU8JG6kOKZkZLC3LTzf3zmjeilhIxOI6px0w2gEepnHCPanKoT4eyrYg5XYxlRgDq9K
         TYIs2w+DsycAYfBVI8x+SKhIgYb5xxxukaxGD8aZ6HCZ2EphtNLvbZB7gUFz0klIqimr
         BHT9ZEo41QLJM4Uyxgk6l6cStFwom5RM/D7SJWq0RPC1VwiDIx/rn0qGLAC3yu0Hir/Z
         B6isvHUhZlA2Dqy59o14dKGAqqpyke25fkOnxflJbMo8IlYnikuPuFimm0L47VB2CDXI
         oKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=erV2XL5I78GAjsYCMjs1gZXCEmZbTa9BQFXgmKPhPXg=;
        b=PWWmmVtMQDFEiaxi/n1e+gzGsI+rZX/fqoZ/QVbSJvUVqlzCllOKyDhGNDYfeuQYaT
         LvrV7speXm03mbEndJlxOJgfIHTT/85zfIptN3tvAkZ3BD26XOA31Q8QHE514XHmY4hZ
         BQT/knRYmTqSaxP+EvWoX5rVfoaoQzp4dUorsOi9qNl/HVBMpqCuwTED2zeaoEYHyrDg
         E37od8I89DUTfyEJ+KrGcVrVm9pNl2zSbGAT4lODjBmr0aAq/BRbqPQYoz2u1+hq2QGw
         /lBcoiIPymgS3VwYzs0LcYTge5dp6fur3PuEhibWBiiEejcl2H3xZGU2hIN+xvk6mGxj
         kHFA==
X-Gm-Message-State: APjAAAUfXIhjl5emIbn6NN4Jc7X9CTR2MD9MvvRjNd4RYPc6azvl0EAi
        o8+AWzJbpMLKlp2FQE/iQM7Xd89M
X-Google-Smtp-Source: APXvYqyN6mT06g9XtjuRobX7l0j2JgXFgetS7zF/BFXs5LRkyyCSf6K1Wnw3KAIT2ZC+omrXHxCHKA==
X-Received: by 2002:a17:906:a308:: with SMTP id j8mr51747473ejz.167.1560881666809;
        Tue, 18 Jun 2019 11:14:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm4800180edr.27.2019.06.18.11.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:14:26 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:14:26 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 18:14:07 GMT
Message-Id: <3c1bfcf30b6935c5dddabedab579f4e7195a060c.1560881661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v6.git.gitgitgadget@gmail.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
        <pull.184.v6.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 05/18] commit-graph: add base graphs chunk
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>,
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
index f7dfc6aecd..6f7961d071 100644
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
+		if (!cur_g ||
+		    !oideq(&oids[n], &cur_g->oid) ||
+		    !hasheq(oids[n].hash, g->chunk_base_graphs + g->hash_len * n)) {
+			warning(_("commit-graph chain does not match"));
+			return 0;
+		}
+
 		cur_g = cur_g->base_graph;
 	}
 
diff --git a/commit-graph.h b/commit-graph.h
index 5819910a5b..6e7d42cf32 100644
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

