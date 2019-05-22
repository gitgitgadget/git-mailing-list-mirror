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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA081F462
	for <e@80x24.org>; Wed, 22 May 2019 19:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbfEVTx2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 15:53:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46185 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731902AbfEVTx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 15:53:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id f37so5442248edb.13
        for <git@vger.kernel.org>; Wed, 22 May 2019 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jL00gtXMpf6ZHXcGetecML4+Wa/xge3YswvQS6i+nxU=;
        b=aCkKwlKhxgJvS4R4s1zcSZWIdbRE8eg+A4UbsjYN2OBCFYWCgz5IefObWJOa79T7Mf
         rtOBtGv7jqZwz1FTic6UyrvVWgrIH3oikMJc7Eba90cr7WRpiXqFDybLVAwPMtZs1hIq
         I76rFn8uEQUvJjVCrfWZT+ublPcTpMz6fjMr4RRZfmRLErdbJDais14aGLxk/32NB+jI
         PrtU65K/cP1v9/7JmhQk4fgwOW1t4rAP+Jb2eyo/rcmALGFiOmQh/xUYTzKR/LiyeIrU
         LjtADD3xkmUXEemD3MCfZrVAVYHxlhdbud/KVA17AnSYKryfktzYVMot3UZZj9WVvlvC
         598g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jL00gtXMpf6ZHXcGetecML4+Wa/xge3YswvQS6i+nxU=;
        b=CmrYByWYdE4tFmq5hXrb44/H+wYRMP4utOFi9LmfhtvsZUi0X+D4MteKm/2KmhyPWM
         zzTLK1lHNG0vD/VK9/tzNBZlQOoLV7H7ONSu0QYirN/x4C/nVyXA6iE96JSccb6lI4Qk
         E5bKDDRTQW8RX5oXlkZrU61zgfW9/PFX4zZKxTNwwG0Mjh3z4aCCjM4xjY5T8RJaFllI
         09uudwd5F3dzgWiUnAxTKLTrBOOd/4q0HNuN9nTRpBEGSugOl8czrXtIBqRpPz1AssfX
         rSohYZgfSifYzscnJUUuxjKbmCRQI9lPkTHk0P2mKHmN71wU+L7By2gP573/x4uqsnDs
         XMEQ==
X-Gm-Message-State: APjAAAUg9+wfBXX4gAlrMqSYvSCK6WIOnTcLu+owxbyWncmIT3mlLjlN
        wino5WInD9NOFqn3hnFIof/ODVUg
X-Google-Smtp-Source: APXvYqz6cMALi6iP3W+HXxQvocRSIO/VoQf/480MTcegWkzmXBt3Rd/f+i6GeY7XZguJukImLfMf3Q==
X-Received: by 2002:a17:906:3586:: with SMTP id o6mr53542928ejb.253.1558554805420;
        Wed, 22 May 2019 12:53:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h44sm7268248eda.3.2019.05.22.12.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 12:53:25 -0700 (PDT)
Date:   Wed, 22 May 2019 12:53:25 -0700 (PDT)
X-Google-Original-Date: Wed, 22 May 2019 19:53:13 GMT
Message-Id: <a8c0b47c8af44e2216e4a9462b384424ce94a2c9.1558554800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v2.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
        <pull.184.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 04/11] commit-graph: load commit-graph chains
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

Prepare the logic for reading a chain of commit-graphs.

First, look for a file at $OBJDIR/info/commit-graph. If it exists,
then use that file and stop.

Next, look for the chain file at $OBJDIR/info/commit-graphs/commit-graph-chain.
If this file exists, then load the hash values as line-separated values in that
file and load $OBJDIR/info/commit-graphs/graph-{hash[i]}.graph for each hash[i]
in that file. The file is given in order, so the first hash corresponds to the
"base" file and the final hash corresponds to the "tip" file.

This implementation assumes that all of the graph-{hash}.graph files are in
the same object directory as the commit-graph-chain file. This will be updated
in a future change. This change is purposefully simple so we can isolate the
different concerns.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 93 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e2f438f6a3..70e44393b8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -45,6 +45,19 @@ char *get_commit_graph_filename(const char *obj_dir)
 	return xstrfmt("%s/info/commit-graph", obj_dir);
 }
 
+static char *get_split_graph_filename(const char *obj_dir,
+				      const char *oid_hex)
+{
+	return xstrfmt("%s/info/commit-graphs/graph-%s.graph",
+		       obj_dir,
+		       oid_hex);
+}
+
+static char *get_chain_filename(const char *obj_dir)
+{
+	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", obj_dir);
+}
+
 static uint8_t oid_version(void)
 {
 	return 1;
@@ -286,18 +299,93 @@ static struct commit_graph *load_commit_graph_one(const char *graph_file)
 	return load_commit_graph_one_fd_st(fd, &st);
 }
 
+static int prepare_commit_graph_v1(struct repository *r, const char *obj_dir)
+{
+	char *graph_name = get_commit_graph_filename(obj_dir);
+	r->objects->commit_graph = load_commit_graph_one(graph_name);
+	free(graph_name);
+
+	return r->objects->commit_graph ? 0 : -1;
+}
+
+static int add_graph_to_chain(struct commit_graph *g,
+			      struct commit_graph *chain,
+			      struct object_id *oids,
+			      int n)
+{
+	struct commit_graph *cur_g = chain;
+
+	while (n) {
+		n--;
+		cur_g = cur_g->base_graph;
+	}
+
+	g->base_graph = chain;
+
+	if (chain)
+		g->num_commits_in_base = chain->num_commits + chain->num_commits_in_base;
+
+	return 1;
+}
+
+static void prepare_commit_graph_chain(struct repository *r, const char *obj_dir)
+{
+	struct strbuf line = STRBUF_INIT;
+	struct stat st;
+	struct object_id *oids;
+	int i = 0, valid = 1;
+	char *chain_name = get_chain_filename(obj_dir);
+	FILE *fp;
+
+	if (stat(chain_name, &st))
+		return;
+
+	if (st.st_size <= the_hash_algo->hexsz)
+		return;
+
+	fp = fopen(chain_name, "r");
+	free(chain_name);
+
+	if (!fp)
+		return;
+
+	oids = xcalloc(st.st_size / (the_hash_algo->hexsz + 1), sizeof(struct object_id));
+
+	while (strbuf_getline_lf(&line, fp) != EOF && valid) {
+		char *graph_name;
+		struct commit_graph *g;
+
+		if (get_oid_hex(line.buf, &oids[i])) {
+			warning(_("invalid commit-graph chain: line '%s' not a hash"),
+				line.buf);
+			valid = 0;
+			break;
+		}
+
+		graph_name = get_split_graph_filename(obj_dir, line.buf);
+		g = load_commit_graph_one(graph_name);
+		free(graph_name);
+
+		if (g && add_graph_to_chain(g, r->objects->commit_graph, oids, i))
+			r->objects->commit_graph = g;
+		else
+			valid = 0;
+	}
+
+	free(oids);
+	fclose(fp);
+}
+
 static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
 {
-	char *graph_name;
 
 	if (r->objects->commit_graph)
 		return;
 
-	graph_name = get_commit_graph_filename(obj_dir);
-	r->objects->commit_graph =
-		load_commit_graph_one(graph_name);
+	if (!prepare_commit_graph_v1(r, obj_dir))
+		return;
 
-	FREE_AND_NULL(graph_name);
+	prepare_commit_graph_chain(r, obj_dir);
 }
 
 /*
-- 
gitgitgadget

