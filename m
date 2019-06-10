Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E11C1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 23:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390657AbfFJXfa (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 19:35:30 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:38959 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390594AbfFJXf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 19:35:27 -0400
Received: by mail-ed1-f42.google.com with SMTP id m10so16979446edv.6
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mpfvp3LXyDFKA7YbepC/UoBn52fHXiFcGXN1OG04X44=;
        b=VllqpntLWwlx+TeEtBeHv8h9GbKYHwXiKBXcO2xQ6dwASimpSmH+iupoFpmFGMye0j
         abVFTbF3FCmIC8bU/k+e790wdkRB44yOeocLvTEj97nx5sBql0fM2oQU4QfK9gO7PfHF
         RGWFY4Sx+ctnmW5Y3SRtkibcjrNUW2wqPfxGWlIMzjTSpNdIlZOzk+vod0AC1lNSPeRY
         F5mNG3SIA4lXCuwQynlCCUGt+NccmP7JOFbwcEriXmr+qvue226swbJccvyB8M6IYLNs
         gwPWyoYg+ss2mJM7GMaF/X0LlqJRoepFAqyrqiPvHAXdwxDjmI4Qvd9PZ/HmcWS1j+zB
         usZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mpfvp3LXyDFKA7YbepC/UoBn52fHXiFcGXN1OG04X44=;
        b=WG+vmN9Z59/v4TtPrcUoz/AlC5A8kHaI7NrnQZWDp8oX8j/W1KQgr9lBzvG9i46tQe
         BRX+FWzN3a5Z8oJ4L9nM2tsdUkQR/M4FzXfjorqnHqPiqjEDzLcMB1xwgqBxZFD5EqWA
         KV0MROy6vk5v8f3+Rr8WPYvCVMuPZ4lPYZ56n7vftNA1tJL0FOtYNh2Mgp+hYjGUkJDW
         geyfUo3+1M4/9oltfqpFRFxiK+gETEholxuwBqzOEF1yOlc041xCeuG2pjs/+/mZGTu0
         DwM3AK2afFDA49QNe9vX/3qRXct6sjtQliB2TRZP6XcnAM8CwHE1+Vsc3a9/jx5mFNsH
         2bbQ==
X-Gm-Message-State: APjAAAUCenqla+ENVGhAojUQPrLACZaLD0SWJU/OJ+pmgIO0n/rEzlfB
        0SmGnVMoSLaxkXa6GQ8g74EGlR6u
X-Google-Smtp-Source: APXvYqwLjNVW3YgUnB0E/BrJPZVvz40pSCFdblSMR008PkQbxb/ZEwdGKrqPpzXFwDX23R0au/DCGw==
X-Received: by 2002:a50:cac3:: with SMTP id f3mr75554272edi.91.1560209725156;
        Mon, 10 Jun 2019 16:35:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z49sm1428670edz.61.2019.06.10.16.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 16:35:24 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:35:24 -0700 (PDT)
X-Google-Original-Date: Mon, 10 Jun 2019 23:35:14 GMT
Message-Id: <989d49d0b284980fc1b46bd8c309448ff538fd78.1560209720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.261.git.gitgitgadget@gmail.com>
References: <pull.261.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 05/11] midx: refactor permutation logic and pack sorting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In anticipation of the expire subcommand, refactor the way we sort
the packfiles by name. This will greatly simplify our approach to
dropping expired packs from the list.

First, create 'struct pack_info' to replace 'struct pack_pair'.
This struct contains the necessary information about a pack,
including its name, a pointer to its packfile struct (if not
already in the multi-pack-index), and the original pack-int-id.

Second, track the pack information using an array of pack_info
structs in the pack_list struct. This simplifies the logic around
the multiple arrays we were tracking in that struct.

Finally, update get_sorted_entries() to not permute the pack-int-id
and instead supply the permutation to write_midx_object_offsets().
This requires sorting the packs after get_sorted_entries().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 156 +++++++++++++++++++++++++--------------------------------
 1 file changed, 69 insertions(+), 87 deletions(-)

diff --git a/midx.c b/midx.c
index 62404620ad..6d4b84e243 100644
--- a/midx.c
+++ b/midx.c
@@ -427,12 +427,23 @@ static size_t write_midx_header(struct hashfile *f,
 	return MIDX_HEADER_SIZE;
 }
 
+struct pack_info {
+	uint32_t orig_pack_int_id;
+	char *pack_name;
+	struct packed_git *p;
+};
+
+static int pack_info_compare(const void *_a, const void *_b)
+{
+	struct pack_info *a = (struct pack_info *)_a;
+	struct pack_info *b = (struct pack_info *)_b;
+	return strcmp(a->pack_name, b->pack_name);
+}
+
 struct pack_list {
-	struct packed_git **list;
-	char **names;
+	struct pack_info *info;
 	uint32_t nr;
-	uint32_t alloc_list;
-	uint32_t alloc_names;
+	uint32_t alloc;
 	struct multi_pack_index *m;
 };
 
@@ -445,66 +456,32 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 		if (packs->m && midx_contains_pack(packs->m, file_name))
 			return;
 
-		ALLOC_GROW(packs->list, packs->nr + 1, packs->alloc_list);
-		ALLOC_GROW(packs->names, packs->nr + 1, packs->alloc_names);
+		ALLOC_GROW(packs->info, packs->nr + 1, packs->alloc);
 
-		packs->list[packs->nr] = add_packed_git(full_path,
-							full_path_len,
-							0);
+		packs->info[packs->nr].p = add_packed_git(full_path,
+							  full_path_len,
+							  0);
 
-		if (!packs->list[packs->nr]) {
+		if (!packs->info[packs->nr].p) {
 			warning(_("failed to add packfile '%s'"),
 				full_path);
 			return;
 		}
 
-		if (open_pack_index(packs->list[packs->nr])) {
+		if (open_pack_index(packs->info[packs->nr].p)) {
 			warning(_("failed to open pack-index '%s'"),
 				full_path);
-			close_pack(packs->list[packs->nr]);
-			FREE_AND_NULL(packs->list[packs->nr]);
+			close_pack(packs->info[packs->nr].p);
+			FREE_AND_NULL(packs->info[packs->nr].p);
 			return;
 		}
 
-		packs->names[packs->nr] = xstrdup(file_name);
+		packs->info[packs->nr].pack_name = xstrdup(file_name);
+		packs->info[packs->nr].orig_pack_int_id = packs->nr;
 		packs->nr++;
 	}
 }
 
-struct pack_pair {
-	uint32_t pack_int_id;
-	char *pack_name;
-};
-
-static int pack_pair_compare(const void *_a, const void *_b)
-{
-	struct pack_pair *a = (struct pack_pair *)_a;
-	struct pack_pair *b = (struct pack_pair *)_b;
-	return strcmp(a->pack_name, b->pack_name);
-}
-
-static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *perm)
-{
-	uint32_t i;
-	struct pack_pair *pairs;
-
-	ALLOC_ARRAY(pairs, nr_packs);
-
-	for (i = 0; i < nr_packs; i++) {
-		pairs[i].pack_int_id = i;
-		pairs[i].pack_name = pack_names[i];
-	}
-
-	QSORT(pairs, nr_packs, pack_pair_compare);
-
-	for (i = 0; i < nr_packs; i++) {
-		pack_names[i] = pairs[i].pack_name;
-		perm[pairs[i].pack_int_id] = i;
-	}
-
-	free(pairs);
-}
-
 struct pack_midx_entry {
 	struct object_id oid;
 	uint32_t pack_int_id;
@@ -530,7 +507,6 @@ static int midx_oid_compare(const void *_a, const void *_b)
 }
 
 static int nth_midxed_pack_midx_entry(struct multi_pack_index *m,
-				      uint32_t *pack_perm,
 				      struct pack_midx_entry *e,
 				      uint32_t pos)
 {
@@ -538,7 +514,7 @@ static int nth_midxed_pack_midx_entry(struct multi_pack_index *m,
 		return 1;
 
 	nth_midxed_object_oid(&e->oid, m, pos);
-	e->pack_int_id = pack_perm[nth_midxed_pack_int_id(m, pos)];
+	e->pack_int_id = nth_midxed_pack_int_id(m, pos);
 	e->offset = nth_midxed_offset(m, pos);
 
 	/* consider objects in midx to be from "old" packs */
@@ -572,8 +548,7 @@ static void fill_pack_entry(uint32_t pack_int_id,
  * of a packfile containing the object).
  */
 static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
-						  struct packed_git **p,
-						  uint32_t *perm,
+						  struct pack_info *info,
 						  uint32_t nr_packs,
 						  uint32_t *nr_objects)
 {
@@ -584,7 +559,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 	uint32_t start_pack = m ? m->num_packs : 0;
 
 	for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++)
-		total_objects += p[cur_pack]->num_objects;
+		total_objects += info[cur_pack].p->num_objects;
 
 	/*
 	 * As we de-duplicate by fanout value, we expect the fanout
@@ -609,7 +584,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 
 			for (cur_object = start; cur_object < end; cur_object++) {
 				ALLOC_GROW(entries_by_fanout, nr_fanout + 1, alloc_fanout);
-				nth_midxed_pack_midx_entry(m, perm,
+				nth_midxed_pack_midx_entry(m,
 							   &entries_by_fanout[nr_fanout],
 							   cur_object);
 				nr_fanout++;
@@ -620,12 +595,12 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 			uint32_t start = 0, end;
 
 			if (cur_fanout)
-				start = get_pack_fanout(p[cur_pack], cur_fanout - 1);
-			end = get_pack_fanout(p[cur_pack], cur_fanout);
+				start = get_pack_fanout(info[cur_pack].p, cur_fanout - 1);
+			end = get_pack_fanout(info[cur_pack].p, cur_fanout);
 
 			for (cur_object = start; cur_object < end; cur_object++) {
 				ALLOC_GROW(entries_by_fanout, nr_fanout + 1, alloc_fanout);
-				fill_pack_entry(perm[cur_pack], p[cur_pack], cur_object, &entries_by_fanout[nr_fanout]);
+				fill_pack_entry(cur_pack, info[cur_pack].p, cur_object, &entries_by_fanout[nr_fanout]);
 				nr_fanout++;
 			}
 		}
@@ -654,7 +629,7 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 }
 
 static size_t write_midx_pack_names(struct hashfile *f,
-				    char **pack_names,
+				    struct pack_info *info,
 				    uint32_t num_packs)
 {
 	uint32_t i;
@@ -662,14 +637,14 @@ static size_t write_midx_pack_names(struct hashfile *f,
 	size_t written = 0;
 
 	for (i = 0; i < num_packs; i++) {
-		size_t writelen = strlen(pack_names[i]) + 1;
+		size_t writelen = strlen(info[i].pack_name) + 1;
 
-		if (i && strcmp(pack_names[i], pack_names[i - 1]) <= 0)
+		if (i && strcmp(info[i].pack_name, info[i - 1].pack_name) <= 0)
 			BUG("incorrect pack-file order: %s before %s",
-			    pack_names[i - 1],
-			    pack_names[i]);
+			    info[i - 1].pack_name,
+			    info[i].pack_name);
 
-		hashwrite(f, pack_names[i], writelen);
+		hashwrite(f, info[i].pack_name, writelen);
 		written += writelen;
 	}
 
@@ -740,6 +715,7 @@ static size_t write_midx_oid_lookup(struct hashfile *f, unsigned char hash_len,
 }
 
 static size_t write_midx_object_offsets(struct hashfile *f, int large_offset_needed,
+					uint32_t *perm,
 					struct pack_midx_entry *objects, uint32_t nr_objects)
 {
 	struct pack_midx_entry *list = objects;
@@ -749,7 +725,7 @@ static size_t write_midx_object_offsets(struct hashfile *f, int large_offset_nee
 	for (i = 0; i < nr_objects; i++) {
 		struct pack_midx_entry *obj = list++;
 
-		hashwrite_be32(f, obj->pack_int_id);
+		hashwrite_be32(f, perm[obj->pack_int_id]);
 
 		if (large_offset_needed && obj->offset >> 31)
 			hashwrite_be32(f, MIDX_LARGE_OFFSET_NEEDED | nr_large_offset++);
@@ -822,20 +798,17 @@ int write_midx_file(const char *object_dir)
 	packs.m = load_multi_pack_index(object_dir, 1);
 
 	packs.nr = 0;
-	packs.alloc_list = packs.m ? packs.m->num_packs : 16;
-	packs.alloc_names = packs.alloc_list;
-	packs.list = NULL;
-	packs.names = NULL;
-	ALLOC_ARRAY(packs.list, packs.alloc_list);
-	ALLOC_ARRAY(packs.names, packs.alloc_names);
+	packs.alloc = packs.m ? packs.m->num_packs : 16;
+	packs.info = NULL;
+	ALLOC_ARRAY(packs.info, packs.alloc);
 
 	if (packs.m) {
 		for (i = 0; i < packs.m->num_packs; i++) {
-			ALLOC_GROW(packs.list, packs.nr + 1, packs.alloc_list);
-			ALLOC_GROW(packs.names, packs.nr + 1, packs.alloc_names);
+			ALLOC_GROW(packs.info, packs.nr + 1, packs.alloc);
 
-			packs.list[packs.nr] = NULL;
-			packs.names[packs.nr] = xstrdup(packs.m->pack_names[i]);
+			packs.info[packs.nr].orig_pack_int_id = i;
+			packs.info[packs.nr].pack_name = xstrdup(packs.m->pack_names[i]);
+			packs.info[packs.nr].p = NULL;
 			packs.nr++;
 		}
 	}
@@ -845,10 +818,7 @@ int write_midx_file(const char *object_dir)
 	if (packs.m && packs.nr == packs.m->num_packs)
 		goto cleanup;
 
-	ALLOC_ARRAY(pack_perm, packs.nr);
-	sort_packs_by_name(packs.names, packs.nr, pack_perm);
-
-	entries = get_sorted_entries(packs.m, packs.list, pack_perm, packs.nr, &nr_entries);
+	entries = get_sorted_entries(packs.m, packs.info, packs.nr, &nr_entries);
 
 	for (i = 0; i < nr_entries; i++) {
 		if (entries[i].offset > 0x7fffffff)
@@ -857,8 +827,21 @@ int write_midx_file(const char *object_dir)
 			large_offsets_needed = 1;
 	}
 
+	QSORT(packs.info, packs.nr, pack_info_compare);
+
+	/*
+	 * pack_perm stores a permutation between pack-int-ids from the
+	 * previous multi-pack-index to the new one we are writing:
+	 *
+	 * pack_perm[old_id] = new_id
+	 */
+	ALLOC_ARRAY(pack_perm, packs.nr);
+	for (i = 0; i < packs.nr; i++) {
+		pack_perm[packs.info[i].orig_pack_int_id] = i;
+	}
+
 	for (i = 0; i < packs.nr; i++)
-		pack_name_concat_len += strlen(packs.names[i]) + 1;
+		pack_name_concat_len += strlen(packs.info[i].pack_name) + 1;
 
 	if (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
 		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
@@ -929,7 +912,7 @@ int write_midx_file(const char *object_dir)
 
 		switch (chunk_ids[i]) {
 			case MIDX_CHUNKID_PACKNAMES:
-				written += write_midx_pack_names(f, packs.names, packs.nr);
+				written += write_midx_pack_names(f, packs.info, packs.nr);
 				break;
 
 			case MIDX_CHUNKID_OIDFANOUT:
@@ -941,7 +924,7 @@ int write_midx_file(const char *object_dir)
 				break;
 
 			case MIDX_CHUNKID_OBJECTOFFSETS:
-				written += write_midx_object_offsets(f, large_offsets_needed, entries, nr_entries);
+				written += write_midx_object_offsets(f, large_offsets_needed, pack_perm, entries, nr_entries);
 				break;
 
 			case MIDX_CHUNKID_LARGEOFFSETS:
@@ -964,15 +947,14 @@ int write_midx_file(const char *object_dir)
 
 cleanup:
 	for (i = 0; i < packs.nr; i++) {
-		if (packs.list[i]) {
-			close_pack(packs.list[i]);
-			free(packs.list[i]);
+		if (packs.info[i].p) {
+			close_pack(packs.info[i].p);
+			free(packs.info[i].p);
 		}
-		free(packs.names[i]);
+		free(packs.info[i].pack_name);
 	}
 
-	free(packs.list);
-	free(packs.names);
+	free(packs.info);
 	free(entries);
 	free(pack_perm);
 	free(midx_name);
-- 
gitgitgadget

