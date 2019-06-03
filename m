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
	by dcvr.yhbt.net (Postfix) with ESMTP id E189A1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 16:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfFCQEC (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 12:04:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38886 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbfFCQD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 12:03:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so12684556wrs.5
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OqCXYRcMeKqsZMB3Y33NXjxUoMSHWEttFombG9rJOZU=;
        b=NyAfvOSbNP/tyjv5VGl6q3b8lMVNDL8giJe0+nMzNyboUztV5j9qdZ2LI5/LRWruh/
         LsO9f0vkQVZxiVRbNYaLJyIimIK0xflCbqdnYmBpX4dRww5ufetpwbvKpC5VFZaweCZ5
         yYoKcTTMhq+kGpLPM4VccTA+9XZ0tfOToGUw2EKDSuncmjPgz4ufR3IMS0AcymBTn5ys
         +C7ui+H3gRwRzx+f4+mUHYTdRzsn+fABow07RJyBnuGWGIluXp/PYJuI5GL50Pxoc5Af
         ipM9Oc2chhFSZoIIkkcr3jujQ7wqO8o6aAt0yWwOERKkM0TlILB9VDvboMxix6I+SKA9
         wC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OqCXYRcMeKqsZMB3Y33NXjxUoMSHWEttFombG9rJOZU=;
        b=Qwg9fjwc4+cjXhyT5LFF2ITytkclk9GfgHygDd3dz88/NCHokceOpMIuDJIRYLwLbH
         Qos8jUajEyV1xmltsmCwVEceE09aD3WxP473uOfeUcBYatsJ+zpB0uxJ/YF9GDGv2QcY
         PdwynDa2kbq/N/UYIOQZ7NuTKHEBvJe68PDZJypNKSu4jSmpOPDR/+B7iomRWKDNqAoW
         21hAVujFzBiAMbb0C0y42xkXhkohmHGsmYQRf+midSsZGUzQOsNMHyXz/l5VXu3+86G/
         p7MCYU25L3QWnuxQVFlUxbad+e8MiRmd97Xlt1j5JA+T2hT6UV6IDLmpFv7e+qqJmwOk
         /OZg==
X-Gm-Message-State: APjAAAWfuT5ZfAwwkhvZenY+LfyxBSjm+LqkhMH3g0ZWYbPkM7VYdo8v
        J1+rDvoUT5UTdkL2h9ElwYt5QXKq
X-Google-Smtp-Source: APXvYqzEhdrMMe39Juti1+1HBmQceFo7FHu2kmzB1jH1+w4ykKn7lKxEI6muKrLlySXQFCrCe7MROw==
X-Received: by 2002:a5d:6b90:: with SMTP id n16mr17266154wrx.206.1559577834621;
        Mon, 03 Jun 2019 09:03:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 135sm3657145wmb.28.2019.06.03.09.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:03:54 -0700 (PDT)
Date:   Mon, 03 Jun 2019 09:03:54 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 16:03:37 GMT
Message-Id: <df44cbc1bf6e18c3682652c2de69de7a9caf5fc2.1559577826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v3.git.gitgitgadget@gmail.com>
References: <pull.184.v2.git.gitgitgadget@gmail.com>
        <pull.184.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 05/14] commit-graph: add base graphs chunk
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
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

