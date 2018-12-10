Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A0F20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeLJSGY (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:06:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42799 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbeLJSGX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:06:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so5316524pga.9
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SwJK+i7FUmf41rHGqt2OE5ydk7dCHX6AWzN6CISRCpg=;
        b=RwB7Cfd2UOEPTftSgPOgCJ7o6AfMZCg/gzvvBMlu7sEduQhJ0KSOg4vKcyEiq8sNSc
         iN5iyip+gGydY7pldlKoUDYVhyB72IxKc+WuCLkloGUsUaV0Ecc7hP7uNNG740uSRsPX
         Vw41dbMaU9NzNjl00uHf6CGrx+hMTcCqE430sOiLsY5tV+9+E+9GYK9/zlffsT+zk6La
         pFnbUxhNUk7+uE/04p8xZh6CF2/l27Dz2KK4NgwF5uj4K7dGJIZSLgLu7RcFnNlSd5rD
         odfQ1oywZ6UeEqvJy5BakLei6RhgSe/4g4g1j1fBHXwAzbrhcVl67ZFfgBiBDR6FJtFq
         U9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SwJK+i7FUmf41rHGqt2OE5ydk7dCHX6AWzN6CISRCpg=;
        b=niOzPTucYgBXWCcCDdGv5VkNk4RXqdyNVfs/VCcvvhmtK/ck4yyNSd1fcZ85D3A/hN
         yhkg4Wf6PaKUGX0sHKuGa6alBvLWX9EIuN8w/O1UDlPjy3moC/mYj/umU1Mm2WjGBeuA
         ZAg8wpL8y09wXGYdfG1EVqZcEX9cJ/8yRiD5v3YN0I26oKBrfw/D0gsrm9BHpTpdZsGG
         qVD8yOlTQdl0m4lrat137vvI+Y+NfBZbPNww9iWaroOj404rorJlnZVs0RdIrbMt+34x
         G8NPe/9qWRpENGUfhVbAsgWhQyYNAMn3oCPzEVhn2f0FmSe9l3RC/AzGvnoS7w1zoPXb
         2RbA==
X-Gm-Message-State: AA+aEWasfmm70+CXWY8l23/+6czKgJDKacBO5HjKbz6Lf4RQpAl3ngaV
        LbxKiQURid5erKAKeWXDpg8QoDur
X-Google-Smtp-Source: AFSGD/XvPiY6+nkqvq150hx2wrGW+E30sY+mZoYQKO+4vH/InJQ63n6qvPiznN/ndVpq5A2C4HJLiw==
X-Received: by 2002:a63:f34b:: with SMTP id t11mr11717897pgj.341.1544465181989;
        Mon, 10 Dec 2018 10:06:21 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id p67sm19838576pfg.44.2018.12.10.10.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 10:06:21 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:06:21 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 18:06:13 GMT
Message-Id: <8f496ccb461aae2f169159d9dce957c1d16a31dc.1544465177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.git.gitgitgadget@gmail.com>
References: <pull.92.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/5] midx: refactor permutation logic
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

When writing a multi-pack-index, we keep track of an integer
permutation, tracking the list of pack-files that we know about
(both from the existing multi-pack-index and the new pack-files
being introduced) and converting them into a sorted order for
the new multi-pack-index.

In anticipation of dropping pack-files from the existing multi-
pack-index, refactor the logic around how we track this permutation.

First, insert the permutation into the pack_list structure. This
allows us to grow the permutation dynamically as we add packs.

Second, fill the permutation with values corresponding to their
position in the list of pack-files, sorted as follows:

  1. The pack-files in the existing multi-pack-index,
     sorted lexicographically.

  2. The pack-files not in the existing multi-pack-index,
     sorted as discovered from the filesystem.

There is a subtle thing in how we initialize this permutation,
specifically how we use 'i' for the initial value. This will
matter more when we implement the logic for dropping existing
packs, as we will create holes in the ordering.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/midx.c b/midx.c
index bb825ef816..3bd7183a53 100644
--- a/midx.c
+++ b/midx.c
@@ -380,9 +380,11 @@ static size_t write_midx_header(struct hashfile *f,
 struct pack_list {
 	struct packed_git **list;
 	char **names;
+	uint32_t *perm;
 	uint32_t nr;
 	uint32_t alloc_list;
 	uint32_t alloc_names;
+	uint32_t alloc_perm;
 	size_t pack_name_concat_len;
 	struct multi_pack_index *m;
 };
@@ -398,6 +400,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 
 		ALLOC_GROW(packs->list, packs->nr + 1, packs->alloc_list);
 		ALLOC_GROW(packs->names, packs->nr + 1, packs->alloc_names);
+		ALLOC_GROW(packs->perm, packs->nr + 1, packs->alloc_perm);
 
 		packs->list[packs->nr] = add_packed_git(full_path,
 							full_path_len,
@@ -417,6 +420,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 			return;
 		}
 
+		packs->perm[packs->nr] = packs->nr;
 		packs->names[packs->nr] = xstrdup(file_name);
 		packs->pack_name_concat_len += strlen(file_name) + 1;
 		packs->nr++;
@@ -443,7 +447,7 @@ static void sort_packs_by_name(char **pack_names, uint32_t nr_packs, uint32_t *p
 	ALLOC_ARRAY(pairs, nr_packs);
 
 	for (i = 0; i < nr_packs; i++) {
-		pairs[i].pack_int_id = i;
+		pairs[i].pack_int_id = perm[i];
 		pairs[i].pack_name = pack_names[i];
 	}
 
@@ -755,7 +759,6 @@ int write_midx_file(const char *object_dir)
 	struct hashfile *f = NULL;
 	struct lock_file lk;
 	struct pack_list packs;
-	uint32_t *pack_perm = NULL;
 	uint64_t written = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
@@ -774,18 +777,22 @@ int write_midx_file(const char *object_dir)
 
 	packs.nr = 0;
 	packs.alloc_list = packs.m ? packs.m->num_packs : 16;
-	packs.alloc_names = packs.alloc_list;
+	packs.alloc_perm = packs.alloc_names = packs.alloc_list;
 	packs.list = NULL;
 	packs.names = NULL;
+	packs.perm = NULL;
 	packs.pack_name_concat_len = 0;
 	ALLOC_ARRAY(packs.list, packs.alloc_list);
 	ALLOC_ARRAY(packs.names, packs.alloc_names);
+	ALLOC_ARRAY(packs.perm, packs.alloc_perm);
 
 	if (packs.m) {
 		for (i = 0; i < packs.m->num_packs; i++) {
 			ALLOC_GROW(packs.list, packs.nr + 1, packs.alloc_list);
 			ALLOC_GROW(packs.names, packs.nr + 1, packs.alloc_names);
+			ALLOC_GROW(packs.perm, packs.nr + 1, packs.alloc_perm);
 
+			packs.perm[packs.nr] = i;
 			packs.list[packs.nr] = NULL;
 			packs.names[packs.nr] = xstrdup(packs.m->pack_names[i]);
 			packs.pack_name_concat_len += strlen(packs.names[packs.nr]) + 1;
@@ -802,10 +809,9 @@ int write_midx_file(const char *object_dir)
 		packs.pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
 					      (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
 
-	ALLOC_ARRAY(pack_perm, packs.nr);
-	sort_packs_by_name(packs.names, packs.nr, pack_perm);
+	sort_packs_by_name(packs.names, packs.nr, packs.perm);
 
-	entries = get_sorted_entries(packs.m, packs.list, pack_perm, packs.nr, &nr_entries);
+	entries = get_sorted_entries(packs.m, packs.list, packs.perm, packs.nr, &nr_entries);
 
 	for (i = 0; i < nr_entries; i++) {
 		if (entries[i].offset > 0x7fffffff)
@@ -923,8 +929,8 @@ cleanup:
 
 	free(packs.list);
 	free(packs.names);
+	free(packs.perm);
 	free(entries);
-	free(pack_perm);
 	free(midx_name);
 	return 0;
 }
-- 
gitgitgadget

