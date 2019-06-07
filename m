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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A27C1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 18:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbfFGSie (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 14:38:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41641 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbfFGSi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 14:38:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id p15so4330129eds.8
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wCy1+3watJ0Zb8uiXyaX4Lcd6sQRCqMcaFtraIfiO8k=;
        b=tJCpS3yZ0Rhr3SUflaurbx0/xdzSmZ8Id5yBvBWcN0d6BrAp1X2Er3Qck5befoEqP3
         X76u3Fmm34ciQI3LUMtIbKXPDyUBPn3R7DPaILhD8cJSz8dxyDV1U4okjnulnTns2FyR
         q+qQAeRBd8Q5Kq4pOy5lk+zHr86g7Ivlv6Ncxxt/XNQqs20x4ES0CtH1Xw/Qk+8dNt3J
         avKTe9Wscc9Oub4tPsH/k6mkdAez9ZVGQ64n6QmLiPy39bdfwPfj4dzSAlivn4XMXtsz
         BEA1vvlUgfyNmKv86uLEgqVbUBxFFxPWuXNuOYQ/JsAK0fEC1upn6g4Kng2KFJZ01cfC
         s/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wCy1+3watJ0Zb8uiXyaX4Lcd6sQRCqMcaFtraIfiO8k=;
        b=Q1PvlGkk8HltbxXyorLlozKBJ2pLz50BuGDEULttu3WXL0TgAJCL0Jss++QrYJsSMq
         ktaMiGezcSGQOmd+1OvcdeaeWkD6W4/IYIEEU7532SPz7OnIFI0RIreCMChCe7thicrS
         lWAbF82NibfpL2XTMZO9gKJrhbxRJ/bs2gQQv1sNHfXCWEaE+OC/GQDqm8kQAy8Y5kcI
         bwB+UW2bW+ShzjyAfDfxHM8TBJL0xIgHMKWTMOtFiHsLXNy7El1IZZIPG3VQGL9B5JaT
         6rTdvUeJcAc3eoN2WFK9k6QYGo6P2LBD+eh6t7TCLLpGxlBo2AvhNOKpzPYOp60PExSP
         AsrA==
X-Gm-Message-State: APjAAAVQq0opcnVbxxM7HfrPw/p+iydiztSxkbUaWJePBwm22dzKnDds
        16ymZzzGm2W6bwH7CC/qU4SmHsjc
X-Google-Smtp-Source: APXvYqxUh+wklyRGCw2yTAlKucSwMDJW6+5I1nZHxql57nSJ4k3RoSbBsMWY+FJP4Uxb9gsVsfc91g==
X-Received: by 2002:a50:b7f8:: with SMTP id i53mr59868187ede.196.1559932704214;
        Fri, 07 Jun 2019 11:38:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8sm497129ejl.46.2019.06.07.11.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:38:23 -0700 (PDT)
Date:   Fri, 07 Jun 2019 11:38:23 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jun 2019 18:38:07 GMT
Message-Id: <fc3423046b9b2fc43bf8323dd41281f0a29b9d0a.1559932699.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v5.git.gitgitgadget@gmail.com>
References: <pull.184.v4.git.gitgitgadget@gmail.com>
        <pull.184.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 04/16] commit-graph: load commit-graph chains
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
 commit-graph.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 106 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 70d5889892..263c73282e 100644
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
@@ -286,18 +299,105 @@ static struct commit_graph *load_commit_graph_one(const char *graph_file)
 	return load_commit_graph_one_fd_st(fd, &st);
 }
 
+static struct commit_graph *load_commit_graph_v1(struct repository *r, const char *obj_dir)
+{
+	char *graph_name = get_commit_graph_filename(obj_dir);
+	struct commit_graph *g = load_commit_graph_one(graph_name);
+	free(graph_name);
+
+	return g;
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
+static struct commit_graph *load_commit_graph_chain(struct repository *r, const char *obj_dir)
+{
+	struct commit_graph *graph_chain = NULL;
+	struct strbuf line = STRBUF_INIT;
+	struct stat st;
+	struct object_id *oids;
+	int i = 0, valid = 1, count;
+	char *chain_name = get_chain_filename(obj_dir);
+	FILE *fp;
+	int stat_res;
+
+	fp = fopen(chain_name, "r");
+	stat_res = stat(chain_name, &st);
+	free(chain_name);
+
+	if (!fp ||
+	    stat_res ||
+	    st.st_size <= the_hash_algo->hexsz)
+		return NULL;
+
+	count = st.st_size / (the_hash_algo->hexsz + 1);
+	oids = xcalloc(count, sizeof(struct object_id));
+
+	for (i = 0; i < count && valid; i++) {
+		char *graph_name;
+		struct commit_graph *g;
+
+		if (strbuf_getline_lf(&line, fp) == EOF)
+			break;
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
+		if (g && add_graph_to_chain(g, graph_chain, oids, i))
+			graph_chain = g;
+		else
+			valid = 0;
+	}
+
+	free(oids);
+	fclose(fp);
+
+	return graph_chain;
+}
+
+static struct commit_graph *read_commit_graph_one(struct repository *r, const char *obj_dir)
+{
+	struct commit_graph *g = load_commit_graph_v1(r, obj_dir);
+
+	if (!g)
+		g = load_commit_graph_chain(r, obj_dir);
+
+	return g;
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
-
-	FREE_AND_NULL(graph_name);
+	r->objects->commit_graph = read_commit_graph_one(r, obj_dir);
 }
 
 /*
-- 
gitgitgadget

