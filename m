Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A4131F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 17:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfJCRxi (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 13:53:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43659 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729858AbfJCRxh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 13:53:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id j18so2893758wrq.10
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=23NSinLyH7nV79BXWUA7bbyNTvs+29xvLGTgQfUPvPU=;
        b=TmfDax6W7rt8Liu9D5uOTw6YbkbsUUrJhbzmYD7YeT8dNyP5Z4qqF5VGOZoIlaWLfH
         1Mw/4kX24PBFw01q5/ez6GeW5qmofPFPrbAAaM5GW9JICjMErC6q7aQ4mJjqOlAv/UAc
         ISCKinxhf+r4fqoGnE9cTKA+WyGbZ9U0udStap9ULgpj21OsC7i4LLT2Z1UULoGruXuw
         Ql87K2EFSNdQYnARaLjgS5r8DYCCR4qMAFvL99ugO4hD8FIcPChS/a9+zZa9PBugBs49
         y0Go8sKvoiS2mVpKeti3ps7g9wgDqJD448iL9kFX8gD8B/tV+w/M/3MuDIjNAcSbQYOG
         CLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=23NSinLyH7nV79BXWUA7bbyNTvs+29xvLGTgQfUPvPU=;
        b=Nkvpa1OcKWp1ll+oBReigwaevjjwBiiqKttXwb1oHSMPeUhWAYNSpFmnyIbRP8EG73
         81uOUkY8um90hZ+/GOxAcqJcQjn8AM+0QiGelsmKGhM1Viv7kAK1bKfjMSoBqQZ+Eiw1
         UI9rPAsJIvT2h9O2+QgwnFg3sDjOLoKFJcBspgW4sWWhNrfV7HpQ9wtJQ0JwVmuinMhI
         +kIBAUc+lVDir9Npj7GxiFDQgjgv7P5wmIq0vb2349fAtZTdqd9G+GabJ3R2qBNG9OP3
         BYR8jymaj8YiAY4qQmbAfc4qHwhmKaj2tVG9CkWd5P/h6AYjXBQ8VOf28PlkCTivytx3
         1ZKw==
X-Gm-Message-State: APjAAAVR6pmOi1suuVWlk8GvmLRHbGOQt40v49J01EfxjP739y4Ulccb
        m9PtQsINupwJDj8UHRahe0hzg+xn
X-Google-Smtp-Source: APXvYqzAgNU50+7OH+4mvTS/2nJOV51Gh/RJPm9oBktlFH767Z1K6P9aXmJMaqh2KGFAIjFzLnYypw==
X-Received: by 2002:a5d:568d:: with SMTP id f13mr7808405wrv.162.1570125215049;
        Thu, 03 Oct 2019 10:53:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm3019564wmb.37.2019.10.03.10.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 10:53:34 -0700 (PDT)
Date:   Thu, 03 Oct 2019 10:53:34 -0700 (PDT)
X-Google-Original-Date: Thu, 03 Oct 2019 17:53:27 GMT
Message-Id: <f208c09639257877479ed33b607a26f7cf435038.1570125210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v3.git.gitgitgadget@gmail.com>
References: <pull.337.v2.git.gitgitgadget@gmail.com>
        <pull.337.v3.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 4/6] midx: honor the MIDX_PROGRESS flag in verify_midx_file
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

Update verify_midx_file to only display progress when
the MIDX_PROGRESS flag is set.

Signed-off-by: William Baker <William.Baker@microsoft.com>
---
 midx.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index f14bebb092..ced5898bbf 100644
--- a/midx.c
+++ b/midx.c
@@ -1098,15 +1098,16 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 {
 	struct pair_pos_vs_id *pairs = NULL;
 	uint32_t i;
-	struct progress *progress;
+	struct progress *progress = NULL;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
 	verify_midx_error = 0;
 
 	if (!m)
 		return 0;
 
-	progress = start_progress(_("Looking for referenced packfiles"),
-				  m->num_packs);
+	if (flags & MIDX_PROGRESS)
+		progress = start_progress(_("Looking for referenced packfiles"),
+				 	  m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
 		if (prepare_midx_pack(r, m, i))
 			midx_report("failed to load pack in position %d", i);
@@ -1124,8 +1125,9 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 				    i, oid_fanout1, oid_fanout2, i + 1);
 	}
 
-	progress = start_sparse_progress(_("Verifying OID order in MIDX"),
-					 m->num_objects - 1);
+	if (flags & MIDX_PROGRESS)
+		progress = start_sparse_progress(_("Verifying OID order in multi-pack-index"),
+						 m->num_objects - 1);
 	for (i = 0; i < m->num_objects - 1; i++) {
 		struct object_id oid1, oid2;
 
@@ -1152,13 +1154,15 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		pairs[i].pack_int_id = nth_midxed_pack_int_id(m, i);
 	}
 
-	progress = start_sparse_progress(_("Sorting objects by packfile"),
-					 m->num_objects);
+	if (flags & MIDX_PROGRESS)
+		progress = start_sparse_progress(_("Sorting objects by packfile"),
+						 m->num_objects);
 	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
 	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
 	stop_progress(&progress);
 
-	progress = start_sparse_progress(_("Verifying object offsets"), m->num_objects);
+	if (flags & MIDX_PROGRESS)
+		progress = start_sparse_progress(_("Verifying object offsets"), m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
 		struct object_id oid;
 		struct pack_entry e;
-- 
gitgitgadget

