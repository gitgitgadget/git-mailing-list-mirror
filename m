Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DBEA211B4
	for <e@80x24.org>; Wed,  9 Jan 2019 15:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbfAIPVS (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 10:21:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38998 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731314AbfAIPVR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 10:21:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id f81so8638260wmd.4
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 07:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZPPQsqBQ5gngPxD0KKiocqAzAa2X2+5VlsopKOS3x+8=;
        b=S8yR8rPKih9O8SG+VapmwoH/buCKjXF78oXHXBQ9/5u71hQlRpDc4/zY54raxmi0eE
         IN9xxGpUwOVO/gtho6bF/kgkrPNhR7UIfXEPI0+4AWVdZhSIgUjT9FvVPZZuhin/cL6L
         RxTojMx4a8Vb1AcG2si162UskT0q8BhjDRTR4b0FS3OHTC1ZxPxbgESQcf5necvV+pQ1
         s6kXAf5WjFzlufNMFUcCMLMW61MbfqZ0HCWzVohOGoKrKEH5NQm60+lH+0pSzF36bFzQ
         o7s4xsGVLFEeMCtvQhGAQOggN7lE5qW0S/gDdr2986zNQdNtTbn4ohQcjQOfJnVqB8RZ
         QNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZPPQsqBQ5gngPxD0KKiocqAzAa2X2+5VlsopKOS3x+8=;
        b=QXl9UXT9OtUtzRd4oQV2lxPmhHT2mNfi05FdhMcgKNIhBlnKencLnqxYxHhPdkPOAi
         XfkbCtwafyi2EG+dTul5oHm+GYPwwA2qKupMHZsYT6bMpiYcDRvfctPOeRxBApm9PC2x
         r/fF8IXFkQYJEoqQNOTxOt8BuSEcM4DbjxNu3E+uJgCteWysCZOyY+/O1xQJhWwfLyxG
         DPqX3HRoN3groUKGN8USQ0UEVFMQZllXd646FyayPSTYqedSIoSK/sgY8puO+6715oyb
         C7B0xBAuETFeU9NZI4YCxT15wUeCXI5dsZ4ycfG9KDXJ63puNX4xEqE1Io0CnApOjT8r
         BVYw==
X-Gm-Message-State: AJcUukdx1ViWJGwMNsOUGWhWenGitudmt3B37AqpLnuD3ebF0cyx8Ycw
        xwSOhouBNSSXOBeaC4tzxfE6ntfU
X-Google-Smtp-Source: ALg8bN41iRkrDwmtm3e9pXfMKbjGXR7a8MDkOyO5tngawrd0pHe3g1xhBP9JTOWY+pA4P5KBcWIY4w==
X-Received: by 2002:a1c:c181:: with SMTP id r123mr6120427wmf.8.1547047275523;
        Wed, 09 Jan 2019 07:21:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19sm14101703wme.21.2019.01.09.07.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 07:21:14 -0800 (PST)
Date:   Wed, 09 Jan 2019 07:21:14 -0800 (PST)
X-Google-Original-Date: Wed, 09 Jan 2019 15:21:04 GMT
Message-Id: <2a763990ae3842582e9dd20000f6df992d9e8e2d.1547047269.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v3.git.gitgitgadget@gmail.com>
References: <pull.92.v2.git.gitgitgadget@gmail.com>
        <pull.92.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 4/9] midx: simplify computation of pack name lengths
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

Before writing the multi-pack-index, we compute the length of the
pack-index names concatenated together. This forms the data in the
pack name chunk, and we precompute it to compute chunk offsets.
The value is also modified to fit alignment needs.

Previously, this computation was coupled with adding packs from
the existing multi-pack-index and the remaining packs in the object
dir not already covered by the multi-pack-index.

In anticipation of this becoming more complicated with the 'expire'
command, simplify the computation by centralizing it to a single
loop before writing the file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/midx.c b/midx.c
index bb825ef816..f087bbbe82 100644
--- a/midx.c
+++ b/midx.c
@@ -383,7 +383,6 @@ struct pack_list {
 	uint32_t nr;
 	uint32_t alloc_list;
 	uint32_t alloc_names;
-	size_t pack_name_concat_len;
 	struct multi_pack_index *m;
 };
 
@@ -418,7 +417,6 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 		}
 
 		packs->names[packs->nr] = xstrdup(file_name);
-		packs->pack_name_concat_len += strlen(file_name) + 1;
 		packs->nr++;
 	}
 }
@@ -762,6 +760,7 @@ int write_midx_file(const char *object_dir)
 	uint32_t nr_entries, num_large_offsets = 0;
 	struct pack_midx_entry *entries = NULL;
 	int large_offsets_needed = 0;
+	int pack_name_concat_len = 0;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -777,7 +776,6 @@ int write_midx_file(const char *object_dir)
 	packs.alloc_names = packs.alloc_list;
 	packs.list = NULL;
 	packs.names = NULL;
-	packs.pack_name_concat_len = 0;
 	ALLOC_ARRAY(packs.list, packs.alloc_list);
 	ALLOC_ARRAY(packs.names, packs.alloc_names);
 
@@ -788,7 +786,6 @@ int write_midx_file(const char *object_dir)
 
 			packs.list[packs.nr] = NULL;
 			packs.names[packs.nr] = xstrdup(packs.m->pack_names[i]);
-			packs.pack_name_concat_len += strlen(packs.names[packs.nr]) + 1;
 			packs.nr++;
 		}
 	}
@@ -798,10 +795,6 @@ int write_midx_file(const char *object_dir)
 	if (packs.m && packs.nr == packs.m->num_packs)
 		goto cleanup;
 
-	if (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
-		packs.pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
-					      (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
-
 	ALLOC_ARRAY(pack_perm, packs.nr);
 	sort_packs_by_name(packs.names, packs.nr, pack_perm);
 
@@ -814,6 +807,13 @@ int write_midx_file(const char *object_dir)
 			large_offsets_needed = 1;
 	}
 
+	for (i = 0; i < packs.nr; i++)
+		pack_name_concat_len += strlen(packs.names[i]) + 1;
+
+	if (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
+		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
+					(pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
+
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	FREE_AND_NULL(midx_name);
@@ -831,7 +831,7 @@ int write_midx_file(const char *object_dir)
 
 	cur_chunk++;
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDFANOUT;
-	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + packs.pack_name_concat_len;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
 
 	cur_chunk++;
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
-- 
gitgitgadget

