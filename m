Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 626A71F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfAVVWa (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:22:30 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42396 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfAVVWX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:22:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id y20so20513816edw.9
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vw18RXBJwQcANiNyw0vBltTf0YnfQZQmcuS7iHSU2OQ=;
        b=DETxzf87/6+OX+U9taOGhQRW9tj8WF0iHC+Zjurv7s4pW59a5YJjJqcRd3/MlaWSCQ
         Ly+9y5J7CA+/bPPmLEs3g5ecyOtSlbXmLDVz7jFI9x28Xcf1F3Jet3kcsygui5oT2aT0
         zlAuEsqCDAH85gWQIojh1SWxnpisE9rus1hyllqSlJAoO2tmw4jrh+FmSg6l0YLdv7ut
         ov0fw3wFD0ElHfpJNoDWDYJgdUZ8uf/wISgiAVAiPlMOEckJB7vwFGQ1wmFHmYLppT5j
         2tsd8PoqXzCHG/9Xq+Yq2e62NEgdRZXdOkY7XMQS244fgCK9g/3EQ75Oq1ukcgHp0JxR
         L+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vw18RXBJwQcANiNyw0vBltTf0YnfQZQmcuS7iHSU2OQ=;
        b=XGSZRxMeydTRDzWpnwIqORStbqASh277CvYRHGxYTfAxp6PNfLlQjhhjxSYarKJBUn
         cOE4vbLOmXm0m5hZND5iLPrHruBc8z++M7rBKUj2oXc13uB1ABbC8CyJpU7GpbNEHmUq
         sqkRKdPICjXdpN9TjWLhfxcNTvgTCsp6FPTkgevEceANPzJYo01MZju0IhasoOlsM0/D
         u2OlkfRv+2SSjscMO8D148pkZ9F2k8xBM7VQCcJX+k00bcLb7iDUOqt7ZfYrFCJnStAo
         jIL2+2QN7u7KLWcg0t1iCY3LTRdMhyHGh1C8bR0P3/8DLHDB5NU64+2ytKkoXHUakyGX
         cGpQ==
X-Gm-Message-State: AJcUukd12yknHEpGPEo4Sgystfpm0ZIYQpHMASxzn00K7YHwPOrKF9SN
        lJMI+1E6slFrtufiHFvWUjbw9zs1
X-Google-Smtp-Source: ALg8bN7Nfij9Zyb4rBvp39wyQ43CLNn+SkYl5kTnRp9FHu9PtOlOF2ZZce2yAre+gE97zGTafX7CMA==
X-Received: by 2002:a17:906:c44e:: with SMTP id ck14mr131934ejb.56.1548192141386;
        Tue, 22 Jan 2019 13:22:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm9812795edm.31.2019.01.22.13.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:22:20 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:22:20 -0800 (PST)
X-Google-Original-Date: Tue, 22 Jan 2019 21:22:07 GMT
Message-Id: <1aa79cb126ec43dae1c01d3ce740d9b687d69517.1548192131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 10/14] pack-objects: add trace2 regions
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

