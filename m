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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CEA21F462
	for <e@80x24.org>; Mon,  3 Jun 2019 16:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfFCQD5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 12:03:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54285 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfFCQDz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 12:03:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id g135so8603180wme.4
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 09:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rfp8nug5J7s66mjwvlnu7umexaC3ndHnoxesoCixggY=;
        b=Y8x0tXT0Quj3kRTRRxORx9Cg1XaAqjV3BswtyIAX6xc384E0tUUuXzNUoqqYSRFvPj
         zhn6mSilQ3PbsC0R0VggT2j8/oI1kNOt/DFd6Jo3WJ2JJet6PgwAMt1G9rI30AUyg8kr
         5fMp8cq3L5cTGOBxaWQGiIT38U6sQgBzhavsLrnLzBQz+PSh7lFWEBc7Ztxhi9WvI678
         o4QtXjUSgqIQjCDyxUvl72C6sA9wRYSmriWMWuCy0wTtRrWFpTzuZlLN5cSNtxPHJ/sx
         p0WWXHBOEpwzDvj9h6Hv4nZsqB94IwXR+zb6qUrHcCXMIHjyxa/qxgpG2mfTIbFn16mD
         PAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rfp8nug5J7s66mjwvlnu7umexaC3ndHnoxesoCixggY=;
        b=AlDRjJXcTLkoTstqwLFxc4yjoengbsA+I6jT4RHcFO+ybpHWvKe1dmx50Byz3APtfU
         vw7jvWzc6s3ft1ttLP9doaS7EEGoog9C3KJeBMsMmKtNKiBr2mY6gQovSNejqejmRGS6
         NK1TsHUqTbouhVibMEohzCcmI/SPk+QmWujf8LRUXsJ/sXBTT5FMr8ejyKv6ATrvi7rH
         7NnLI6wQzTPDhKUVilXNvpvZ3jReh8cthKSa+Nqtf4JNExgOLUMbAnFq28p8zE03gsEf
         WkEXmzUoos8k4WkAF/ovGgu+u6PllPJXcQuEP6N8F8iQkxJXyncS19I30/cE8Q9tKRDB
         r3Hw==
X-Gm-Message-State: APjAAAUMHSCFgxqKHE9Kx02JC2aNREhWP7WmtRkvYlQVF0du8XjlLqom
        Ssd4SXtD+sl0AFupqalq3pgnn3c1
X-Google-Smtp-Source: APXvYqzi4QjH0dPs/ldkFAJ/hlUVPtNZBe18iMkXWEu4eMnlpALeJFyNQ+lKmGkg7qaWlcUH1p0DIg==
X-Received: by 2002:a7b:c247:: with SMTP id b7mr5298277wmj.13.1559577833847;
        Mon, 03 Jun 2019 09:03:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm7973714wro.96.2019.06.03.09.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:03:53 -0700 (PDT)
Date:   Mon, 03 Jun 2019 09:03:53 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 16:03:36 GMT
Message-Id: <ca670536dfe08277e953b2ef5f017dc32c1581d5.1559577826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v3.git.gitgitgadget@gmail.com>
References: <pull.184.v2.git.gitgitgadget@gmail.com>
        <pull.184.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 04/14] commit-graph: load commit-graph chains
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
 commit-graph.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 108 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e2f438f6a3..3ed930159e 100644
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
@@ -286,18 +299,107 @@ static struct commit_graph *load_commit_graph_one(const char *graph_file)
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
+	int i = 0, valid = 1;
+	char *chain_name = get_chain_filename(obj_dir);
+	FILE *fp;
+
+	if (stat(chain_name, &st)) {
+		free(chain_name);
+		return NULL;
+	}
+
+	if (st.st_size <= the_hash_algo->hexsz) {
+		free(chain_name);
+		return NULL;
+	}
+
+	fp = fopen(chain_name, "r");
+	free(chain_name);
+
+	if (!fp)
+		return NULL;
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

