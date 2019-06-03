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
	by dcvr.yhbt.net (Postfix) with ESMTP id 212691F462
	for <e@80x24.org>; Mon,  3 Jun 2019 16:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfFCQEA (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 12:04:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36442 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbfFCQD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 12:03:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id v22so11681296wml.1
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yRexFTAAHVRV/GufD+aZoXR0cLznGgM1SlRVD2E1Yhs=;
        b=LMiGFSFfGAh8P7WgvUQQadE9axjemdFk//gdAdVwrQjiKNvW902F+mFRHMiQ1sKhbc
         42cYnixcn4m2k/JfA/if8i+lq76QIbe3BYrdfZ8yuqsF6cQU9EtuFiTTcFv4XA8w6CU/
         jgoa02T8SY9Nig4fwx+0mUoekJfG6r4DeNa3JSq0qQIj7VtpBeywqtQYf5ifSW014TGQ
         1TQwMkeMogEha9KpDJ96pL/Mpskj7uZr2anNG99cPMRO9+Xz1+PEp5OpryzPK6QldaGJ
         p1cn9tRGgMh7hJEtufIauZ++Q/epK3PVU7qbt69bbRsklcdqP1guMpVWKoOManvRDvwp
         vEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yRexFTAAHVRV/GufD+aZoXR0cLznGgM1SlRVD2E1Yhs=;
        b=SA9HHZumirEMxS5OB1N8YNU9JOhfvscn0889uHIiWSIbJL8voLrtrlYE+4jV+Zjhgk
         XCOo0fqVaYrgzRxIBLAI5DgdaVdVNAGXcq5Uq62p8+BxDwHiorby17knautQBwky9zDR
         0GqUhkGCCdlMhmrdxPs7sD7sspCpB0L5HBsC5UAiyewYut0XsIyxvjvV2wCYW4c77KOO
         z8eTSfycymO5RixnDXE99qEDN8mZvhwgbugw2g2zEHmQeWlKEza7Q1sJgS3bm3n5+Jpr
         Y2r79vh3rNtq2vIAptAQoFykLmgGpc9DYzuBZJYgtCAga/U80AshjzausjgnjvO1oC0O
         2q7g==
X-Gm-Message-State: APjAAAWtkwGz6/ASKBAErdI9A5ujUaI11OU2pPwKstXqkBVCzOPRLV+f
        zD2+sk2iwQOQQWH4B1aoKN1jZyFP
X-Google-Smtp-Source: APXvYqy3xG4lhe3EL/81T5LEbQggwHkOojHODGBPaZR5KmOaRt8YyYL/5Hut/7VaTYaNMM1BWFb3WA==
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr15820094wmj.153.1559577835352;
        Mon, 03 Jun 2019 09:03:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm7366406wrx.11.2019.06.03.09.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:03:54 -0700 (PDT)
Date:   Mon, 03 Jun 2019 09:03:54 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 16:03:38 GMT
Message-Id: <e65f9e841d577c13d26c1737ebb8a2cf65713be9.1559577826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v3.git.gitgitgadget@gmail.com>
References: <pull.184.v2.git.gitgitgadget@gmail.com>
        <pull.184.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 06/14] commit-graph: rearrange chunk count logic
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
index 909c841db5..80df6d6d9d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1206,7 +1206,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	uint64_t chunk_offsets[5];
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
-	int num_chunks = ctx->num_extra_edges ? 4 : 3;
+	int num_chunks = 3;
 
 	ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
 	if (safe_create_leading_directories(ctx->graph_name)) {
@@ -1219,27 +1219,34 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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

