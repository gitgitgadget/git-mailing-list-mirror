Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E36E1F453
	for <e@80x24.org>; Wed,  1 May 2019 13:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfEANLU (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 09:11:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41690 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfEANLT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 09:11:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so14888421edd.8
        for <git@vger.kernel.org>; Wed, 01 May 2019 06:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oN+jgBvM5NbKVFPTktJwa7fwF+8nFGBZQbXz7GqU/pM=;
        b=Pvl19eAoOtWtPOvDZw50XcbzbQCGzPpmO2b2Au4nzB0ExyOmE+dP14OwEyP03apww2
         yNbzz2b5P5pG6iNm1lT0EPjTt5Re/v4r4CJH5NoebMPvUGDIq42PPj+CHK0OvJhI9jM9
         N1T/lfGzXLD9VFv2fQ3aYLBPh3H1D08Ci6OBc1d1I22vWbMdqDYX05NPsBJCTc4ElsPp
         CYuvWzccD3rzZSadvvMC6RFRVAQZiBf4gq77lajR82aJVLruyTE1AAPj+UsU8YtvYBJP
         YgkONpCwRQGaCB3zKKczqHq9LnaTYw1Boc4yZBwndZO5HB1+1fKZ55LFms36f7S6MyFq
         tTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oN+jgBvM5NbKVFPTktJwa7fwF+8nFGBZQbXz7GqU/pM=;
        b=oOZxyNtBgpV2Dyw5RXIusv9klmsTFmgWNLHWlF/FAKH8QqLhFrZQALnw0eezX8NzUj
         qAp2dHdJ+Y1j2y0mfXNJCNut8LMQRUzxCHIWRR4aUK00Z80dTYvgIMAWMUGojjKqYHZ3
         iKVW3e6RIafDtaghpn7KRRezjaD6nSex06QmcA4DjnIMHzTJyAvFRZbSYnSkXbmLPld3
         +yjy1wAvdlJCqIXQsVRUgJaZGw/DbWiSYuL4yWeO8yohJF7tFpHNkkJevn/SxxAWHGq9
         JClBKem+jhanL4h0Bt8Swgx83XQZ0RKy58x7TbSD50gjLtpMvtT0XWq6aKOHPsHM+cVq
         V3kQ==
X-Gm-Message-State: APjAAAWQab1QmwZCMbdNQW8wsUzw+aW0OUUwIRtbT4JEWAz/6YiznPbn
        xNfxKHqLTNCkQSrg18+GLxwcBO2J
X-Google-Smtp-Source: APXvYqwAvrYNmFU/ujz2/QbAtZdU5t9inISAb6EYY6726EiGWTaHl7Ca3RNqdQ5QUYICzN0dr9h4Tw==
X-Received: by 2002:a50:8bbd:: with SMTP id m58mr46978280edm.42.1556716277093;
        Wed, 01 May 2019 06:11:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s11sm6736207ejq.59.2019.05.01.06.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 06:11:16 -0700 (PDT)
Date:   Wed, 01 May 2019 06:11:16 -0700 (PDT)
X-Google-Original-Date: Wed, 01 May 2019 13:11:09 GMT
Message-Id: <8446011a43db7482c1858861d516749847555c05.1556716273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v3.git.gitgitgadget@gmail.com>
References: <pull.112.v2.git.gitgitgadget@gmail.com>
        <pull.112.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 3/6] commit-graph: create new version parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In anticipation of a new commit-graph file format version, create
a parameter for the write_commit_graph() and write_commit_graph_reachable()
methods to take a version number.

When the given version is zero, the implementation selects a
default value. Currently, the only valid value is 1.

The file format will change the header information, so place the
existing header logic inside a switch statement with only one case.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit-graph.c |  4 +--
 builtin/commit.c       |  2 +-
 builtin/gc.c           |  3 +-
 commit-graph.c         | 63 +++++++++++++++++++++++++++---------------
 commit-graph.h         |  6 ++--
 5 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 828b1a713f..7d9185dfc2 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -173,7 +173,7 @@ static int graph_write(int argc, const char **argv)
 	read_replace_refs = 0;
 
 	if (opts.reachable)
-		return write_commit_graph_reachable(opts.obj_dir, flags);
+		return write_commit_graph_reachable(opts.obj_dir, flags, 0);
 
 	string_list_init(&lines, 0);
 	if (opts.stdin_packs || opts.stdin_commits) {
@@ -193,7 +193,7 @@ static int graph_write(int argc, const char **argv)
 	result = write_commit_graph(opts.obj_dir,
 				    pack_indexes,
 				    commit_hex,
-				    flags);
+				    flags, 0);
 
 	UNLEAK(lines);
 	return result;
diff --git a/builtin/commit.c b/builtin/commit.c
index b001ef565d..b9ea7222fa 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1670,7 +1670,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		      "not exceeded, and then \"git reset HEAD\" to recover."));
 
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
-	    write_commit_graph_reachable(get_object_directory(), 0))
+	    write_commit_graph_reachable(get_object_directory(), 0, 0))
 		return 1;
 
 	repo_rerere(the_repository, 0);
diff --git a/builtin/gc.c b/builtin/gc.c
index df2573f124..41637242b1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -666,7 +666,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	if (gc_write_commit_graph &&
 	    write_commit_graph_reachable(get_object_directory(),
-					 !quiet && !daemonized ? COMMIT_GRAPH_PROGRESS : 0))
+					 !quiet && !daemonized ? COMMIT_GRAPH_PROGRESS : 0,
+					 0))
 		return 1;
 
 	if (auto_gc && too_many_loose_objects())
diff --git a/commit-graph.c b/commit-graph.c
index 8bbd50658c..b6f09f1be2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -25,9 +25,6 @@
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
-#define GRAPH_VERSION_1 0x1
-#define GRAPH_VERSION GRAPH_VERSION_1
-
 #define GRAPH_EXTRA_EDGES_NEEDED 0x80000000
 #define GRAPH_EDGE_LAST_MASK 0x7fffffff
 #define GRAPH_PARENT_NONE 0x70000000
@@ -173,30 +170,35 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 	}
 
 	graph_version = *(unsigned char*)(data + 4);
-	if (graph_version != GRAPH_VERSION) {
+	if (graph_version != 1) {
 		error(_("commit-graph version %X does not match version %X"),
-		      graph_version, GRAPH_VERSION);
-		return NULL;
-	}
-
-	hash_version = *(unsigned char*)(data + 5);
-	if (hash_version != oid_version()) {
-		error(_("commit-graph hash version %X does not match version %X"),
-		      hash_version, oid_version());
+		      graph_version, 1);
 		return NULL;
 	}
 
 	graph = alloc_commit_graph();
 
+	switch (graph_version) {
+	case 1:
+		hash_version = *(unsigned char*)(data + 5);
+		if (hash_version != oid_version()) {
+			error(_("commit-graph hash version %X does not match version %X"),
+			      hash_version, oid_version());
+			return NULL;
+		}
+
+		graph->num_chunks = *(unsigned char*)(data + 6);
+		chunk_lookup = data + 8;
+		break;
+	}
+
 	graph->hash_len = the_hash_algo->rawsz;
-	graph->num_chunks = *(unsigned char*)(data + 6);
 	graph->graph_fd = fd;
 	graph->data = graph_map;
 	graph->data_len = graph_size;
 
 	last_chunk_id = 0;
 	last_chunk_offset = 8;
-	chunk_lookup = data + 8;
 	for (i = 0; i < graph->num_chunks; i++) {
 		uint32_t chunk_id;
 		uint64_t chunk_offset;
@@ -851,14 +853,15 @@ static int add_ref_to_list(const char *refname,
 	return 0;
 }
 
-int write_commit_graph_reachable(const char *obj_dir, unsigned int flags)
+int write_commit_graph_reachable(const char *obj_dir, unsigned int flags,
+				 unsigned char version)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
 	int result;
 
 	for_each_ref(add_ref_to_list, &list);
 	result = write_commit_graph(obj_dir, NULL, &list,
-				    flags);
+				    flags, version);
 
 	string_list_clear(&list, 0);
 	return result;
@@ -867,7 +870,8 @@ int write_commit_graph_reachable(const char *obj_dir, unsigned int flags)
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
-		       unsigned int flags)
+		       unsigned int flags,
+		       unsigned char version)
 {
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -888,10 +892,19 @@ int write_commit_graph(const char *obj_dir,
 	int res = 0;
 	int append = flags & COMMIT_GRAPH_APPEND;
 	int report_progress = flags & COMMIT_GRAPH_PROGRESS;
+	int header_size = 0;
 
 	if (!commit_graph_compatible(the_repository))
 		return 0;
 
+	if (!version)
+		version = 1;
+	if (version != 1) {
+		error(_("unsupported commit-graph version %d"),
+		      version);
+		return 1;
+	}
+
 	oids.nr = 0;
 	approx_nr_objects = approximate_object_count();
 	oids.alloc = approx_nr_objects / 32;
@@ -1076,10 +1089,16 @@ int write_commit_graph(const char *obj_dir,
 
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
-	hashwrite_u8(f, GRAPH_VERSION);
-	hashwrite_u8(f, oid_version());
-	hashwrite_u8(f, num_chunks);
-	hashwrite_u8(f, 0); /* unused padding byte */
+	hashwrite_u8(f, version);
+
+	switch (version) {
+	case 1:
+		hashwrite_u8(f, oid_version());
+		hashwrite_u8(f, num_chunks);
+		hashwrite_u8(f, 0); /* unused padding byte */
+		header_size = 8;
+		break;
+	}
 
 	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
 	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
@@ -1090,7 +1109,7 @@ int write_commit_graph(const char *obj_dir,
 		chunk_ids[3] = 0;
 	chunk_ids[4] = 0;
 
-	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
+	chunk_offsets[0] = header_size + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
 	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
 	chunk_offsets[2] = chunk_offsets[1] + hashsz * commits.nr;
 	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * commits.nr;
diff --git a/commit-graph.h b/commit-graph.h
index 70f4caf0c7..d64a2cc78c 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -68,11 +68,13 @@ int generation_numbers_enabled(struct repository *r);
 #define COMMIT_GRAPH_APPEND     (1 << 0)
 #define COMMIT_GRAPH_PROGRESS   (1 << 1)
 
-int write_commit_graph_reachable(const char *obj_dir, unsigned int flags);
+int write_commit_graph_reachable(const char *obj_dir, unsigned int flags,
+				 unsigned char version);
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
-		       unsigned int flags);
+		       unsigned int flags,
+		       unsigned char version);
 
 int verify_commit_graph(struct repository *r, struct commit_graph *g);
 
-- 
gitgitgadget

