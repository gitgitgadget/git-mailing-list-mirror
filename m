Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EEC01F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbfA3TvR (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:51:17 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32809 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbfA3TvP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:51:15 -0500
Received: by mail-ed1-f68.google.com with SMTP id p6so672404eds.0
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 11:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K7XMEqacsNErwgjvmp6bzVQzRfa2GXAzEYSNV9LuXmU=;
        b=cLIge/tQdSqkBPihswFAUP98Ad8zILPqNpVe+jQMUTqtF1h8B8ODxZIkqTDSttNAgW
         t00ZVPW6DYUoZV++TCRuucZ4QI0IqQI/OxqO9Ayn2o3f3eAPCAyNxcFrPIYQrWidfSMP
         vtsCrwbGJ70wPST7oc+UuW9CSfretXbIV9dzWj7OEjYGKDUKPiiELkeym47BCsOwPXGp
         jFq0Nsz841EfZbDVEXZ3pJA3fXoZm/RB3ZPgcuYrbYV7h35GyzyZHGa97atA0pfjLVah
         dtWgkE+iPUXotPZU1onQwNBGx5m7u2LrofFXflE9HOsvZXgL5kUn/4Uq0TDEM1FhL+tv
         +92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K7XMEqacsNErwgjvmp6bzVQzRfa2GXAzEYSNV9LuXmU=;
        b=oZDO1P2MX5BcFfgohD7aQAgjzX0x0UtVO9b18kGQBj+2Y/GT1KBIsjJQeaYLUydLCL
         +D1TYwgdZfpY/uRWlttW2nKo40ec1BOFFrz2Rtk8U7x3OEtdQz/TjvfJIDVhcNvlvqrj
         Uc1j/TxOU43bbcCfCM8GNJgw/Nh4BNu6Ng17V3+iwoQUFQrjpUEluodVR0tGhLDkwYGX
         o5Pn5eEoMmjNmGEM8GMzjhus/HDJTCA55qXSy2yZixoPdiF+3FVH+qeVZHpFZOe9+HWN
         SmeGjC6O3OOSMAhiflG3ewB2dngXfgUNYNolYJTc4o/RmlCprD4PQzoTM41qMaWIApi7
         VOuA==
X-Gm-Message-State: AJcUukfflohUXPTRKXny6vzqxVL+g8o3KPELhdyaromw+M/fULNHIRpf
        r23S+gc4BAMYQ8n3s3N9ACDc7sKi
X-Google-Smtp-Source: ALg8bN5Vm+9nyJyXxIQprF4C5xERNKiB2XGL6dSFcC2e2HWwiI9I3+wMvJrGy7cdwW4ViZTBTk858w==
X-Received: by 2002:a50:c252:: with SMTP id t18mr30765371edf.57.1548877873613;
        Wed, 30 Jan 2019 11:51:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm715950eds.1.2019.01.30.11.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:51:13 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:51:13 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 19:50:59 GMT
Message-Id: <d50832263863adf0c2240de80bc410e651365f1f.1548877863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v3.git.gitgitgadget@gmail.com>
References: <pull.108.v2.git.gitgitgadget@gmail.com>
        <pull.108.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 10/14] pack-objects: add trace2 regions
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
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/pack-objects.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0a70d04604..8a64c2868e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -33,6 +33,7 @@
 #include "object-store.h"
 #include "dir.h"
 #include "midx.h"
+#include "trace2.h"
 
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
@@ -3472,6 +3473,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	trace2_region_enter("pack-objects", "enumerate-objects",
+			    the_repository);
 	prepare_packing_data(the_repository, &to_pack);
 
 	if (progress)
@@ -3486,12 +3489,23 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (include_tag && nr_result)
 		for_each_ref(add_ref_tag, NULL);
 	stop_progress(&progress_state);
+	trace2_region_leave("pack-objects", "enumerate-objects",
+			    the_repository);
 
 	if (non_empty && !nr_result)
 		return 0;
-	if (nr_result)
+	if (nr_result) {
+		trace2_region_enter("pack-objects", "prepare-pack",
+				    the_repository);
 		prepare_pack(window, depth);
+		trace2_region_leave("pack-objects", "prepare-pack",
+				    the_repository);
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

