Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DCB71F42B
	for <e@80x24.org>; Thu, 13 Sep 2018 18:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeIMXNC (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:13:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42848 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbeIMXNC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:13:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id g23-v6so2937573plq.9
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kDbI8PetvqkYBZ+33UKq7bQUaD3Bl3dwcBq+W7V66oo=;
        b=CTFvjng6KbH6V18EpLOvUiZFNzNUIz+e9Ksvx2TXNmpvKAx9wx9Lk5IL4kQZoy7wkF
         iTidefp2toOrx9awLCxMsbcbpOjMZlrhzpHOJ2yj207yxPZ7Ji1oRn0BOsyH9fOnY0c7
         hiMQ/vJB+aL9OMrGNd66WAY/rquqrKitHNDIr4+3aX84zUAmbi0J/0xHfXiI08BtkCgr
         oYztnQlPtuU2ty83IIbFusk5N8yGHKgNKyxu8f1k/kjVLBJrATeaZUqBzj20tzCxzy/d
         7lzR0l+1n+c3ho6/tv2mqgLddvcRKYFZdo793juoo78E3dOJXdhItn6McvjhTS3Ahd/j
         Er0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kDbI8PetvqkYBZ+33UKq7bQUaD3Bl3dwcBq+W7V66oo=;
        b=OBHKLHu7egmeoJy293yqbnOIoDRgCI8bETtBdxAkgxBoQPzpaW6DA/uHfiwQIWAXWU
         Xaw3YrAHEG9BVnG1RYtoSFzGxb1NV81bS7v7z+MHKN8EL/L695X8mc8CbxzwS3q1HGMG
         AZy57uy2UtkRauTUgI9E0Dtn2sW/dEjn19LQr0SYZFUkW05bOGnDS6WFboeH3R9dTf31
         tMM/2DAjK5676PN98v5E71qBL81ZlCKXwF+opr2NNFUUdrgD//AhtcdkWS+Fa0N/Rm9N
         1t2gigwFWz8YELEmROny2BFZqGbX1dawnlDYamue8Moe9jbjNLi/TvL2Td5fNzestr6T
         rRCA==
X-Gm-Message-State: APzg51D9cWgTXOVLRE0ay2yf1rHnLhH/laxEnX27t8CUhoveR3yOKsJT
        3yAcFW6Oz99747O0BdKI5/GrXAdg
X-Google-Smtp-Source: ANB0VdaCNsj4vvxyQ8Nk6ed/0064xX1gwnHXbhsdMrqiFFnT5tAT9MQrIq0rgzw0XvpNFfNynT5rqA==
X-Received: by 2002:a17:902:82c5:: with SMTP id u5-v6mr8275594plz.83.1536861747340;
        Thu, 13 Sep 2018 11:02:27 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id n29-v6sm5923861pgl.30.2018.09.13.11.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:02:26 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:02:26 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Sep 2018 18:02:09 GMT
Message-Id: <29ebc1716123a953663c43064d73b98cf2fe0cbd.1536861730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.v2.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
        <pull.34.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 10/11] multi-pack-index: report progress during 'verify'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When verifying a multi-pack-index, the only action that takes
significant time is checking the object offsets. For example,
to verify a multi-pack-index containing 6.2 million objects in
the Linux kernel repository takes 1.3 seconds on my machine.
99% of that time is spent looking up object offsets in each of
the packfiles and comparing them to the multi-pack-index offset.

Add a progress indicator for that section of the 'verify' verb.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/midx.c b/midx.c
index 47e7e6113a..4d4c930522 100644
--- a/midx.c
+++ b/midx.c
@@ -7,6 +7,7 @@
 #include "object-store.h"
 #include "sha1-lookup.h"
 #include "midx.h"
+#include "progress.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -940,6 +941,7 @@ static void midx_report(const char *fmt, ...)
 int verify_midx_file(const char *object_dir)
 {
 	uint32_t i;
+	struct progress *progress = NULL;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
 	verify_midx_error = 0;
 
@@ -971,6 +973,7 @@ int verify_midx_file(const char *object_dir)
 				    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
 	}
 
+	progress = start_progress(_("Verifying object offsets"), m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
 		struct object_id oid;
 		struct pack_entry e;
@@ -995,7 +998,10 @@ int verify_midx_file(const char *object_dir)
 		if (m_offset != p_offset)
 			midx_report(_("incorrect object offset for oid[%d] = %s: %"PRIx64" != %"PRIx64),
 				    i, oid_to_hex(&oid), m_offset, p_offset);
+
+		display_progress(progress, i + 1);
 	}
+	stop_progress(&progress);
 
 	return verify_midx_error;
 }
-- 
gitgitgadget

