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
	by dcvr.yhbt.net (Postfix) with ESMTP id B4FBA1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 13:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbfFLN3v (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 09:29:51 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33797 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732439AbfFLN3s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 09:29:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id c26so25799082edt.1
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 06:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P6pRt3C+j14FgPw270XSeUHiWgfQiAZHWXBpU74afI4=;
        b=gwMid3YkgWVFBhbh54jI/DhH1DJCwExRp41hRnk8zoylYyH+FM0y8J00w93sY6BlZG
         QMgSreC1Vx6mEK4ZmR2nWX6Iyrun5Q2S2Lpq0VmTrvKgvPGr6ivYEC/RjQohsIAcpW1b
         qhBV7+fUrJqjYtGFM9LW3S8TJutIjUbOXOH8/w+gUtAVe+rnwzLqdv/46bLjjsXESAPi
         DzHY3HTHJOqWTxn/YUqBa3P7Vx68czpGHaInhTA6Qi0gxCar/ZBELAwIIVyIcd7zchyj
         MZKAmRjRSkkdrdSIKlLqgkrJcFFzqVWFN0qEFb+WgM/sefbtaXvDBUaKgxLJXP3fNcoQ
         n+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P6pRt3C+j14FgPw270XSeUHiWgfQiAZHWXBpU74afI4=;
        b=QK7BbZeFQc3jpHfVNguHHmHtrxmOa/E1G93Dxfc7nPur8B4W1rOV+PHVGJkQihB+ns
         PwBeG8Ycifi4CFZR5kBZmsxhfL0XPtr/A8n2WAb+OQ0xRmun6bEwvOsx5g9N6lQ25n0X
         rhloTMm7HPwa1dSpHIHxaMIO24MQBTDOEDVc7DZn1tOIZyAR2IqQqnR6gs77BGtufV4n
         TRG5DwEnUmAIIMa919wPSeghwt3ydQmMcSfxawiAkCLtR9fBOLiz+9VSWdbm3PS56BuK
         +tg+arKmS0yEKhsSzQIyQsAdZa+c6c5ftIHcyPJ9lx6n0zEHD+7maCUEccuhbRcDalIg
         +8LA==
X-Gm-Message-State: APjAAAUsZBpMjy1j3IbCB6p/WkHQPNd7tL4Snaca14YSA3CHswbz20g/
        q+gqqgYtqWbtl8Z2rB6WGkLKyBx5
X-Google-Smtp-Source: APXvYqxvqtOEb1arvEcfwgj07IQtCVdxXAIXph3YKU/F9dMEx+Ukr77oTMNX1Vxdl8LevWx9f9ZYEg==
X-Received: by 2002:a17:906:1385:: with SMTP id f5mr8441055ejc.137.1560346185848;
        Wed, 12 Jun 2019 06:29:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x30sm4632078edc.53.2019.06.12.06.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:29:45 -0700 (PDT)
Date:   Wed, 12 Jun 2019 06:29:45 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 13:29:33 GMT
Message-Id: <7ecf923040e30d120039d1d47eeae5e1d7ed271b.1560346174.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v5.git.gitgitgadget@gmail.com>
References: <pull.112.v4.git.gitgitgadget@gmail.com>
        <pull.112.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 11/11] commit-graph: extract write_commit_graph_file()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() method is too complex, so we are
extracting helper functions one by one.

Extract write_commit_graph_file() that takes all of the information
in the context struct and writes the data to a commit-graph file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 155 +++++++++++++++++++++++++------------------------
 1 file changed, 80 insertions(+), 75 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 72f9c5c7e2..9d2c72f5b4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1015,21 +1015,91 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
-int write_commit_graph(const char *obj_dir,
-		       struct string_list *pack_indexes,
-		       struct string_list *commit_hex,
-		       unsigned int flags)
+static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 {
-	struct write_commit_graph_context *ctx;
+	uint32_t i;
 	struct hashfile *f;
-	uint32_t i, count_distinct = 0;
-	char *graph_name = NULL;
 	struct lock_file lk = LOCK_INIT;
 	uint32_t chunk_ids[5];
 	uint64_t chunk_offsets[5];
-	int num_chunks;
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
+	int num_chunks = ctx->num_extra_edges ? 4 : 3;
+
+	ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
+	if (safe_create_leading_directories(ctx->graph_name)) {
+		UNLEAK(ctx->graph_name);
+		error(_("unable to create leading directories of %s"),
+			ctx->graph_name);
+		return -1;
+	}
+
+	hold_lock_file_for_update(&lk, ctx->graph_name, LOCK_DIE_ON_ERROR);
+	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
+
+	hashwrite_be32(f, GRAPH_SIGNATURE);
+
+	hashwrite_u8(f, GRAPH_VERSION);
+	hashwrite_u8(f, oid_version());
+	hashwrite_u8(f, num_chunks);
+	hashwrite_u8(f, 0); /* unused padding byte */
+
+	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
+	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
+	chunk_ids[2] = GRAPH_CHUNKID_DATA;
+	if (ctx->num_extra_edges)
+		chunk_ids[3] = GRAPH_CHUNKID_EXTRAEDGES;
+	else
+		chunk_ids[3] = 0;
+	chunk_ids[4] = 0;
+
+	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
+	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
+	chunk_offsets[2] = chunk_offsets[1] + hashsz * ctx->commits.nr;
+	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * ctx->commits.nr;
+	chunk_offsets[4] = chunk_offsets[3] + 4 * ctx->num_extra_edges;
+
+	for (i = 0; i <= num_chunks; i++) {
+		uint32_t chunk_write[3];
+
+		chunk_write[0] = htonl(chunk_ids[i]);
+		chunk_write[1] = htonl(chunk_offsets[i] >> 32);
+		chunk_write[2] = htonl(chunk_offsets[i] & 0xffffffff);
+		hashwrite(f, chunk_write, 12);
+	}
+
+	if (ctx->report_progress) {
+		strbuf_addf(&progress_title,
+			    Q_("Writing out commit graph in %d pass",
+			       "Writing out commit graph in %d passes",
+			       num_chunks),
+			    num_chunks);
+		ctx->progress = start_delayed_progress(
+			progress_title.buf,
+			num_chunks * ctx->commits.nr);
+	}
+	write_graph_chunk_fanout(f, ctx);
+	write_graph_chunk_oids(f, hashsz, ctx);
+	write_graph_chunk_data(f, hashsz, ctx);
+	if (ctx->num_extra_edges)
+		write_graph_chunk_extra_edges(f, ctx);
+	stop_progress(&ctx->progress);
+	strbuf_release(&progress_title);
+
+	close_commit_graph(ctx->r);
+	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+	commit_lock_file(&lk);
+
+	return 0;
+}
+
+int write_commit_graph(const char *obj_dir,
+		       struct string_list *pack_indexes,
+		       struct string_list *commit_hex,
+		       unsigned int flags)
+{
+	struct write_commit_graph_context *ctx;
+	uint32_t i, count_distinct = 0;
 	int res = 0;
 
 	if (!commit_graph_compatible(the_repository))
@@ -1096,75 +1166,10 @@ int write_commit_graph(const char *obj_dir,
 
 	compute_generation_numbers(ctx);
 
-	num_chunks = ctx->num_extra_edges ? 4 : 3;
-
-	ctx->graph_name = get_commit_graph_filename(ctx->obj_dir);
-	if (safe_create_leading_directories(ctx->graph_name)) {
-		UNLEAK(ctx->graph_name);
-		error(_("unable to create leading directories of %s"),
-			ctx->graph_name);
-		res = -1;
-		goto cleanup;
-	}
-
-	hold_lock_file_for_update(&lk, ctx->graph_name, LOCK_DIE_ON_ERROR);
-	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
-
-	hashwrite_be32(f, GRAPH_SIGNATURE);
-
-	hashwrite_u8(f, GRAPH_VERSION);
-	hashwrite_u8(f, oid_version());
-	hashwrite_u8(f, num_chunks);
-	hashwrite_u8(f, 0); /* unused padding byte */
-
-	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
-	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
-	chunk_ids[2] = GRAPH_CHUNKID_DATA;
-	if (ctx->num_extra_edges)
-		chunk_ids[3] = GRAPH_CHUNKID_EXTRAEDGES;
-	else
-		chunk_ids[3] = 0;
-	chunk_ids[4] = 0;
-
-	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
-	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
-	chunk_offsets[2] = chunk_offsets[1] + hashsz * ctx->commits.nr;
-	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * ctx->commits.nr;
-	chunk_offsets[4] = chunk_offsets[3] + 4 * ctx->num_extra_edges;
-
-	for (i = 0; i <= num_chunks; i++) {
-		uint32_t chunk_write[3];
-
-		chunk_write[0] = htonl(chunk_ids[i]);
-		chunk_write[1] = htonl(chunk_offsets[i] >> 32);
-		chunk_write[2] = htonl(chunk_offsets[i] & 0xffffffff);
-		hashwrite(f, chunk_write, 12);
-	}
-
-	if (ctx->report_progress) {
-		strbuf_addf(&progress_title,
-			    Q_("Writing out commit graph in %d pass",
-			       "Writing out commit graph in %d passes",
-			       num_chunks),
-			    num_chunks);
-		ctx->progress = start_delayed_progress(
-			progress_title.buf,
-			num_chunks * ctx->commits.nr);
-	}
-	write_graph_chunk_fanout(f, ctx);
-	write_graph_chunk_oids(f, hashsz, ctx);
-	write_graph_chunk_data(f, hashsz, ctx);
-	if (ctx->num_extra_edges)
-		write_graph_chunk_extra_edges(f, ctx);
-	stop_progress(&ctx->progress);
-	strbuf_release(&progress_title);
-
-	close_commit_graph(ctx->r);
-	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
-	commit_lock_file(&lk);
+	res = write_commit_graph_file(ctx);
 
 cleanup:
-	free(graph_name);
+	free(ctx->graph_name);
 	free(ctx->commits.list);
 	free(ctx->oids.list);
 	free(ctx);
-- 
gitgitgadget
