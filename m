Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD4E620248
	for <e@80x24.org>; Fri, 22 Feb 2019 22:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBVWZM (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 17:25:12 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38690 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfBVWZK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 17:25:10 -0500
Received: by mail-ed1-f67.google.com with SMTP id h58so3100490edb.5
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 14:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K7XMEqacsNErwgjvmp6bzVQzRfa2GXAzEYSNV9LuXmU=;
        b=VDg5FXbPsiWNjzlvzbp0r6IcgHfk/C9Oq0KZYNrHdBGbjMYHyFoPKqPjRk0gmgMA0y
         bafa54Ehq2zsXPft8OYXb+mk3d1wqydYxLyjSKBcUregNHMKePW+G8WszSCw0xDRRUrw
         UHFExA5CkqeS2UBoTmyzM2SUlER3iZGMI+HusKY15+yrdCsAKPPbxfBMPATtFJBX2KCn
         qOtemuJTTGToTEiFppFhSkXtqVdUbQsDpoNqbNIn5VH4zEtmzFu6GqzVmnDbJrgJ8ggv
         AICxLIqn4oioN1xf9HrGmJlvaa1HvQwS/McIWZbQ8e/l/NTshtVwaw50QLQAcJYY4hZo
         vMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K7XMEqacsNErwgjvmp6bzVQzRfa2GXAzEYSNV9LuXmU=;
        b=RH0FUTLqCuT216riB1iFNh+y2y5eYc64iBWMB6nLXZyrLxqXbDK8yR9TAkcFCUNjMI
         AG4QZ7V0Dzzt3QdPZkiIlhqcKd+6CSKwgEcxvcB+GnNEYtXo9EVagLEZilRJqwF8mOsQ
         Sh3pzP1hm2nLEzccYyYuVq+NNa/TjAxN0fRp9Jx4Gkz6RFcPHUqM/XvxIkhNYeFQum56
         2tqZiKr9hWs+JzgrIco4Qe4ktEINCdRXiQVYtA9maDb0xPesGOo8o+58NVR5FaC6fDh6
         ymsB1nK0MOnwSEn9HasXYHreNfV2PqX7NOoGmphi3Ct10/z60oEK9SDPuzvBKCczQv4t
         sUDA==
X-Gm-Message-State: AHQUAuamCAqHBgiatKsLyn58smedr7QSyNs7hCY4mmtxGAFhxQjMHZU0
        fXtPqgzsqYv7QzaGLRCX916vJXl3
X-Google-Smtp-Source: AHgI3IYzOgnE3kP9ctgqbN4Piwzv6bWVDe8C/MHTJaa5ATw3IVhonmPfCeN11kYEx+omYObUAZwDrQ==
X-Received: by 2002:a17:906:5c6:: with SMTP id t6mr4479833ejt.86.1550874308597;
        Fri, 22 Feb 2019 14:25:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z23sm698454edz.50.2019.02.22.14.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:25:07 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:25:07 -0800 (PST)
X-Google-Original-Date: Fri, 22 Feb 2019 22:24:53 GMT
Message-Id: <4e679241fca81c2be08111ce13351cdf412ef6ce.1550874298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v7.git.gitgitgadget@gmail.com>
References: <pull.108.v6.git.gitgitgadget@gmail.com>
        <pull.108.v7.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v7 10/15] trace2:data: pack-objects: add trace2 regions
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

