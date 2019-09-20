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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6330D1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 16:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405343AbfITQxy (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 12:53:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43267 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391380AbfITQxy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 12:53:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id q17so7439134wrx.10
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 09:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5T0ID6u0QCWyR4LIydF9zpDbBm8+bmLJwgpvAz68vZE=;
        b=hpOa/eGD6Jc3mZRJ7csfhwVRoOMEDGh+Iu6WxcAwlGjOVNa3UlwYsa6qGuxK62XXVJ
         CaqfrLjiXCVC7J5MBD5rV0vMxy6jufyudNte2V8x+FextZ0+d7lz73jQyyB0R91rx/fb
         LE760bD/wrAlzLW4KawvdKwUjP7waftFzLh9+2N5IIsje1al0hI83G8DbpI2f0j1qFKI
         /XjJsFCNkotQE50Y+L7tDWRXEY48IUqXRmDMndX3DszuFdC9Hr/ABIKmTIA6uxCy+vse
         eajyOLIGu46jVNmm8IR3g6kybLsFw9YuTOPSUYZD2DOQm/zQ5KBhv3+1LZpnAfZCSiFf
         +JuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5T0ID6u0QCWyR4LIydF9zpDbBm8+bmLJwgpvAz68vZE=;
        b=rLReKATo6efcpxG5weI3toYuy/10t2aCEM94lp4Daj0EWLUJCYJvx3OtI61r2cpgvx
         0IibsvCbf5AL2gHOFYgpAHCULsU/iOTMOQYhI5q03l/d0EeGTSAUFAwO/aV8NP1UCZsh
         /NqsEAjyHcujLb1ri4moY0/dfjZeb8ieXCi9jVnH80YzPuwS9GjF+nu530oxVbURg2d/
         smgw9I9/IqpTFapgOTOtOk0iMSEDMKResXzRoa0mXu8Afbmiqqv9uDtiZGiO16rRzUCH
         PSfr/ANCvaeCQ4KkFZHoKawK31K9WK19QjsslaATqlULzB02NmucQkAFEkqmDVyZLyfr
         A5bQ==
X-Gm-Message-State: APjAAAVHrGVM2mDmDdzQATfO/Z/BLEpMzyMnQM2gA2RoJMbVdNBXQ0H3
        dU30b/NgY/hi2fb5B8pRo2KAbK9J
X-Google-Smtp-Source: APXvYqw/+jCJJyxLQnOMpBYotgchY2EFs+F506eF/pONZn+4nQ43A57i9z6IEzm2xeHRmkJU6AF3tw==
X-Received: by 2002:adf:ed8f:: with SMTP id c15mr12270354wro.83.1568998431448;
        Fri, 20 Sep 2019 09:53:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6sm3142238wrr.85.2019.09.20.09.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 09:53:51 -0700 (PDT)
Date:   Fri, 20 Sep 2019 09:53:51 -0700 (PDT)
X-Google-Original-Date: Fri, 20 Sep 2019 16:53:44 GMT
Message-Id: <29d03771c00ee4d18a7c6455edae5ebb75043c62.1568998427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v2.git.gitgitgadget@gmail.com>
References: <pull.337.git.gitgitgadget@gmail.com>
        <pull.337.v2.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 4/6] midx: honor the MIDX_PROGRESS flag in verify_midx_file
 Update verify_midx_file to only display progress when the MIDX_PROGRESS flag
 is set.
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
 midx.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index 3a0e161aea..dc7c5f43f8 100644
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

