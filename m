Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E21081F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 18:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbfJUSkP (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 14:40:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37647 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfJUSkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 14:40:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so13803904wmc.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v39AxgsUJWCtoo28oG5e7SZiH85biK3fNdmLjIsRJU8=;
        b=jr3hkz2qXx+5V4C3hmsBbMfURuaOlCrb1kYd9mLumI/ewNoOvU54HNCNuTrPyxcTtS
         GACfPSGxJq1le5Kps4OrHfTh9xyNXRDG2fxSHr8z7vgVeeL5/HwJr0iLElc91Q/K+KgF
         LvS7PbRT6FTKc301YpgOXisxcAnBvro81c1sMqb9yWqRVvPMMHlgOiOoJPPyhe2KWL6g
         r65OOjIVaG/nXjASgviI6lym2ZFVITjGBo9CspAeZ1NfqGlY42HZHAUbvsBBERggOPIt
         VFVrnNYlHOioIvV4kWAqyFTU+mnzC9U43AI5rS9fQVgzbBjVcW2xxTuS1PkQrG4+TtU+
         QX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v39AxgsUJWCtoo28oG5e7SZiH85biK3fNdmLjIsRJU8=;
        b=bTUWWWItZHIXlqgrnh57Iz0Pou6o2CsE9yKdr7ELgjUokJK5cPWEFUhFZBlLPHM/yT
         b7vEzJdNfq1UbU3G3U5MCg+ZtW4ui9hsfvGjrgsAbBT5/564tH+AEn+UA8GVR9YESEnQ
         DncBvlSE7uN6sVSTA6aH9T4uWsIJFqOOVEG7sZQvmnWIJ3vZLSpqnWEg+wurQHz5Kris
         NebuJ25Moj1f+myTmP/UyMG7CCXReF+ldi0xiTDh+bSrI9FKnAS1UC7CIqyPEMKPZO7z
         1lIOKMO4JNcBULx3NVmC47myJsA+dbVd6mlW9Da3BuSMb66q+rYEJYf2WS0jIAZfGWwh
         0zxQ==
X-Gm-Message-State: APjAAAUDC1omcHMUX4BXY6phmfDDUKAz5WL+Xo3b0YXmRaq0RmxgmAyz
        PGJE2cUIh+Cnl8V5Sg9L6B9mUlh4
X-Google-Smtp-Source: APXvYqzVMCXz+BU3JVcbOyeig4/sfh/3+W7+wCV7ZOT/j46H8Z/gT+pZe02mj/lKYmyp0VrnrjK/XA==
X-Received: by 2002:a1c:4c02:: with SMTP id z2mr6702060wmf.78.1571683205958;
        Mon, 21 Oct 2019 11:40:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm13707403wmc.38.2019.10.21.11.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 11:40:05 -0700 (PDT)
Message-Id: <37768f58860d113e21730f2640ca773ebb54dff0.1571683203.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v4.git.1571683203.gitgitgadget@gmail.com>
References: <pull.337.v3.git.gitgitgadget@gmail.com>
        <pull.337.v4.git.1571683203.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 18:39:59 +0000
Subject: [PATCH v4 2/6] midx: add progress to write_midx_file
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

Add progress to write_midx_file.  Progress is displayed
when the MIDX_PROGRESS flag is set.

Signed-off-by: William Baker <William.Baker@microsoft.com>
---
 midx.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/midx.c b/midx.c
index f169a681dd..006f36b570 100644
--- a/midx.c
+++ b/midx.c
@@ -448,6 +448,8 @@ struct pack_list {
 	uint32_t nr;
 	uint32_t alloc;
 	struct multi_pack_index *m;
+	struct progress *progress;
+	unsigned pack_paths_checked;
 };
 
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
@@ -456,6 +458,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 	struct pack_list *packs = (struct pack_list *)data;
 
 	if (ends_with(file_name, ".idx")) {
+		display_progress(packs->progress, ++packs->pack_paths_checked);
 		if (packs->m && midx_contains_pack(packs->m, file_name))
 			return;
 
@@ -785,7 +788,7 @@ static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_off
 }
 
 static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
-			       struct string_list *packs_to_drop)
+			       struct string_list *packs_to_drop, unsigned flags)
 {
 	unsigned char cur_chunk, num_chunks = 0;
 	char *midx_name;
@@ -799,6 +802,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
 	uint32_t nr_entries, num_large_offsets = 0;
 	struct pack_midx_entry *entries = NULL;
+	struct progress *progress = NULL;
 	int large_offsets_needed = 0;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
@@ -832,8 +836,15 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
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
@@ -958,6 +969,9 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		written += MIDX_CHUNKLOOKUP_WIDTH;
 	}
 
+	if (flags & MIDX_PROGRESS)
+		progress = start_progress(_("Writing chunks to multi-pack-index"),
+					  num_chunks);
 	for (i = 0; i < num_chunks; i++) {
 		if (written != chunk_offsets[i])
 			BUG("incorrect chunk offset (%"PRIu64" != %"PRIu64") for chunk id %"PRIx32,
@@ -990,7 +1004,10 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 				BUG("trying to write unknown chunk id %"PRIx32,
 				    chunk_ids[i]);
 		}
+
+		display_progress(progress, i + 1);
 	}
+	stop_progress(&progress);
 
 	if (written != chunk_offsets[num_chunks])
 		BUG("incorrect final offset %"PRIu64" != %"PRIu64,
@@ -1018,7 +1035,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 int write_midx_file(const char *object_dir, unsigned flags)
 {
-	return write_midx_internal(object_dir, NULL, NULL);
+	return write_midx_internal(object_dir, NULL, NULL, flags);
 }
 
 void clear_midx_file(struct repository *r)
@@ -1221,7 +1238,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	free(count);
 
 	if (packs_to_drop.nr)
-		result = write_midx_internal(object_dir, m, &packs_to_drop);
+		result = write_midx_internal(object_dir, m, &packs_to_drop, flags);
 
 	string_list_clear(&packs_to_drop, 0);
 	return result;
@@ -1370,7 +1387,7 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		goto cleanup;
 	}
 
-	result = write_midx_internal(object_dir, m, NULL);
+	result = write_midx_internal(object_dir, m, NULL, flags);
 	m = NULL;
 
 cleanup:
-- 
gitgitgadget

