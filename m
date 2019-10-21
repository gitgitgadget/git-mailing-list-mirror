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
	by dcvr.yhbt.net (Postfix) with ESMTP id E72631F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 18:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbfJUSkM (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 14:40:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55284 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbfJUSkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 14:40:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id p7so14496279wmp.4
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s2N3OnQLzGbRCdiLvra04EcslzOwFrgjzXd+WEP7hX0=;
        b=G2nizgGkmcFvRlK3qljIjQeEhL68cr/AUiPckn+DFexxNXGH80Z71rLcYOQLFFLrLR
         q3PxLI4KGTX+urYmZR+cLVMqjvOPqjO7nEdafjZM0EJSmZSEkGefD4ynQ9SENfa0YUDM
         p87icBMqj8E3gEXzcbKiVJdDmkzThvpieNRpHERv90TU6cGcWw3gQl9OG4sKe2gUy2q4
         6qCwQeaiA8fuC7UOzsokFX0EgVOBj6NAcLutQJbmzb5yQg2JTiKarlIe1Iz4nZ3x5ONa
         ZkS/Pyhb1kRJ5XKwGv+keEZRQEWtnqz7IhaGraRT+EzmLJG4usyc+gb4RRayn41CLtyb
         G6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s2N3OnQLzGbRCdiLvra04EcslzOwFrgjzXd+WEP7hX0=;
        b=U/hBKF5AKg4vFPqiREiSWiiSJzOwh6jjGyyPE+FiLSJOm0eaNSMK203twnbLlqW0uv
         KnrakdYFJV6Ltkc7UhC6V/qqAJY5sTAcWNuxd98DDXqlZ6Dn2xPBKEDM1bP6tMjGPEQS
         /lxq4qplKp42xT4Tffidv9fHP/KSeQWeR+7EMg6n8V0ExehPCFqzw7YCoioWQnZDWi42
         8AVBxB3EgzFx9KLbKJboVjp1G5d0ZRAsHjfPkgQg822wsjBQwJs99IXJpK0rS6iuej5z
         pXfU7koO0JpQq5yuvk6Unc/FFxRL9krNPN7UVNztxe7GjadcGdf2v5Eb6aV2BUiGdtBN
         sfxA==
X-Gm-Message-State: APjAAAXtdtPzdnNv4mMs0FULtRfcX5xv6fKFpBkvZO7TGPn6ydDL5R78
        RSaW/3gJfcpBiTaHhE/Y8fgZjs7f
X-Google-Smtp-Source: APXvYqwQhcIuUfA9MVT+8q+o4UnH3gm+c+Oc2Ctl4f6cy3fb87B0fGRBX8qW6crSab7Z4loSqU1/zw==
X-Received: by 2002:a05:600c:2291:: with SMTP id 17mr19016859wmf.171.1571683207393;
        Mon, 21 Oct 2019 11:40:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm15554088wrq.52.2019.10.21.11.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 11:40:06 -0700 (PDT)
Message-Id: <3468acf39ad402826878136f3c3ba7ab076ec0c3.1571683203.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v4.git.1571683203.gitgitgadget@gmail.com>
References: <pull.337.v3.git.gitgitgadget@gmail.com>
        <pull.337.v4.git.1571683203.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 18:40:01 +0000
Subject: [PATCH v4 4/6] midx: honor the MIDX_PROGRESS flag in verify_midx_file
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
index 7157259ca2..35bdc5f72c 100644
--- a/midx.c
+++ b/midx.c
@@ -1097,15 +1097,16 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
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
@@ -1123,8 +1124,9 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 				    i, oid_fanout1, oid_fanout2, i + 1);
 	}
 
-	progress = start_sparse_progress(_("Verifying OID order in MIDX"),
-					 m->num_objects - 1);
+	if (flags & MIDX_PROGRESS)
+		progress = start_sparse_progress(_("Verifying OID order in multi-pack-index"),
+						 m->num_objects - 1);
 	for (i = 0; i < m->num_objects - 1; i++) {
 		struct object_id oid1, oid2;
 
@@ -1151,13 +1153,15 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
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

