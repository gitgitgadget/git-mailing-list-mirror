Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2C1F1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfA1Vr7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:47:59 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42407 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbfA1Vrv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:47:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id y20so14329855edw.9
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 13:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vw18RXBJwQcANiNyw0vBltTf0YnfQZQmcuS7iHSU2OQ=;
        b=d/Bv5CAbLdoi6ROQMQGxcEd0B78g2aStZArbp0taklZDtmBII9AmPPFwleGlp75ui3
         1GP9GNbRa2dmMyJ7rw4fBOVNCGqjq4cI1o/JVGDzwOKBzhsShVOPd+wlCoVYVZPC34wY
         wvUOmr7/S9PadEA8IN1EJTFTNjQLE67LLUu7Z8jnK7Gi4OU6NNmyFBd6e4LT3hZ0ENWD
         nQg2JVBZdRfyl6cal2bIp29VeaZAJJNz7fgk42H2PHonMIepHSgk2nGwOf4g8n72g+JX
         5kFztrTwrR0Xt6z0PweG6XhspwB2NSjypNhc3x2hsjPUxZ/2z/99l2jYSxTCzCLeqSvC
         JcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vw18RXBJwQcANiNyw0vBltTf0YnfQZQmcuS7iHSU2OQ=;
        b=hUix31MY8Tt5UasvHcUWQ3ni9ogfpJoKOHrfD470+vMf3+/6UP04orZrUcD5aDuriU
         eZyacezzE1GY9xQGQGkZg/RKGpj32smlAWz44YgRnRgsOn3rX1ZB/5FDVEHE+subkqwe
         B+4NhsjrzEXNm7Bwtywg99xk3AjwD81xOzrEvMGqglhqDg5mqCR5E8P1q+1JetQeuqJh
         08hVjvQ7qNkUjg7+G5c6LWGYzVkgm2Ru9XoaAlH/EheuzSO/HkYVSpvpOquuZhV0DtLs
         gfYwaOY/gGErm8zxj0PqEzwoL2kV44XIpCzAg2SrBJZ1IpeZY9BpHDbCT1q2gypIL55E
         a/PQ==
X-Gm-Message-State: AJcUukeYdDNl+E3FiGV8KHB0nbxaGS4C45C6EFNDvrWDevLytNiPti/j
        hsGYdRkblpDGesj1wPvuNgfTH9or
X-Google-Smtp-Source: ALg8bN4310BtTg6JyW2XJTFCJZhJmvvd4S89SBPYNltB5aChtX7yERtXtvstA4Hef7kz3+1arAgNhg==
X-Received: by 2002:a17:906:1956:: with SMTP id b22mr19153556eje.216.1548712069504;
        Mon, 28 Jan 2019 13:47:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm2710084eju.72.2019.01.28.13.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:47:49 -0800 (PST)
Date:   Mon, 28 Jan 2019 13:47:49 -0800 (PST)
X-Google-Original-Date: Mon, 28 Jan 2019 21:47:35 GMT
Message-Id: <34589178117c8ddf9cf80fda3cde80a38676d700.1548712060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v2.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
        <pull.108.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 10/14] pack-objects: add trace2 regions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When studying the performance of 'git push' we would like to know
how much time is spent at various parts of the command. One area
that could cause performance trouble is 'git pack-objects'.

Add trace2 regions around the three main actions taken in this
command:

1. Enumerate objects.
2. Prepare pack.
3. Write pack-file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/pack-objects.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 889df2c755..6708529e3c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -33,6 +33,7 @@
 #include "object-store.h"
 #include "dir.h"
 #include "midx.h"
+#include "trace2.h"
 
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
@@ -3472,6 +3473,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	trace2_region_enter("pack-objects", "enumerate-objects", the_repository);
 	prepare_packing_data(the_repository, &to_pack);
 
 	if (progress)
@@ -3486,12 +3488,20 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (include_tag && nr_result)
 		for_each_ref(add_ref_tag, NULL);
 	stop_progress(&progress_state);
+	trace2_region_leave("pack-objects", "enumerate-objects", the_repository);
 
 	if (non_empty && !nr_result)
 		return 0;
-	if (nr_result)
+	if (nr_result) {
+		trace2_region_enter("pack-objects", "prepare-pack", the_repository);
 		prepare_pack(window, depth);
+		trace2_region_leave("pack-objects", "prepare-pack", the_repository);
+	}
+
+	trace2_region_enter("pack-objects", "write-pack-file", the_repository);
 	write_pack_file();
+	trace2_region_leave("pack-objects", "write-pack-file", the_repository);
+
 	if (progress)
 		fprintf_ln(stderr,
 			   _("Total %"PRIu32" (delta %"PRIu32"),"
-- 
gitgitgadget

