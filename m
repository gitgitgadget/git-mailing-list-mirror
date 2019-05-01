Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D16FE1F453
	for <e@80x24.org>; Wed,  1 May 2019 13:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEANLW (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 09:11:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33423 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfEANLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 09:11:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id n17so6239687edb.0
        for <git@vger.kernel.org>; Wed, 01 May 2019 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/TXrDs5Vep7L/oVAhEDD1N8REE03zZ1jPFzq1M2W96Q=;
        b=MYF8DFYz4KbDkk7blxF3RyamGAfar2A2mOswpNf4Db5y6rK84xGBPmT314AAMhpPo9
         2gT3dBzpJC5+s2HuWyx+paLABdJoo1Mwf1LnQAKRsLf3Rk6vlFAh2mRqsDU6imY26KTj
         bxPPoEQvpzPL52T9Fqlkmq+lYJ5mPZkYp0Le6Z9UROBcX6iLVms5wMdA4tp18gvTpIJJ
         E5Qw7mQQo0X7lw5gCn3wpv081sOeHkZM2f4BYZtmslDNEx/LhFx1qX5cF4u3kcoSxwJI
         tf7rZOcqYW4SuGAMLGZFabNS8PIjAbs/8UpWKcFwHexG4fouU5cAxZsiK42ntWQBxzae
         QZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/TXrDs5Vep7L/oVAhEDD1N8REE03zZ1jPFzq1M2W96Q=;
        b=Ij/zpd9RMAy8yMhJkE4KtVR4Ny0ZmkVejG0yGr/09gXO4qLRrAXLjfpET9Bxz6pInL
         Qv4Ts6DqM1/EMel/wvhGXyqlchZfWQPqeV0S4NtQyYpKPqVNk1N8O5X9AOD1HJACTmZ8
         zUgnOwnwWFja92JwKsUYGjiwIcK8bzGP/xLVPI2+Zkf/YpM7Y2DlQmYo4ELeL9ewGPb8
         PZZxSFCcqp/v9YeRrtP34bFMymi23yMu4eEr42qRP18BfxgnaFgKE49n8TlKRnPLkC7J
         XcjRbGqJWMdQ0njAuKXKC9NY1CgwQ8uu0GvRJ8fkNMbTm0JlDJzrKOJLUkyYFIHU2y9C
         m8IQ==
X-Gm-Message-State: APjAAAVkryib5ZDzmybu+GD0PW0ZocPkNmcKa7W2+TcE6CJrJPDV/LTC
        m09y3eKlwNIxD8qNGzPIH6keJQcF
X-Google-Smtp-Source: APXvYqzSbTmu1FwTb5kTHC6JeViGHaSwxDnHTGXrqHetyvKmGCMfNzbkGbN668wendJ0MJsyTfBhtA==
X-Received: by 2002:aa7:db05:: with SMTP id t5mr1156549eds.217.1556716278659;
        Wed, 01 May 2019 06:11:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y46sm58668edd.29.2019.05.01.06.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 06:11:18 -0700 (PDT)
Date:   Wed, 01 May 2019 06:11:18 -0700 (PDT)
X-Google-Original-Date: Wed, 01 May 2019 13:11:11 GMT
Message-Id: <cca8267dfeb382005ae3c5a4935f2281dabf26b4.1556716273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v3.git.gitgitgadget@gmail.com>
References: <pull.112.v2.git.gitgitgadget@gmail.com>
        <pull.112.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 5/6] commit-graph: implement file format version 2
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

The commit-graph file format had some shortcomings which we now
correct:

  1. The hash algorithm was determined by a single byte, instead
     of the 4-byte format identifier.

  2. There was no way to update the reachability index we used.
     We currently only support generation numbers, but that will
     change in the future.

  3. Git did not fail with error if the unused eighth byte was
     non-zero, so we could not use that to indicate an incremental
     file format without breaking compatibility across versions.

The new format modifies the header of the commit-graph to solve
these problems. We use the 4-byte hash format id, freeing up a byte
in our 32-bit alignment to introduce a reachability index version.
We can also fail to read the commit-graph if the eighth byte is
non-zero.

Update the 'git commit-graph read' subcommand to display the new
data, and check this output in the test that explicitly writes a
v2 commit-graph file.

While we converted the existing 'verify' tests to use a version 1
file to avoid recalculating data offsets, add explicit 'verify'
tests on a version 2 file that corrupt the new header values.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .../technical/commit-graph-format.txt         | 26 ++++++-
 builtin/commit-graph.c                        |  5 ++
 commit-graph.c                                | 39 +++++++++-
 t/t5318-commit-graph.sh                       | 73 +++++++++++++++++--
 4 files changed, 134 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index 16452a0504..e367aa94b1 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -31,13 +31,22 @@ and hash type.
 
 All 4-byte numbers are in network order.
 
+There are two versions available, 1 and 2. These currently differ only in
+the header.
+
 HEADER:
 
+All commit-graph files use the first five bytes for the same purpose.
+
   4-byte signature:
       The signature is: {'C', 'G', 'P', 'H'}
 
   1-byte version number:
-      Currently, the only valid version is 1.
+      Currently, the valid version numbers are 1 and 2.
+
+The remainder of the header changes depending on the version.
+
+Version 1:
 
   1-byte Hash Version (1 = SHA-1)
       We infer the hash length (H) from this value.
@@ -47,6 +56,21 @@ HEADER:
   1-byte (reserved for later use)
      Current clients should ignore this value.
 
+Version 2:
+
+  1-byte number (C) of "chunks"
+
+  1-byte reachability index version number:
+      Currently, the only valid number is 1.
+
+  1-byte (reserved for later use)
+      Current clients expect this value to be zero, and will not
+      try to read the commit-graph file if it is non-zero.
+
+  4-byte format identifier for the hash algorithm:
+      If this identifier does not agree with the repository's current
+      hash algorithm, then the client will not read the commit graph.
+
 CHUNK LOOKUP:
 
   (C + 1) * 12 bytes listing the table of contents for the chunks:
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index e766dd076e..7df6688b08 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -117,6 +117,11 @@ static int graph_read(int argc, const char **argv)
 		*(unsigned char*)(graph->data + 5),
 		*(unsigned char*)(graph->data + 6),
 		*(unsigned char*)(graph->data + 7));
+
+	if (*(unsigned char *)(graph->data + 4) == 2)
+		printf("hash algorithm: %X\n",
+		       get_be32(graph->data + 8));
+
 	printf("num_commits: %u\n", graph->num_commits);
 	printf("chunks:");
 
diff --git a/commit-graph.c b/commit-graph.c
index b6f09f1be2..5eebba6a0f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -152,7 +152,8 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 	uint64_t last_chunk_offset;
 	uint32_t last_chunk_id;
 	uint32_t graph_signature;
-	unsigned char graph_version, hash_version;
+	unsigned char graph_version, hash_version, reach_index_version;
+	uint32_t hash_id;
 
 	if (!graph_map)
 		return NULL;
@@ -170,7 +171,7 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 	}
 
 	graph_version = *(unsigned char*)(data + 4);
-	if (graph_version != 1) {
+	if (!graph_version || graph_version > 2) {
 		error(_("commit-graph version %X does not match version %X"),
 		      graph_version, 1);
 		return NULL;
@@ -190,6 +191,30 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 		graph->num_chunks = *(unsigned char*)(data + 6);
 		chunk_lookup = data + 8;
 		break;
+
+	case 2:
+		graph->num_chunks = *(unsigned char *)(data + 5);
+
+		reach_index_version = *(unsigned char *)(data + 6);
+		if (reach_index_version != 1) {
+			error(_("unsupported reachability index version %d"),
+			      reach_index_version);
+			return NULL;
+		}
+
+		if (*(unsigned char*)(data + 7)) {
+			error(_("unsupported value in commit-graph header"));
+			return NULL;
+		}
+
+		hash_id = get_be32(data + 8);
+		if (hash_id != the_hash_algo->format_id) {
+			error(_("commit-graph hash algorithm does not match current algorithm"));
+			return NULL;
+		}
+
+		chunk_lookup = data + 12;
+		break;
 	}
 
 	graph->hash_len = the_hash_algo->rawsz;
@@ -899,7 +924,7 @@ int write_commit_graph(const char *obj_dir,
 
 	if (!version)
 		version = 1;
-	if (version != 1) {
+	if (version <= 0 || version > 2) {
 		error(_("unsupported commit-graph version %d"),
 		      version);
 		return 1;
@@ -1098,6 +1123,14 @@ int write_commit_graph(const char *obj_dir,
 		hashwrite_u8(f, 0); /* unused padding byte */
 		header_size = 8;
 		break;
+
+	case 2:
+		hashwrite_u8(f, num_chunks);
+		hashwrite_u8(f, 1); /* reachability index version */
+		hashwrite_u8(f, 0); /* unused padding byte */
+		hashwrite_be32(f, the_hash_algo->format_id);
+		header_size = 12;
+		break;
 	}
 
 	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4eb5a09ef3..373a6cd0d4 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -33,13 +33,13 @@ test_expect_success 'create commits and repack' '
 	git repack
 '
 
-graph_git_two_modes() {
+graph_git_two_modes () {
 	git -c core.commitGraph=true $1 >output
 	git -c core.commitGraph=false $1 >expect
 	test_cmp expect output
 }
 
-graph_git_behavior() {
+graph_git_behavior () {
 	MSG=$1
 	DIR=$2
 	BRANCH=$3
@@ -56,7 +56,7 @@ graph_git_behavior() {
 
 graph_git_behavior 'no graph' full commits/3 commits/1
 
-graph_read_expect() {
+graph_read_expect () {
 	OPTIONAL=""
 	NUM_CHUNKS=3
 	if test ! -z $2
@@ -320,6 +320,34 @@ test_expect_success 'replace-objects invalidates commit-graph' '
 	)
 '
 
+graph_read_expect_v2 () {
+	OPTIONAL=""
+	NUM_CHUNKS=3
+	if test ! -z $2
+	then
+		OPTIONAL=" $2"
+		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
+	fi	
+	cat >expect <<- EOF
+	header: 43475048 2 $NUM_CHUNKS 1 0
+	hash algorithm: 73686131
+	num_commits: $1
+	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
+	EOF
+	git commit-graph read >output &&
+	test_cmp expect output
+}
+
+test_expect_success 'write v2 graph' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit-graph write --reachable --version=2 &&
+	graph_read_expect_v2 11 extra_edges &&
+	git commit-graph verify
+'
+
+graph_git_behavior 'version 2 graph, commit 8 vs merge 2' full commits/8 merge/2
+graph_git_behavior 'version 2 graph, commit 8 vs merge 2' full commits/8 merge/2
+
 # the verify tests below expect the commit-graph to contain
 # exactly the commits reachable from the commits/8 branch.
 # If the file changes the set of commits in the list, then the
@@ -392,7 +420,7 @@ corrupt_graph_verify() {
 # starting at <zero_pos>, then runs 'git commit-graph verify'
 # and places the output in the file 'err'. Test 'err' for
 # the given string.
-corrupt_graph_and_verify() {
+corrupt_graph_and_verify () {
 	pos=$1
 	data="${2:-\0}"
 	grepstr=$3
@@ -424,10 +452,14 @@ test_expect_success 'detect bad signature' '
 '
 
 test_expect_success 'detect bad version' '
-	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\02" \
+	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\03" \
 		"graph version"
 '
 
+test_expect_success 'detect version 2 with version 1 data' '
+	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\02" \
+		"reachability index version"
+'
 test_expect_success 'detect bad hash version' '
 	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\02" \
 		"hash version"
@@ -532,6 +564,37 @@ test_expect_success 'git fsck (checks commit-graph)' '
 	test_must_fail git fsck
 '
 
+test_expect_success 'rewrite commmit-graph with version 2' '
+	rm -f .git/objects/info/commit-graph &&
+	git commit-graph write --reachable --version=2 &&
+	git commit-graph verify
+'
+
+GRAPH_BYTE_CHUNK_COUNT=5
+GRAPH_BYTE_REACH_INDEX=6
+GRAPH_BYTE_UNUSED=7
+GRAPH_BYTE_HASH=8
+
+test_expect_success 'detect low chunk count (v2)' '
+	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\02" \
+		"missing the .* chunk"
+'
+
+test_expect_success 'detect incorrect reachability index' '
+	corrupt_graph_and_verify $GRAPH_BYTE_REACH_INDEX "\03" \
+		"reachability index version"
+'
+
+test_expect_success 'detect non-zero unused byte' '
+	corrupt_graph_and_verify $GRAPH_BYTE_UNUSED "\01" \
+		"unsupported value"
+'
+
+test_expect_success 'detect bad hash version (v2)' '
+	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\00" \
+		"hash algorithm"
+'
+
 test_expect_success 'setup non-the_repository tests' '
 	rm -rf repo &&
 	git init repo &&
-- 
gitgitgadget

