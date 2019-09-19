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
	by dcvr.yhbt.net (Postfix) with ESMTP id E6F8D1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 14:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389149AbfISOnT (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 10:43:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52031 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388938AbfISOnS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 10:43:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so4908246wme.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aiknyIBVY/8IL38FhivZVJeFUnAaYaiRItPlyWKkNDY=;
        b=ltAJmtBBBUUYLX7UDxaVmSDK6BNHROHJypCMnXvyiBOdSCVUWxbsjYDBXXx9ivgZ82
         n5TX0h94tz4x/gfs4OtBrYvfJ4bqdSeekZ91riE/0/DlTd+AyY1GI8njZ4WeovFfC+SA
         AeiprztMBsJn10KSHdU0Oe4OzdzCS8c2AoVgXgI0S98BPXI0zzX1ysm12wLhWUhGIH0p
         uL3PibCt9B4lkUaZh7g0oxpOYWFaQUVjIZjA74voOQOvGYmtib6x78Ba49YBpuq477CL
         PxY97kScj5KOQMygK5KbSxUnxrD3quHekn5Ae8wXqagKmblegmRBNmfWMIvD196sFYC+
         qBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aiknyIBVY/8IL38FhivZVJeFUnAaYaiRItPlyWKkNDY=;
        b=bkyyczuq+Af0AYNiDNDYG2fes0Ypvu0X1/N06x2WRPSpco5qZ30JNQhnOLhz3n3cFv
         AJjKdft3DNA148BKwGzb7zwT55/W94fbIr3RhhE3TY4eLogsX8Frmv/zkvBbdAgs1WRp
         BpWJ4edizlvCbZvDt2Vge2I+n1gjTnPzOUacDv77FzUXhxs1H9DpBwk1UBM+UFJYbJS1
         E6pTxOFg2Mz8B8SsWrEjX6dYKBNBEklJQ0RDMEEVgDktBo87bdNwN2VqsyrMLcPJsJPc
         ozCwuqrN0wI9lh2mSLZYIYDHFrjA/0H0GEVgXy2S3cIhMQ+4zjRDMMdUQ+ri5RmgIw8K
         FILA==
X-Gm-Message-State: APjAAAXH/uqNyNdaqR5ULEf19g0Vn6NSH8urPZ6xJjJvhK46jspR2NmB
        NUG5ze4e/j4XqAg5mDM8SAVuyg+Q
X-Google-Smtp-Source: APXvYqwcJRTeFPhx/+ANaZ8n7HA3V/ECzYIchlJBHTD0hNEK4/WFjAQC3jwhdenEQ7pjz6TxGYg66A==
X-Received: by 2002:a1c:7f54:: with SMTP id a81mr3374105wmd.100.1568904195775;
        Thu, 19 Sep 2019 07:43:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i74sm7109388wmg.44.2019.09.19.07.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 07:43:15 -0700 (PDT)
Date:   Thu, 19 Sep 2019 07:43:15 -0700 (PDT)
X-Google-Original-Date: Thu, 19 Sep 2019 14:43:04 GMT
Message-Id: <25642f8df28825cce61812a24cbd87bf7cb2025f.1568904188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v2.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
        <pull.316.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 07/11] trace2: add region in clear_ce_flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

When Git updates the working directory with the sparse-checkout
feature enabled, the unpack_trees() method calls clear_ce_flags()
to update the skip-wortree bits on the cache entries. This
check can be expensive, depending on the patterns used.

Add trace2 regions around the method, including some flag
information, so we can get granular performance data during
experiments. This data will be used to measure improvements
to the pattern-matching algorithms for sparse-checkout.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index cd548f4fa2..26be8f3569 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1404,15 +1404,23 @@ static int clear_ce_flags(struct index_state *istate,
 			  struct pattern_list *pl)
 {
 	static struct strbuf prefix = STRBUF_INIT;
+	char label[100];
+	int rval;
 
 	strbuf_reset(&prefix);
 
-	return clear_ce_flags_1(istate,
+	xsnprintf(label, sizeof(label), "clear_ce_flags(0x%08lx,0x%08lx)",
+		  (unsigned long)select_mask, (unsigned long)clear_mask);
+	trace2_region_enter("unpack_trees", label, the_repository);
+	rval = clear_ce_flags_1(istate,
 				istate->cache,
 				istate->cache_nr,
 				&prefix,
 				select_mask, clear_mask,
 				pl, 0);
+	trace2_region_leave("unpack_trees", label, the_repository);
+
+	return rval;
 }
 
 /*
-- 
gitgitgadget

