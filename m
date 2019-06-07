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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FC4C1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 18:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbfFGSia (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 14:38:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38922 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730729AbfFGSi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 14:38:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so4343021edv.6
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 11:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U1G7oBzvNdjSg73ajJMxrcQ3SHt2Owi1t5+poArVRHQ=;
        b=pzhapYkDsqDaPspK3R/ryxF8Bmpe2HVfUykMIC2VC2Vt/usb7exrvW7racgyR1ApqP
         y4ce/eLB+VOwtkIt8NfE3dtAUscZ46ij78iQxtGOB3BEDLh6PMyCfhvDusimNHEL/59q
         j9YzHunR789YmA6qUCBx7HzD14PQCAE4kQDH72RUMqgNFe0u/d7Fee3psK4VKsE0EFJp
         Q7PjVjt2drJBIvcDma8EcdaUun6rACZca2bDX8mKIzwscEI8hqGKZu7aEoSvTVRPpLhL
         eufRltqi0OiGjOVppWx18+UmUEEiY+Co+klmERIF8aevfDfxyGiPiJshuwU/HEjQyJDf
         Oupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U1G7oBzvNdjSg73ajJMxrcQ3SHt2Owi1t5+poArVRHQ=;
        b=Huh+W/DZ4d5x2PvdlnkEWoZhfRwTemB3e9fgta3WqBBytNtuhZYL1jj8qKTdOXbiow
         IB6FmCfQHpWf6JXQEqjOCV9vTVhd6jJexftpP4hOTMWUyXNXFSQZVVcCmqo6UJ+bC7OS
         eo3BW6u8t000PMH2O7mtuG2q1K8OZ+zyVooyi1cHxA8a6cQp3zSuMqzg3LPK9K1zR5KD
         cDhvj6PxtdhNCQu+PdBS+/PEDHqyRwVd29r96XK36K5Z2wS6T9JFBb+68pEetIWgedvS
         79oMo0aaiv01R30AxMwFV6e4+lp6eh8EmR98D/g8EXXjFkD6E/nFMny1aeyiW0EFia9V
         C0hA==
X-Gm-Message-State: APjAAAXzFgU2dtH+DSjoKwkWiVa5L6L8Sdb9zi+VzDwB+gIph6UHPU9E
        Nw/uAIqkBmxSQQ1p4+c6L9stmDC6
X-Google-Smtp-Source: APXvYqwBx5i08UJ/C/sUtNvBKFsWzRgumW3Kivgxu+dnNFQTULj+IH3XEigMu1r0eh+dV0BUESSpUw==
X-Received: by 2002:a17:906:6552:: with SMTP id u18mr15675167ejn.300.1559932705595;
        Fri, 07 Jun 2019 11:38:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8sm747790edk.18.2019.06.07.11.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:38:25 -0700 (PDT)
Date:   Fri, 07 Jun 2019 11:38:25 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jun 2019 18:38:09 GMT
Message-Id: <5238bbbec35d18918a95c18bd289abfe93e89933.1559932699.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v5.git.gitgitgadget@gmail.com>
References: <pull.184.v4.git.gitgitgadget@gmail.com>
        <pull.184.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 06/16] commit-graph: rearrange chunk count logic
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
index 0ff1a4f379..5f25dff193 100644
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

