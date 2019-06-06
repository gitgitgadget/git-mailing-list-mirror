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
	by dcvr.yhbt.net (Postfix) with ESMTP id 66E9C1F462
	for <e@80x24.org>; Thu,  6 Jun 2019 14:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfFFOPh (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 10:15:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46174 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfFFOPg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 10:15:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id h10so3520355edi.13
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 07:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yRexFTAAHVRV/GufD+aZoXR0cLznGgM1SlRVD2E1Yhs=;
        b=LqYXTgWYLNjYapN6xkbSXP64hiQlJYC8Qv1ciGnY/izjr//xhv3YTyzJyDuIHC6qKQ
         q0n/79RXkRFiC3zZbtLcngOjwduDlH4bVW9JDYLN2VpBncB4akq6XNtGxpnNlZgE7D7N
         0m+MpyryMlC6587e9+jfbh6saVS2+Tc3zipDxMd0G5EvDdAg+3s5LDOJI3ae4D8RZWAV
         4t7PDGyTxk50859sU6qnKdSDFr+eOT/0a9lg6uqmCZ4j16bttxsKil68MIPJEEm1qbnE
         FnEduWdwz0v29eER6bOzgOUYc1NgOgyfDKeHV4GWtLvBqlWh026HqoMf50oMvhXBdqya
         R6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yRexFTAAHVRV/GufD+aZoXR0cLznGgM1SlRVD2E1Yhs=;
        b=YmmDkFB0cKmsj4BBblcDoFIQPVYa5pe2R/hduL2GeFLot5NH1uvDhv6lLzGiMEN6T3
         BKTs8K3AigbmReOLUdKV+9/JyM/bUmT4uU/+MYcbtz18i6FZwJIdyUZkaZvsz4HKEZ3C
         qO8gZaxXj9/LCXmT8gG0RGY0jXzNJADaWmJ0OREePpeNKejjDicg4CZ1b0WJUPSuXYA5
         YxKYcg1mGHO/Vm0A0EWGcRyMFKT0q3iqUguL5snat20a8BxZlIXFJloylW1UwhV2FemE
         NwdJ/ezozQSYF/ffEIup3u7cbkv4G0TYBM0kkitSawE6cvGYp9jTfWO3AmbVRXoIunuO
         5OhA==
X-Gm-Message-State: APjAAAWX46FqedCdzbQYjuEs6wvP2Y6VvhzGbYdNVI9Hy7+z5FHUdmVe
        rpdw0cpzqrONBSvHkYjE8Lff8eWB
X-Google-Smtp-Source: APXvYqxPzyOjfKyRxQOdRzPAq1oFLC5HMOhwbV/fTaOvqWwnK7WHc5cer2Cc42hptkeuuQw9DHyXBw==
X-Received: by 2002:a50:9d43:: with SMTP id j3mr50948803edk.59.1559830534616;
        Thu, 06 Jun 2019 07:15:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o22sm144108eje.2.2019.06.06.07.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 07:15:34 -0700 (PDT)
Date:   Thu, 06 Jun 2019 07:15:34 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jun 2019 14:15:19 GMT
Message-Id: <e65f9e841d577c13d26c1737ebb8a2cf65713be9.1559830527.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v4.git.gitgitgadget@gmail.com>
References: <pull.184.v3.git.gitgitgadget@gmail.com>
        <pull.184.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 06/14] commit-graph: rearrange chunk count logic
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

