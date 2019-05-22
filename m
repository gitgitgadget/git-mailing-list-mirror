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
	by dcvr.yhbt.net (Postfix) with ESMTP id ED00E1F462
	for <e@80x24.org>; Wed, 22 May 2019 19:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbfEVTxa (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 15:53:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44140 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731083AbfEVTx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 15:53:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id b8so5466316edm.11
        for <git@vger.kernel.org>; Wed, 22 May 2019 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SBF2mLzea+VExbgygA5wg79b6Iz5rutjkqnWziqJX0Y=;
        b=vehZXNoQ1D6wgTmeVbKXMQ9IzKV2NPt3t3zw2kE7VI2OlkIbCoJpzF8S51KVvHlGgO
         hLkIRNL2d9r0Fx2r69CjAkuBHJf07FX0Oeddl47VSLbMLnwzDHmn1lPA8UkthHa8QVE3
         YkuwOxm7JiqvlP/9vj5bi2qLf8KfIyX1VbBdEHuqIIEFiKKEKMntMz2eLmlIWZaV2D+L
         y3j9ExA4ZWHUk+rClRlgNhoO3SQXJg9cIxfLuVNaA7CfAwW3b4DlndM9uimaFwGzJ6/x
         ccPMXbU+EplZfL+CnNq77uB67EK4AziwfAd0zAiTz3daOAjHZWoQj0+W+ELNaQze8EDZ
         nuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SBF2mLzea+VExbgygA5wg79b6Iz5rutjkqnWziqJX0Y=;
        b=cZM3Y0X7/doi/PM4PeR+uOg068pmGo6tJRpvDLEoXmAisuClOdtmvV6C3rUoisfwZd
         SChBxOjRwPXdhYEIHfGGWMOGKqNM+N8wwqOKJIVjnyiI1mkht97WZ3E7CSAQhnHp31v3
         0P0KmuZyfePktwEr4LyjABksYkrmsA67BmLaWasL78nJ5uCO08mHzi7jLo76CLcgvq78
         4ZJJcHaWeMaIShpov3W+6iRIRZENoJUbyDd2BRLIu88kAAijFhkuCgluxX3hJJYcNxzG
         +pxfOq+5HmzmsSfM+5NECnx9NytEmb3vcCq4z5pLrBXQ9D2D1Yiq7oWuRFA1JCRbADER
         Sc9w==
X-Gm-Message-State: APjAAAVDpbimoA330UR+JZqWt7U6uTatPW/oYySxkwByCEzIz9BrNXcu
        DWnK6zih0M59dPpcIq9oGL5oy5ip
X-Google-Smtp-Source: APXvYqzJgBGTcqRthFN6aitSQ3M/T8qmw2qbBZNm8RVBbSBroEIVt5+oj2NsdeiBUk9c3HYEVtB8rw==
X-Received: by 2002:a50:e61a:: with SMTP id y26mr92088153edm.292.1558554806149;
        Wed, 22 May 2019 12:53:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11sm7312435eda.42.2019.05.22.12.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 12:53:25 -0700 (PDT)
Date:   Wed, 22 May 2019 12:53:25 -0700 (PDT)
X-Google-Original-Date: Wed, 22 May 2019 19:53:14 GMT
Message-Id: <4fefd0a654f6c296aad90b49df59af7a7877e3bf.1558554800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v2.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
        <pull.184.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 05/11] commit-graph: add base graphs chunk
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
index 70e44393b8..060897fff0 100644
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

