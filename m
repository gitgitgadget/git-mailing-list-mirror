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
	by dcvr.yhbt.net (Postfix) with ESMTP id AA4671F462
	for <e@80x24.org>; Fri,  7 Jun 2019 18:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbfFGSic (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 14:38:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41642 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfFGSi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 14:38:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id p15so4330174eds.8
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 11:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LttSt/afHGf46kgj6aAAn80GNag2UU7F7XO50qPeZoE=;
        b=XHokQqRWCLfh0tcLBbV1cyy9AuegHIsOggeUSHYnyJgh8A6viewgSXwZP+6RhGVDh4
         B2lsBS73Pw7Owf4mcFSDsh2hhoWi50Yr82pTcgmvRfg48K5TXqd1fNAXw1f3uvhDMV27
         qHfO5FjmVb9DOnpLK9bBt7IpgsUejhDC6C6n8Yem9CvvQSoQ1n2lHBUhYbhOyPYz8lDd
         Y9rv5qz6zw4zdIfHINZ+bm5+1PUbXcoXUiKHstFqbMV4IkYVvo0ujUdHAEuXNvH3LnOD
         RHZesLzliGceURImdPQGp9v7r3kjgjFk+dRkNJDUUdJ4GusFgphsMXLNhjfoKtkMXjrz
         W2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LttSt/afHGf46kgj6aAAn80GNag2UU7F7XO50qPeZoE=;
        b=ZvBMbh2hjASWjPm8rf6fhJwVRsulpj/LZZT2teC9rVI9N5VJ1zxzi3GElDRg8RHjOF
         8vq+aGA/KBnpvgMzGdiCJpiwcrPAcdUV0KGEsunXFrfYkwrCyfhPTYLBLzo8BgDzp54Z
         JCL/MA334j+WCQ64JdMAjvwyz3XX2RqNd5pG5lq4PrOGvt979myAGftTWNNcZC1utno3
         ApZ9Gz4TXkzLjPwLWWKYJtyepZCtYj9cNpheYERjI3///5W1M8Ae7YEBGdjSkyFtP5VA
         qjg6oAS6jNRl7aCPYYUyVG6Xvm0V3VDjRvw/HEGzN8UaqgbZ308BmMLJlXrKff2cns1p
         uyRg==
X-Gm-Message-State: APjAAAU4JaEJUvD7kzTuDS2frZVqfrRDxbKj13s+fVekmYIK7M3PevWk
        vsJFn4rfCrzTXWXDXBpRhdo6LE8C
X-Google-Smtp-Source: APXvYqwNEb1bg3/vJ38KBPGuLMEvluBoOBnzw+hxRRiXfSKJmCJ9bAcYSnuQLw91vKq/KOo+u66LsA==
X-Received: by 2002:a50:ac4a:: with SMTP id w10mr37212218edc.33.1559932704908;
        Fri, 07 Jun 2019 11:38:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14sm717042edd.0.2019.06.07.11.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:38:24 -0700 (PDT)
Date:   Fri, 07 Jun 2019 11:38:24 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jun 2019 18:38:08 GMT
Message-Id: <d14c79f9d508067137baa0b8a8a038b681f5c450.1559932699.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v5.git.gitgitgadget@gmail.com>
References: <pull.184.v4.git.gitgitgadget@gmail.com>
        <pull.184.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 05/16] commit-graph: add base graphs chunk
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
index 263c73282e..0ff1a4f379 100644
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

