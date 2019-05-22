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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FD221F462
	for <e@80x24.org>; Wed, 22 May 2019 19:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbfEVTx3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 15:53:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41127 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732483AbfEVTx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 15:53:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id m4so5475196edd.8
        for <git@vger.kernel.org>; Wed, 22 May 2019 12:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C01HsKrrFhUnQY8NZE6qATvQwuu+lSqv8xnKNKAoBls=;
        b=hgcCXMDj3bhb9G2eE6NkSAjLa7FRrWDAUQGLPnRPzcCBsGFKFzHZg3FC1E82LIXa2J
         TSlppOpHVvoywU9de0unc7jVcuWBecsE66p5SdK7TpIgY5+JFmQS5gPkM8cJNBnYpIfU
         UEffs9ZKm0l7d5DnD8OShVGaXJjNcfCMJrSyxhuYpg+/UC5jVoQLk0Fu2galJw1UtFxm
         huI5oYppjL779QLgRxRp6kZ8qfcirfZnRKZEDeiRoXKI3UPbmdgODh/uC4s9nSpsATbb
         a0LS38Pl7T274XY+gw5f0+/LpgnsEbv2K31zPWNn/ZpcLx2Vv/ud98WXE5AaVq7PZy4X
         JCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C01HsKrrFhUnQY8NZE6qATvQwuu+lSqv8xnKNKAoBls=;
        b=ZGTZVH8w8f82jRk8VGldn80++NgBJGvdwTi9Fg8FgdNtVz3itIEpEpnJrZj2nt8TBg
         1kp65guAVSxAVSqpqUxrZPOBPewwyn1pLMyWZb2c1M7NvwomC5zFM5G8QGrvaRAMO3fx
         EfO4yniVbeQSGTvCqYPVWjYou8ueEof+UaOZFCqjw4gkQoyNsIYd0z8D2FhzRkU0IDAx
         CVNh9Q8TXTBBNMFbBoLoiQkGHpB0IwK5t3g3XgO08lP9UeUBPi357IsAbKk1uAWGIzEF
         beQKUxzAQADqdeQNjmmiVJhditarzqNcrCQOScuG7f1SSUa9GkjmLyLZq8T9NcF8idoz
         skFg==
X-Gm-Message-State: APjAAAVYZ2Fz9qeUF3aCG9t53n1L+mx5r/o+RJc7uzVybfQkg8aNwyoH
        aq1koSbFoQMpP8Tkej96KtIz4a1Z
X-Google-Smtp-Source: APXvYqwkkyoO1jOeIqvzAVX61ITrR2qM9AOEX3bEY3yA+stpI4Csl1LWWT6jDcTxkZO17Bpo4w2pnw==
X-Received: by 2002:a17:906:4a57:: with SMTP id a23mr55078996ejv.137.1558554806941;
        Wed, 22 May 2019 12:53:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j18sm3185050ejx.67.2019.05.22.12.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 12:53:26 -0700 (PDT)
Date:   Wed, 22 May 2019 12:53:26 -0700 (PDT)
X-Google-Original-Date: Wed, 22 May 2019 19:53:15 GMT
Message-Id: <a595a1eb65168fad4fae21c347ecac063a29c6f5.1558554800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v2.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
        <pull.184.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 06/11] commit-graph: rearrange chunk count logic
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

The number of chunks in a commit-graph file can change depending on
whether we need the Extra Edges Chunk. We are going to add more optional
chunks, and it will be helpful to rearrange this logic around the chunk
count before doing so.

Specifically, we need to finalize the number of chunks before writing
the commit-graph header. Further, we also need to fill out the chunk
lookup table dynamically and using "num_chunks" as we add optional
chunks is useful for adding optional chunks in the future.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 060897fff0..b8a1444217 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1192,7 +1192,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	uint64_t chunk_offsets[5];
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
-	int num_chunks = ctx->num_extra_edges ? 4 : 3;
+	int num_chunks = 3;
 
 	ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
 	if (safe_create_leading_directories(ctx->graph_name)) {
@@ -1205,27 +1205,34 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	hold_lock_file_for_update(&lk, ctx->graph_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 
-	hashwrite_be32(f, GRAPH_SIGNATURE);
-
-	hashwrite_u8(f, GRAPH_VERSION);
-	hashwrite_u8(f, oid_version());
-	hashwrite_u8(f, num_chunks);
-	hashwrite_u8(f, 0); /* unused padding byte */
-
 	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
 	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
 	chunk_ids[2] = GRAPH_CHUNKID_DATA;
-	if (ctx->num_extra_edges)
-		chunk_ids[3] = GRAPH_CHUNKID_EXTRAEDGES;
-	else
-		chunk_ids[3] = 0;
-	chunk_ids[4] = 0;
+	if (ctx->num_extra_edges) {
+		chunk_ids[num_chunks] = GRAPH_CHUNKID_EXTRAEDGES;
+		num_chunks++;
+	}
+
+	chunk_ids[num_chunks] = 0;
 
 	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
 	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
 	chunk_offsets[2] = chunk_offsets[1] + hashsz * ctx->commits.nr;
 	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * ctx->commits.nr;
-	chunk_offsets[4] = chunk_offsets[3] + 4 * ctx->num_extra_edges;
+
+	num_chunks = 3;
+	if (ctx->num_extra_edges) {
+		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
+						4 * ctx->num_extra_edges;
+		num_chunks++;
+	}
+
+	hashwrite_be32(f, GRAPH_SIGNATURE);
+
+	hashwrite_u8(f, GRAPH_VERSION);
+	hashwrite_u8(f, oid_version());
+	hashwrite_u8(f, num_chunks);
+	hashwrite_u8(f, 0);
 
 	for (i = 0; i <= num_chunks; i++) {
 		uint32_t chunk_write[3];
-- 
gitgitgadget

