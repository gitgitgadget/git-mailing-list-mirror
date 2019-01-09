Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7546A211B4
	for <e@80x24.org>; Wed,  9 Jan 2019 15:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732263AbfAIPVW (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 10:21:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36449 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731314AbfAIPVT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 10:21:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so8075184wrp.3
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 07:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y4JQuo5hraFnfImbK9cICExke4bPE3Jx/lxd4u1UETM=;
        b=SjHWPefOcrydl4zkurhuD1oFLdyQAGDJqLWe7pOH/sd+5//tyY5zIQYiwx/o5/6Mwn
         BG9/ARuUDlFPRsKV2rbP0Vyp2Orw/2wCU/CuDOYZ1wT9bQ/VmSWxmplJutSWII29D4oR
         Ixvhu6qdRmoYIibjlKYC9xc8pQErO+Z+i5kxTLTrTKE478ARktNADg/lw0T1UXTOa4h0
         53llWhSJFP6mjQv9hXue5kaIw9kXxZBWWjUkAcN7AgXaq4NwcuiZtq3jX79ztBq4ApP8
         5H+r4Dhh1/Yg0Xuc+uf4dvL4TSs/ofn0ujz5QC1LO/41hJ10PqBPL6FcS0f1ajFq7VZB
         3f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y4JQuo5hraFnfImbK9cICExke4bPE3Jx/lxd4u1UETM=;
        b=UwvPBI3FfoKaSyAu3NLfEr3OXvdYVOYcHYQ6gB8CE1y1k2Jyro2WNmHUQqUSUXQp9v
         WAxFgjSENUp3PUxDmt1wJx9vn60jYbKhcKjX8QeG24sw9sK330F6x+JPtANCTetxsy6O
         hSM1RnAbZgddo38gXyR+pnOcygp1wxPD0lgVUw5DkaxXPcFBbZUdmtlIyg9lyP4GyCGP
         pyHYsPTeDB0w0/8UvXJebbiPh0QhUau0m8RSGt6lEmbzMep/9x99g4e0SWVLQ1YGapls
         eDlv8RYKfU8ka6RkIFN1M34duw0GvfKSYC59YANr7waGGfB1KJ2O/FK17tMharnJWHYG
         CKqw==
X-Gm-Message-State: AJcUukepbid8G5n3lUse/6zkq5eYURzC3yuQ/jRr4Ldx8p84dM+xWETv
        2fgRaXIqtwo5Uf5dw+vhPIvG/gow
X-Google-Smtp-Source: ALg8bN5HHSSqiRJMpcAaWsRHIU1xoQmZtkKF+qZDwlYQjCgU+w1JO0UGStJgcKtURITh42RGxby1Yw==
X-Received: by 2002:adf:91c3:: with SMTP id 61mr5313744wri.324.1547047277350;
        Wed, 09 Jan 2019 07:21:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j124sm7254764wmb.48.2019.01.09.07.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 07:21:16 -0800 (PST)
Date:   Wed, 09 Jan 2019 07:21:16 -0800 (PST)
X-Google-Original-Date: Wed, 09 Jan 2019 15:21:06 GMT
Message-Id: <4dbff40e7ad653d9c5c3b19dd63a345a21a73dbd.1547047269.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v3.git.gitgitgadget@gmail.com>
References: <pull.92.v2.git.gitgitgadget@gmail.com>
        <pull.92.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 6/9] multi-pack-index: implement 'expire' verb
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git multi-pack-index expire' command looks at the existing
mult-pack-index, counts the number of objects referenced in each
pack-file, deletes the pack-fils with no referenced objects, and
rewrites the multi-pack-index to no longer reference those packs.

Refactor the write_midx_file() method to call write_midx_internal()
which now takes an existing 'struct multi_pack_index' and a list
of pack-files to drop (as specified by the names of their pack-
indexes). As we write the new multi-pack-index, we drop those
file names from the list of known pack-files.

The expire_midx_packs() method removes the unreferenced pack-files
after carefully closing the packs to avoid open handles.

Test that a new pack-file that covers the contents of two other
pack-files leads to those pack-files being deleted during the
expire command. Be sure to read the multi-pack-index to ensure
it no longer references those packs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 120 +++++++++++++++++++++++++++++++++---
 t/t5319-multi-pack-index.sh |  18 ++++++
 2 files changed, 128 insertions(+), 10 deletions(-)

diff --git a/midx.c b/midx.c
index 7ae5275c25..6ccbec3f19 100644
--- a/midx.c
+++ b/midx.c
@@ -33,6 +33,8 @@
 #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
 #define MIDX_LARGE_OFFSET_NEEDED 0x80000000
 
+#define PACK_EXPIRED UINT_MAX
+
 static char *get_midx_filename(const char *object_dir)
 {
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
@@ -381,6 +383,7 @@ struct pack_info {
 	uint32_t orig_pack_int_id;
 	char *pack_name;
 	struct packed_git *p;
+	unsigned expired : 1;
 };
 
 static int pack_info_compare(const void *_a, const void *_b)
@@ -428,6 +431,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 
 		packs->info[packs->nr].pack_name = xstrdup(file_name);
 		packs->info[packs->nr].orig_pack_int_id = packs->nr;
+		packs->info[packs->nr].expired = 0;
 		packs->nr++;
 	}
 }
@@ -587,13 +591,17 @@ static size_t write_midx_pack_names(struct hashfile *f,
 	size_t written = 0;
 
 	for (i = 0; i < num_packs; i++) {
-		size_t writelen = strlen(info[i].pack_name) + 1;
+		size_t writelen;
+
+		if (info[i].expired)
+			continue;
 
 		if (i && strcmp(info[i].pack_name, info[i - 1].pack_name) <= 0)
 			BUG("incorrect pack-file order: %s before %s",
 			    info[i - 1].pack_name,
 			    info[i].pack_name);
 
+		writelen = strlen(info[i].pack_name) + 1;
 		hashwrite(f, info[i].pack_name, writelen);
 		written += writelen;
 	}
@@ -675,6 +683,11 @@ static size_t write_midx_object_offsets(struct hashfile *f, int large_offset_nee
 	for (i = 0; i < nr_objects; i++) {
 		struct pack_midx_entry *obj = list++;
 
+		if (perm[obj->pack_int_id] == PACK_EXPIRED)
+			BUG("object %s is in an expired pack with int-id %d",
+			    oid_to_hex(&obj->oid),
+			    obj->pack_int_id);
+
 		hashwrite_be32(f, perm[obj->pack_int_id]);
 
 		if (large_offset_needed && obj->offset >> 31)
@@ -721,7 +734,8 @@ static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_off
 	return written;
 }
 
-int write_midx_file(const char *object_dir)
+static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
+			       struct string_list *packs_to_drop)
 {
 	unsigned char cur_chunk, num_chunks = 0;
 	char *midx_name;
@@ -737,6 +751,8 @@ int write_midx_file(const char *object_dir)
 	struct pack_midx_entry *entries = NULL;
 	int large_offsets_needed = 0;
 	int pack_name_concat_len = 0;
+	int dropped_packs = 0;
+	int result = 0;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -745,7 +761,10 @@ int write_midx_file(const char *object_dir)
 			  midx_name);
 	}
 
-	packs.m = load_multi_pack_index(object_dir, 1);
+	if (m)
+		packs.m = m;
+	else
+		packs.m = load_multi_pack_index(object_dir, 1);
 
 	packs.nr = 0;
 	packs.alloc = packs.m ? packs.m->num_packs : 16;
@@ -759,13 +778,14 @@ int write_midx_file(const char *object_dir)
 			packs.info[packs.nr].orig_pack_int_id = i;
 			packs.info[packs.nr].pack_name = xstrdup(packs.m->pack_names[i]);
 			packs.info[packs.nr].p = NULL;
+			packs.info[packs.nr].expired = 0;
 			packs.nr++;
 		}
 	}
 
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &packs);
 
-	if (packs.m && packs.nr == packs.m->num_packs)
+	if (packs.m && packs.nr == packs.m->num_packs && !packs_to_drop)
 		goto cleanup;
 
 	entries = get_sorted_entries(packs.m, packs.info, packs.nr, &nr_entries);
@@ -779,13 +799,48 @@ int write_midx_file(const char *object_dir)
 
 	QSORT(packs.info, packs.nr, pack_info_compare);
 
+	if (packs_to_drop && packs_to_drop->nr) {
+		int drop_index = 0;
+		int missing_drops = 0;
+
+		for (i = 0; i < packs.nr && drop_index < packs_to_drop->nr; i++) {
+			int cmp = strcmp(packs.info[i].pack_name,
+					 packs_to_drop->items[drop_index].string);
+
+			if (!cmp) {
+				drop_index++;
+				packs.info[i].expired = 1;
+			} else if (cmp > 0) {
+				error(_("did not see pack-file %s to drop"),
+				      packs_to_drop->items[drop_index].string);
+				drop_index++;
+				missing_drops++;
+				i--;
+			} else {
+				packs.info[i].expired = 0;
+			}
+		}
+
+		if (missing_drops) {
+			result = 1;
+			goto cleanup;
+		}
+	}
+
 	ALLOC_ARRAY(pack_perm, packs.nr);
 	for (i = 0; i < packs.nr; i++) {
-		pack_perm[packs.info[i].orig_pack_int_id] = i;
+		if (packs.info[i].expired) {
+			dropped_packs++;
+			pack_perm[packs.info[i].orig_pack_int_id] = PACK_EXPIRED;
+		} else {
+			pack_perm[packs.info[i].orig_pack_int_id] = i - dropped_packs;
+		}
 	}
 
-	for (i = 0; i < packs.nr; i++)
-		pack_name_concat_len += strlen(packs.info[i].pack_name) + 1;
+	for (i = 0; i < packs.nr; i++) {
+		if (!packs.info[i].expired)
+			pack_name_concat_len += strlen(packs.info[i].pack_name) + 1;
+	}
 
 	if (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
 		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
@@ -801,7 +856,7 @@ int write_midx_file(const char *object_dir)
 	cur_chunk = 0;
 	num_chunks = large_offsets_needed ? 5 : 4;
 
-	written = write_midx_header(f, num_chunks, packs.nr);
+	written = write_midx_header(f, num_chunks, packs.nr - dropped_packs);
 
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
 	chunk_offsets[cur_chunk] = written + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
@@ -902,7 +957,12 @@ int write_midx_file(const char *object_dir)
 	free(entries);
 	free(pack_perm);
 	free(midx_name);
-	return 0;
+	return result;
+}
+
+int write_midx_file(const char *object_dir)
+{
+	return write_midx_internal(object_dir, NULL, NULL);
 }
 
 void clear_midx_file(struct repository *r)
@@ -1004,5 +1064,45 @@ int verify_midx_file(const char *object_dir)
 
 int expire_midx_packs(const char *object_dir)
 {
-	return 0;
+	uint32_t i, *count, result = 0;
+	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
+	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+
+	if (!m)
+		return 0;
+
+	count = xcalloc(m->num_packs, sizeof(uint32_t));
+	for (i = 0; i < m->num_objects; i++) {
+		int pack_int_id = nth_midxed_pack_int_id(m, i);
+		count[pack_int_id]++;
+	}
+
+	for (i = 0; i < m->num_packs; i++) {
+		char *pack_name;
+
+		if (count[i])
+			continue;
+
+		if (prepare_midx_pack(m, i))
+			continue;
+
+		if (m->packs[i]->pack_keep)
+			continue;
+
+		pack_name = xstrdup(m->packs[i]->pack_name);
+		close_pack(m->packs[i]);
+		FREE_AND_NULL(m->packs[i]);
+
+		string_list_insert(&packs_to_drop, m->pack_names[i]);
+		unlink_pack_path(pack_name, 0);
+		free(pack_name);
+	}
+
+	free(count);
+
+	if (packs_to_drop.nr)
+		result = write_midx_internal(object_dir, m, &packs_to_drop);
+
+	string_list_clear(&packs_to_drop, 0);
+	return result;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 948effc1ee..f55a60a89c 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -395,4 +395,22 @@ test_expect_success 'expire does not remove any packs' '
 	)
 '
 
+test_expect_success 'expire removes unreferenced packs' '
+	(
+		cd dup &&
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/A
+		^refs/heads/C
+		EOF
+		git multi-pack-index write &&
+		ls .git/objects/pack | grep -v -e pack-[AB] >expect &&
+		git multi-pack-index expire &&
+		ls .git/objects/pack >actual &&
+		test_cmp expect actual &&
+		ls .git/objects/pack/ | grep idx >expect-idx &&
+		test-tool read-midx .git/objects | grep idx >actual-midx &&
+		test_cmp expect-idx actual-midx
+	)
+'
+
 test_done
-- 
gitgitgadget

