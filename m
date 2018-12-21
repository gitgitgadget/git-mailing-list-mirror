Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13EF1F405
	for <e@80x24.org>; Fri, 21 Dec 2018 16:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbeLUQ2r (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 11:28:47 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35531 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389232AbeLUQ2o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 11:28:44 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so5151879edx.2
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 08:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Kcu7E1IgGM/8OjSavPYn7eYZnRvUldCtMh+dcjoieX8=;
        b=GlIbG3eyxPH5Rv/dyW0ce24CeNorQ8fms9iAzAEDBcTipcBKQqI45y9h/XcNVQTV38
         hsP0GBNTcuePP8qphGFkd/2HHNSNtvGwT0HFHJKtTkgD3Rj57/s6McZNFJpWwBe0/a1O
         IvSzVhAcWndfyd2JkQR9C3kz9T6/RshIqDBibrI1iszjx8+BmrsHO3lQvaantgj1Mhje
         XGOLvVm+r9pUrFWFKdFQUI41YNlSuC6WOYu9kvZHnuuIusTaITFNnTN+rhCmZTFXhYIF
         d34Oi2clG2kFupXYrE3C8ZZM0xJHw0OAa5zme7SAx0iFflfKOzkJ+YxJEqYOih6ElCdA
         DUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Kcu7E1IgGM/8OjSavPYn7eYZnRvUldCtMh+dcjoieX8=;
        b=JUs3ANIcY7SzZdO9lOlMRSW8UrBau3h/iqsLYEszUk4MqAG5r9sRpb7i3WtkmSt3AB
         R+w40bBkrxh+3P3E1L3LXsd5TNz5h7vEUpTigODY0Bh8PtjgpdLx27eU9gTWCxeSPPmU
         ylVOANvjseE2MrPFYEv8vzgkqxZb5oee75zkKMtySbc7NILGViWNpHFCb85RCQW+bl2w
         RSnQIk4G9a03h7KUb5Mr8Xp5UncBO2uZr85vPnw18C+dzHKG9b6Q633e6Q43NvayLFa+
         hQWGTkdqD+zxfyGDxaTr3EvFynO9JXrHY++A/OIToGD5/wweuJ5FrP8uUEZWFKbVHfjn
         zmQw==
X-Gm-Message-State: AA+aEWbYzv0bkaSFVG9YhkrXeJHgLCagh2oeNfIufa9q3tVYwghc07+a
        h89FaRc+Wp98JI+mJHZ4HQ8guXGRk3WzJg==
X-Google-Smtp-Source: AFSGD/UvXiap3PCBo+jqEvdE4lySDHXpB6SEOBH7Wm5fSOdVy5O5YpINw1EJrUADaHkUan+Ps8YC8Q==
X-Received: by 2002:a17:906:754e:: with SMTP id a14-v6mr2566021ejn.145.1545409721701;
        Fri, 21 Dec 2018 08:28:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y53sm7009466edd.84.2018.12.21.08.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 08:28:41 -0800 (PST)
Date:   Fri, 21 Dec 2018 08:28:41 -0800 (PST)
X-Google-Original-Date: Fri, 21 Dec 2018 16:28:34 GMT
Message-Id: <1c4af93f5e9833d74a7cf7fc6d38df7fd93c1acc.1545409716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v2.git.gitgitgadget@gmail.com>
References: <pull.92.git.gitgitgadget@gmail.com>
        <pull.92.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 5/7] multi-pack-index: implement 'expire' verb
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
 midx.c                      | 82 +++++++++++++++++++++++++++++++++++--
 t/t5319-multi-pack-index.sh | 15 +++++++
 2 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/midx.c b/midx.c
index 3bd7183a53..043cd1fd97 100644
--- a/midx.c
+++ b/midx.c
@@ -751,7 +751,8 @@ static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_off
 	return written;
 }
 
-int write_midx_file(const char *object_dir)
+static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
+			       struct string_list *packs_to_drop)
 {
 	unsigned char cur_chunk, num_chunks = 0;
 	char *midx_name;
@@ -765,6 +766,7 @@ int write_midx_file(const char *object_dir)
 	uint32_t nr_entries, num_large_offsets = 0;
 	struct pack_midx_entry *entries = NULL;
 	int large_offsets_needed = 0;
+	int result = 0;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -773,7 +775,10 @@ int write_midx_file(const char *object_dir)
 			  midx_name);
 	}
 
-	packs.m = load_multi_pack_index(object_dir, 1);
+	if (m)
+		packs.m = m;
+	else
+		packs.m = load_multi_pack_index(object_dir, 1);
 
 	packs.nr = 0;
 	packs.alloc_list = packs.m ? packs.m->num_packs : 16;
@@ -787,7 +792,25 @@ int write_midx_file(const char *object_dir)
 	ALLOC_ARRAY(packs.perm, packs.alloc_perm);
 
 	if (packs.m) {
+		int drop_index = 0, missing_drops = 0;
 		for (i = 0; i < packs.m->num_packs; i++) {
+			if (packs_to_drop && drop_index < packs_to_drop->nr) {
+				int cmp = strcmp(packs.m->pack_names[i],
+						 packs_to_drop->items[drop_index].string);
+
+				if (!cmp) {
+					drop_index++;
+					continue;
+				} else if (cmp > 0) {
+					error(_("did not see pack-file %s to drop"),
+					      packs_to_drop->items[drop_index].string);
+					drop_index++;
+					i--;
+					missing_drops++;
+					continue;
+				}
+			}
+
 			ALLOC_GROW(packs.list, packs.nr + 1, packs.alloc_list);
 			ALLOC_GROW(packs.names, packs.nr + 1, packs.alloc_names);
 			ALLOC_GROW(packs.perm, packs.nr + 1, packs.alloc_perm);
@@ -798,6 +821,12 @@ int write_midx_file(const char *object_dir)
 			packs.pack_name_concat_len += strlen(packs.names[packs.nr]) + 1;
 			packs.nr++;
 		}
+
+		if (packs_to_drop && (drop_index < packs_to_drop->nr || missing_drops)) {
+			error(_("did not see all pack-files to drop"));
+			result = 1;
+			goto cleanup;
+		}
 	}
 
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &packs);
@@ -932,7 +961,12 @@ int write_midx_file(const char *object_dir)
 	free(packs.perm);
 	free(entries);
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
@@ -1034,5 +1068,45 @@ int verify_midx_file(const char *object_dir)
 
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
index 948effc1ee..210279a3cf 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -395,4 +395,19 @@ test_expect_success 'expire does not remove any packs' '
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
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
gitgitgadget

