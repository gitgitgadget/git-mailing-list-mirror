Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	SPOOFED_FREEMAIL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3981F463
	for <e@80x24.org>; Fri, 20 Sep 2019 16:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405375AbfITQx4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 12:53:56 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:41289 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391383AbfITQxy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 12:53:54 -0400
Received: by mail-wr1-f52.google.com with SMTP id h7so7431924wrw.8
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 09:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zk4hI29UGqI03CUk12FRy3BCi2ybI4ug5xV3DpY1HUI=;
        b=WU9NDBvhpbBNaz4y6YvLBq7jM+Cn0FrlCi7jR6owjLlU4Ci1rUfwJISF0lUTWD1aqh
         VbLHNcdar9Q4F/JQWexUblal0ybfW6c3jjJgzn5WjHdmpWKYLR9acc+HDD/mVs/8JVce
         9CVgCuw50Z7RKEJFroETNHNOsWJZy786YqFp6m+IxWfxdd1wUkuZBEjDLE7f+2QjgvbT
         42td3fvkF/lwvQnx6ppxaK8I/DRDCcGkWl64zmUKlhQ8Qkas+PtWd6AEMSjIhlQ9rGRj
         fnGOiF0FWG4TVCnh5smvcAdgvlomcn9YaNDck7EXrBn7qwYnSqIZ9iU2bpqHTDlLoY7t
         XCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zk4hI29UGqI03CUk12FRy3BCi2ybI4ug5xV3DpY1HUI=;
        b=IqswEsrH7Adh8xtgwB18WlK/4btDX3T+JMRBmglbeAMBIbbX9itsr5/RkUq7DhOkZY
         flR+TCzEioUGN0sQJ+f5mLfN1RcjM7sgNr4T1GbU+ua02SB8EzD3BDKjpAtz5Vtu0AIL
         apXkuDwDAhxxsWYOKKhZYtbSHuX6JPTMfJOo4/hEzzTyofWSIuLzbehr/z3FUlrvWGY0
         Kyt+xmTwoeKCYdrC1VCs9ff2oRc/1BXPjR1j8frDOrw3MTJiucR1q34md/IsNGPYYds9
         2iEPAuMDxin6zxHcE2wf4kcjlucYFPDeHj7eAI0OtMoWGh4f0/jDgpBgdt1dusLNiYzS
         F0fw==
X-Gm-Message-State: APjAAAVQy20YlOHvHR8Ae1dwtKkbBvNyq4yyJdSNLDbvtkZo8COLdiuy
        ASlbeKoYxyaCuf50Nkx6ZaS2uD7j
X-Google-Smtp-Source: APXvYqwSlZs8CNZiv2hKEvYLV2mLGdhEjsJJnvDQYQus7TO6VBXjsMQUGc80QgjuFPmNQ9qCz6VXMA==
X-Received: by 2002:a5d:6306:: with SMTP id i6mr12542879wru.323.1568998430008;
        Fri, 20 Sep 2019 09:53:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17sm2938907wrp.37.2019.09.20.09.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 09:53:49 -0700 (PDT)
Date:   Fri, 20 Sep 2019 09:53:49 -0700 (PDT)
X-Google-Original-Date: Fri, 20 Sep 2019 16:53:42 GMT
Message-Id: <3bc8677ea7655a3706914f9753c0a3b79dbf7e1f.1568998427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v2.git.gitgitgadget@gmail.com>
References: <pull.337.git.gitgitgadget@gmail.com>
        <pull.337.v2.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/6] midx: add progress to write_midx_file Add progress to
 write_midx_file.  Progress is displayed when the MIDX_PROGRESS flag is set.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        William Baker <William.Baker@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Baker <William.Baker@microsoft.com>

Signed-off-by: William Baker <William.Baker@microsoft.com>
---
 midx.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/midx.c b/midx.c
index b2673f52e8..54e4e93b2b 100644
--- a/midx.c
+++ b/midx.c
@@ -449,6 +449,8 @@ struct pack_list {
 	uint32_t nr;
 	uint32_t alloc;
 	struct multi_pack_index *m;
+	struct progress *progress;
+	uint32_t pack_paths_checked;
 };
 
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
@@ -457,6 +459,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 	struct pack_list *packs = (struct pack_list *)data;
 
 	if (ends_with(file_name, ".idx")) {
+		display_progress(packs->progress, ++packs->pack_paths_checked);
 		if (packs->m && midx_contains_pack(packs->m, file_name))
 			return;
 
@@ -786,7 +789,7 @@ static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_off
 }
 
 static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
-			       struct string_list *packs_to_drop)
+			       struct string_list *packs_to_drop, unsigned flags)
 {
 	unsigned char cur_chunk, num_chunks = 0;
 	char *midx_name;
@@ -800,6 +803,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
 	uint32_t nr_entries, num_large_offsets = 0;
 	struct pack_midx_entry *entries = NULL;
+	struct progress *progress = NULL;
 	int large_offsets_needed = 0;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
@@ -833,8 +837,15 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 			packs.nr++;
 		}
 	}
+	
+	packs.pack_paths_checked = 0;
+	if (flags & MIDX_PROGRESS)
+		packs.progress = start_progress(_("Adding packfiles to multi-pack-index"), 0);
+	else
+		packs.progress = NULL;
 
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &packs);
+	stop_progress(&packs.progress);
 
 	if (packs.m && packs.nr == packs.m->num_packs && !packs_to_drop)
 		goto cleanup;
@@ -959,6 +970,9 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		written += MIDX_CHUNKLOOKUP_WIDTH;
 	}
 
+	if (flags & MIDX_PROGRESS)
+		progress = start_progress(_("Writing chunks to multi-pack-index"),
+					  num_chunks);
 	for (i = 0; i < num_chunks; i++) {
 		if (written != chunk_offsets[i])
 			BUG("incorrect chunk offset (%"PRIu64" != %"PRIu64") for chunk id %"PRIx32,
@@ -991,7 +1005,10 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 				BUG("trying to write unknown chunk id %"PRIx32,
 				    chunk_ids[i]);
 		}
+
+		display_progress(progress, i + 1);
 	}
+	stop_progress(&progress);
 
 	if (written != chunk_offsets[num_chunks])
 		BUG("incorrect final offset %"PRIu64" != %"PRIu64,
@@ -1019,7 +1036,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 int write_midx_file(const char *object_dir, unsigned flags)
 {
-	return write_midx_internal(object_dir, NULL, NULL);
+	return write_midx_internal(object_dir, NULL, NULL, flags);
 }
 
 void clear_midx_file(struct repository *r)
@@ -1222,7 +1239,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	free(count);
 
 	if (packs_to_drop.nr)
-		result = write_midx_internal(object_dir, m, &packs_to_drop);
+		result = write_midx_internal(object_dir, m, &packs_to_drop, flags);
 
 	string_list_clear(&packs_to_drop, 0);
 	return result;
@@ -1371,7 +1388,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		goto cleanup;
 	}
 
-	result = write_midx_internal(object_dir, m, NULL);
+	result = write_midx_internal(object_dir, m, NULL, flags);
 	m = NULL;
 
 cleanup:
-- 
gitgitgadget

