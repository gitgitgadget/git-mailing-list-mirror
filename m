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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FACC1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 23:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390645AbfFJXf1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 19:35:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32883 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390500AbfFJXf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 19:35:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id h9so17007368edr.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 16:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SggN8uz60g65Y4aU3BtykqZV2Pldn4U2tE9XQ7+fT8E=;
        b=GUZVWXcZrbxym5C4pXDQofEMbOrcrJVCEyRiejLhPXg6bD7Wr1bX2c/PBNtNqgJ54o
         A+x1sYY9f5eoJ+gC2yunlYtyvYjthAT+BQThEPwPDvvHdzvfxeaVjiczaBF0NuihQa2v
         9IuF7zc7sx91+ZWQwhT4L3P5lyZmVcoz9waKj3np5nvroe5LGL0r4xVGyDZcdO656b2x
         hWdOglfXmRPTmjAXwtpqYaDHlEP6Euoe2eoyw5Np7fSQRuhqhV+QJTOSe0n+wyHgiQ5A
         +RKwpPqUpG5iDqEfugHAAFMIE/4IgPBdhjGj5GrL8vCWkXLpHCkNbAq/Ci9gsHpIe2Jm
         qjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SggN8uz60g65Y4aU3BtykqZV2Pldn4U2tE9XQ7+fT8E=;
        b=FQYOVGGyxE00Hx7d1SbTz8hTI7hJ/pd0e7c3JoKphY2AxlQWFgHVlQXKrEoYzMAACh
         OhlzziNfInk+Py9zMrINTwG9e/tqAk9ZdLm+Hrr627NocJp+R+1FE0RpefYsJH/e4Ywn
         8Eye6+6o+2EIJ/8OHzbt56IgoK+4EPJuk23WYy+gQR4oZfP1tiEgJQvwCMFhq+1TzyuQ
         JTk6y25+jPhvh/1CUxpQ7n6khe8mjVBDBGKMq18Kns/Yl3KZbgUW1V08wSwEkQDZ3HFj
         yaj7JTP4CXWvFkzE1RvCFYRTKx263mKJb/SW9p4MhUgAYO+1OPCsjvh/841GkfrDaL9A
         uYyg==
X-Gm-Message-State: APjAAAWNYrvFX1lwL7VsXcszRGoSC7t351AVmXRFcl8HjpFPSS6Zf+Q6
        cEGa8C+vPK9MJRJAe6g0leJJFVpx
X-Google-Smtp-Source: APXvYqz+hYJfQXb24V6ZjpKpKeHDr4At4fB1UjIL07sNc5gTYO0QrQdX3FjqFgcKfcLy74kfQ0DTcQ==
X-Received: by 2002:a50:b566:: with SMTP id z35mr42166948edd.129.1560209724509;
        Mon, 10 Jun 2019 16:35:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y14sm492900ejj.84.2019.06.10.16.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 16:35:24 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:35:24 -0700 (PDT)
X-Google-Original-Date: Mon, 10 Jun 2019 23:35:13 GMT
Message-Id: <dec7f384eea97511224ae5a77a82ed9a4330872c.1560209720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.261.git.gitgitgadget@gmail.com>
References: <pull.261.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 04/11] midx: simplify computation of pack name lengths
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

Before writing the multi-pack-index, we compute the length of the
pack-index names concatenated together. This forms the data in the
pack name chunk, and we precompute it to compute chunk offsets.
The value is also modified to fit alignment needs.

Previously, this computation was coupled with adding packs from
the existing multi-pack-index and the remaining packs in the object
dir not already covered by the multi-pack-index.

In anticipation of this becoming more complicated with the 'expire'
subcommand, simplify the computation by centralizing it to a single
loop before writing the file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/midx.c b/midx.c
index 3b7da1a360..62404620ad 100644
--- a/midx.c
+++ b/midx.c
@@ -433,7 +433,6 @@ struct pack_list {
 	uint32_t nr;
 	uint32_t alloc_list;
 	uint32_t alloc_names;
-	size_t pack_name_concat_len;
 	struct multi_pack_index *m;
 };
 
@@ -468,7 +467,6 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 		}
 
 		packs->names[packs->nr] = xstrdup(file_name);
-		packs->pack_name_concat_len += strlen(file_name) + 1;
 		packs->nr++;
 	}
 }
@@ -812,6 +810,7 @@ int write_midx_file(const char *object_dir)
 	uint32_t nr_entries, num_large_offsets = 0;
 	struct pack_midx_entry *entries = NULL;
 	int large_offsets_needed = 0;
+	int pack_name_concat_len = 0;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -827,7 +826,6 @@ int write_midx_file(const char *object_dir)
 	packs.alloc_names = packs.alloc_list;
 	packs.list = NULL;
 	packs.names = NULL;
-	packs.pack_name_concat_len = 0;
 	ALLOC_ARRAY(packs.list, packs.alloc_list);
 	ALLOC_ARRAY(packs.names, packs.alloc_names);
 
@@ -838,7 +836,6 @@ int write_midx_file(const char *object_dir)
 
 			packs.list[packs.nr] = NULL;
 			packs.names[packs.nr] = xstrdup(packs.m->pack_names[i]);
-			packs.pack_name_concat_len += strlen(packs.names[packs.nr]) + 1;
 			packs.nr++;
 		}
 	}
@@ -848,10 +845,6 @@ int write_midx_file(const char *object_dir)
 	if (packs.m && packs.nr == packs.m->num_packs)
 		goto cleanup;
 
-	if (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
-		packs.pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
-					      (packs.pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
-
 	ALLOC_ARRAY(pack_perm, packs.nr);
 	sort_packs_by_name(packs.names, packs.nr, pack_perm);
 
@@ -864,6 +857,13 @@ int write_midx_file(const char *object_dir)
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
@@ -881,7 +881,7 @@ int write_midx_file(const char *object_dir)
 
 	cur_chunk++;
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDFANOUT;
-	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + packs.pack_name_concat_len;
+	chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] + pack_name_concat_len;
 
 	cur_chunk++;
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_OIDLOOKUP;
-- 
gitgitgadget

