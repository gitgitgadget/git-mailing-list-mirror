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
	by dcvr.yhbt.net (Postfix) with ESMTP id A24231F462
	for <e@80x24.org>; Tue, 18 Jun 2019 18:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfFRSOd (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 14:14:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39645 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbfFRSO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 14:14:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id m10so23056470edv.6
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 11:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XO5TQYUDOFSKH3/go77O6PddED0+UJerP31SnfKiL5E=;
        b=ckzJQrd2DPqDYeeJCpMJiMrgebVD1COGYphU4dv3ErW4KHv93i3lPd4dWJxwatPF7x
         u8unUyKCqyPYp7nzVHPH56HGl9HotY3GCBuiB2eXpDmV18RaH4e1G598pJOTGvuJ/Q7q
         bLSQ13BI6pkc2z8PoBZ3RfO9VODRpdpLUFnw4ITjg0dAt3UJm7d3nOUKbBsIdStOr0EE
         EPeP3G6f628C5WNRZDBdp+Kzf3kjl9Ft7MvisaGCiWhAteMChYVLtk1bn52vClh5n/qf
         U3m18U/zX30tMqjE5WfNr98Ix1l+7Ry9In09D67/D9L/09fpX41QfLWP9uVWHReCpZxi
         pCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XO5TQYUDOFSKH3/go77O6PddED0+UJerP31SnfKiL5E=;
        b=NvH/1kp7dB5G5GAkXShmgpyq/qn2pcri9TdowKesbsBJeDfbHVNCgd7ZID8XabBAng
         fIZRDRyXSgnc0S/t9Ix04SnVZ2K16+spWB5Gu7CReFD3xYuwnT1ys9vQAYM+GYhsveQ7
         Fn8/luT+6AJAD36v3QVmZprt4FJ4xnzerACPeLcQtxNvxxUoPR8RTesXfwXXc3nYAV2j
         4GHHP1YbvomT2MkBm3IHpywhMPOqS9Cqy+I2m2GBOjCYZlK3GcAS5ZuxANLHh+KF1OMX
         a/vgSgml2ZgQjNrWVDgwURwYpsCQN6o8iaNs0E2HXW2pV/8tRZBymk3mGVfBuCPn/613
         p6ug==
X-Gm-Message-State: APjAAAUbPaMeaaV47P2IT+yExCe5ioeE5Vf+R1ues/EQd6pDlULuseGH
        zomjAoZLiOD7gPmKWw4dqGYbD0dC
X-Google-Smtp-Source: APXvYqwkbZtOiP+wDbwEf/lEj97uiQp5TFqCFQGTFEwql6Wl35NQnAccw3xAulLpzH05eS3MEmFglQ==
X-Received: by 2002:aa7:c754:: with SMTP id c20mr84425472eds.265.1560881667550;
        Tue, 18 Jun 2019 11:14:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l50sm5008872edb.77.2019.06.18.11.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:14:27 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:14:27 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 18:14:08 GMT
Message-Id: <6595617bf19f7172cb9983f52a8faff4e463f795.1560881661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v6.git.gitgitgadget@gmail.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
        <pull.184.v6.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 06/18] commit-graph: rearrange chunk count logic
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
index 6f7961d071..f2163e109f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1213,7 +1213,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	uint64_t chunk_offsets[5];
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
-	int num_chunks = ctx->num_extra_edges ? 4 : 3;
+	int num_chunks = 3;
 
 	ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
 	if (safe_create_leading_directories(ctx->graph_name)) {
@@ -1226,27 +1226,34 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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

