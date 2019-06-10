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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2427A1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 23:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390687AbfFJXfg (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 19:35:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41800 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390524AbfFJXf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 19:35:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so16951165eds.8
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fuav/+nheF5SqDD8thcZ8OGP+BR7lbC5ETmzvGSjWYA=;
        b=al8WA9Cy4x1KK9Xh89McxwIElefU82S4T7uGy31nfuJchLfFxUU3DIlE4EW5mFHroK
         9z9BkrtHsLVAwIckT+pvBmcC9cpJ4Oun2ewlFuNzSVF39K9/7ADKDLVOw5AGVrXhdz1Z
         0LTZd52qrPrqwDutGz+6nKO5LRDmJLByYwYm+fbp0yyU+O0jx4nd6naEZ4lYeI0URuMH
         5cRlvAKGCGuU2vbrnlkCJ2IqDD7K6bMs+Nt7gOP8M1HrmQ7VIjh+vEnikcdzuGcz2zQB
         +b0+qyxAqTLh+D5G8fZL14WQj+hqv4Qfe3EyjGYsbI2GDGkkxKHR+KGg9FU+e7jDFPsE
         g6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fuav/+nheF5SqDD8thcZ8OGP+BR7lbC5ETmzvGSjWYA=;
        b=ltZrxpB2RGp7VUlskI1yl0mn+7c79OEJ1Dbd1nakvCESqjvsQnXavcA9PuZmfKoNBp
         bH7GBPiOw+E8O01UfShLRO0co031bkarN9ZE/Xa89px0unAe7AbG3EN9nKI4vtOm9FNj
         ItVYs+9S8cTYdjG/TR1MZCoq2PhQUWFVnYVC3JX341G/enq2od524zk0rWq2BvWeuQeY
         NRpSuK1CdNybkE/v0dJ6lgz8I6Suok4FzxVRo0+Ziu3K1zobSKGq/8FBrdR6LlpaTcQi
         HWOAG1u2pnQ1odiOcbtn1muqVWZ6Sa214bU/WMvdNZWc7RcYDAsUSPAb7DPY5nYQ/Pxz
         HMUQ==
X-Gm-Message-State: APjAAAU9Z3Shz6k9Mi5zYuhuwgawDHegYYqzJkbFOIM2MqSDdX5921Jp
        v0FldYDEDjW9gHALPPtvAwVwRdi1
X-Google-Smtp-Source: APXvYqwv+UmP58z6ka+pXHKNwqZ0Xx2r0XbuyHRNNThQB5eJWfXbLTbUfMBGt1A4BImEEBUny4QxeA==
X-Received: by 2002:aa7:cf0c:: with SMTP id a12mr4610765edy.146.1560209726091;
        Mon, 10 Jun 2019 16:35:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l45sm2474613edc.93.2019.06.10.16.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 16:35:25 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:35:25 -0700 (PDT)
X-Google-Original-Date: Mon, 10 Jun 2019 23:35:15 GMT
Message-Id: <8213541052a7d040aad4352ee981c0de01cc6516.1560209720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.261.git.gitgitgadget@gmail.com>
References: <pull.261.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 06/11] multi-pack-index: implement 'expire' subcommand
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

The 'git multi-pack-index expire' subcommand looks at the existing
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
expire subcommand. Be sure to read the multi-pack-index to ensure
it no longer references those packs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 119 +++++++++++++++++++++++++++++++++---
 t/t5319-multi-pack-index.sh |  20 ++++++
 2 files changed, 129 insertions(+), 10 deletions(-)

diff --git a/midx.c b/midx.c
index 6d4b84e243..9b0b4c1520 100644
--- a/midx.c
+++ b/midx.c
@@ -34,6 +34,8 @@
 #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
 #define MIDX_LARGE_OFFSET_NEEDED 0x80000000
 
+#define PACK_EXPIRED UINT_MAX
+
 static char *get_midx_filename(const char *object_dir)
 {
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
@@ -431,6 +433,7 @@ struct pack_info {
 	uint32_t orig_pack_int_id;
 	char *pack_name;
 	struct packed_git *p;
+	unsigned expired : 1;
 };
 
 static int pack_info_compare(const void *_a, const void *_b)
@@ -478,6 +481,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 
 		packs->info[packs->nr].pack_name = xstrdup(file_name);
 		packs->info[packs->nr].orig_pack_int_id = packs->nr;
+		packs->info[packs->nr].expired = 0;
 		packs->nr++;
 	}
 }
@@ -637,13 +641,17 @@ static size_t write_midx_pack_names(struct hashfile *f,
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
@@ -725,6 +733,11 @@ static size_t write_midx_object_offsets(struct hashfile *f, int large_offset_nee
 	for (i = 0; i < nr_objects; i++) {
 		struct pack_midx_entry *obj = list++;
 
+		if (perm[obj->pack_int_id] == PACK_EXPIRED)
+			BUG("object %s is in an expired pack with int-id %d",
+			    oid_to_hex(&obj->oid),
+			    obj->pack_int_id);
+
 		hashwrite_be32(f, perm[obj->pack_int_id]);
 
 		if (large_offset_needed && obj->offset >> 31)
@@ -771,7 +784,8 @@ static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_off
 	return written;
 }
 
-int write_midx_file(const char *object_dir)
+static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
+			       struct string_list *packs_to_drop)
 {
 	unsigned char cur_chunk, num_chunks = 0;
 	char *midx_name;
@@ -787,6 +801,8 @@ int write_midx_file(const char *object_dir)
 	struct pack_midx_entry *entries = NULL;
 	int large_offsets_needed = 0;
 	int pack_name_concat_len = 0;
+	int dropped_packs = 0;
+	int result = 0;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -795,7 +811,10 @@ int write_midx_file(const char *object_dir)
 			  midx_name);
 	}
 
-	packs.m = load_multi_pack_index(object_dir, 1);
+	if (m)
+		packs.m = m;
+	else
+		packs.m = load_multi_pack_index(object_dir, 1);
 
 	packs.nr = 0;
 	packs.alloc = packs.m ? packs.m->num_packs : 16;
@@ -809,13 +828,14 @@ int write_midx_file(const char *object_dir)
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
@@ -829,6 +849,34 @@ int write_midx_file(const char *object_dir)
 
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
 	/*
 	 * pack_perm stores a permutation between pack-int-ids from the
 	 * previous multi-pack-index to the new one we are writing:
@@ -837,11 +885,18 @@ int write_midx_file(const char *object_dir)
 	 */
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
@@ -857,7 +912,7 @@ int write_midx_file(const char *object_dir)
 	cur_chunk = 0;
 	num_chunks = large_offsets_needed ? 5 : 4;
 
-	written = write_midx_header(f, num_chunks, packs.nr);
+	written = write_midx_header(f, num_chunks, packs.nr - dropped_packs);
 
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
 	chunk_offsets[cur_chunk] = written + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
@@ -958,7 +1013,12 @@ int write_midx_file(const char *object_dir)
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
@@ -1125,5 +1185,44 @@ int verify_midx_file(struct repository *r, const char *object_dir)
 
 int expire_midx_packs(struct repository *r, const char *object_dir)
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
+		if (prepare_midx_pack(r, m, i))
+			continue;
+
+		if (m->packs[i]->pack_keep)
+			continue;
+
+		pack_name = xstrdup(m->packs[i]->pack_name);
+		close_pack(m->packs[i]);
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
index 1b2d32f475..12570fe7ac 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -412,4 +412,24 @@ test_expect_success 'expire does not remove any packs' '
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
+		test_cmp expect-idx actual-midx &&
+		git multi-pack-index verify &&
+		git fsck
+	)
+'
+
 test_done
-- 
gitgitgadget

