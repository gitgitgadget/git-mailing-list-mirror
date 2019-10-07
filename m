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
	by dcvr.yhbt.net (Postfix) with ESMTP id 273C01F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfJGUIj (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:08:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47063 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbfJGUIh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:08:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so16723342wrv.13
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aiknyIBVY/8IL38FhivZVJeFUnAaYaiRItPlyWKkNDY=;
        b=Nt2hNOXi8Ht2cM49cYoNGb1yoKG0BzwjqfkvCabfyg9jex7u/DHgPeaHT/CbCpmsVf
         Z1xXysKv2++CanFuruc0ldAoNiEfBSvgfluocVKGDsW382dACHbYYIm4BwzArwSEruF3
         uTTm116hEUVuwOTgpg4a8mtWAGGYPnWS3eHCvgNbZGFOvPiW9MuIU5/topXMC+9UfOPj
         /4L46ECdDe4GMV6z1TBA+gOBkYVT0Eruovs01Oa5U/6At1aSo9JsRm1ay14451TXDIBD
         /cy2EkBfwf6a5DndgUNmoJS86miIYmpW+gExQBhexYzQ0DNLTYe+tbNidJtqSVT094l9
         tNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aiknyIBVY/8IL38FhivZVJeFUnAaYaiRItPlyWKkNDY=;
        b=ng6Qtmkjs0j4HIxmAz+812ndQOthE+Y3K3i0ytBctz/Q4FKMkAjmvGIfUQI11bywhd
         AhKQ3F7Ly5pCSwV9Ei1xkIyYNgGRiB2BIj8xQH+lMEaHEQQQSPuW96D1rTWEZ9SgDLq1
         G0pzLj6xBU9a17dwLMyBPBrR/7yGGK5WwBy7p4kZXrpWV27u9sMWVZ6xMpBlWqr2+K8J
         6qhPzwweHjKr0hZTKXbw7fCH9eOBep2ry4wt7rJISGH6nzFVMDsVbRGBhdflglcZst8Q
         3woxrYVVZOIlg5I4uIeKnCMZztUchJ2ObAwsxFbpGoHlfjs1y9ouQ+Hy3K4DBk5advck
         I1PA==
X-Gm-Message-State: APjAAAXDDvEwPIdd2B4BSAq9r1vA3aIr6RSQEms4VlqT034VtTOjxZLS
        TiYxmh81z94lHl2At/t/htxe0pRj
X-Google-Smtp-Source: APXvYqwbgEouNloAwxsms4u/8RvWF6fIdK/ccnUWQfmy9IA8vrsx3soUVOPMq1sKCsMYajgE78A5Gg==
X-Received: by 2002:adf:9083:: with SMTP id i3mr23556912wri.310.1570478914658;
        Mon, 07 Oct 2019 13:08:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r27sm47537332wrc.55.2019.10.07.13.08.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:08:34 -0700 (PDT)
Date:   Mon, 07 Oct 2019 13:08:34 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 20:08:15 GMT
Message-Id: <2c53ea13d0ebfd64956064804d28e6e1646c6aed.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
        <pull.316.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 07/17] trace2: add region in clear_ce_flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Junio C Hamano <gitster@pobox.com>,
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

