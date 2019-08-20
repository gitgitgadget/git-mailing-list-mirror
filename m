Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E12031F461
	for <e@80x24.org>; Tue, 20 Aug 2019 15:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfHTPLP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 11:11:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36912 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730389AbfHTPLN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 11:11:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so12788036wrt.4
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nD/El0ezi407QLhuMawddHEjImenH67k+RPorL/OqVg=;
        b=CW5I/0B3jpUTaKpd9JghvFzX+kxIINqVLgRlts8mhy3xscrhIpgj8nwZdWdPmC0xta
         zbUDMCnkjJ0A7809I3VTzAFauVeL8jrDPTa8YIlHcaa2aPG9giOtGyKNF55jv7kSimx5
         EHSiOIPNbSYAt3AmY10ZQXTVc5uD1BA8MLO1DQXyfXDq8pn0nFDOTZFTM8kusHUSgr6F
         6zitcPYUJ3boOv9CKpHV7FsovmITOQyy0ApFZyBAoJKQIryn/8/ROchxUCEptmvlsoCr
         S6+rPRjRKCeBJennGuzgGCC1NRDCtofMkGL0/u4dTmK4foULybNF38OVTcoCaUwHP1SF
         iHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nD/El0ezi407QLhuMawddHEjImenH67k+RPorL/OqVg=;
        b=VNMdQQKYZSk61utzp9vDAP+/xzFIhLPS1uGth5bLsfjJ/5nx86XJP0UzI3MIupCOMo
         cxG/+WOp/T6D+YZoWKRbYLKbgRoyR2pVGAPoxmkRh5Gznsh+zlDf5i6qbedD3l06ehfT
         VOfZ/t2qlcJqv52LQiaXo1P2CLzNTp5nONg8iS/oFujKHCf8Iv512EdJOiFFrRPwlCsu
         n7/H9EzEk2XEdjGdOV0b8WvS9/GjSZO5arOMSTSAPf+vuAEOJqxXokazSml9Yt6mHDFw
         IHj1LKcuU2GKLrkIuD0iNYoKfmyh2M93PVSMGMGTQtIhtfCjpjsxPPvuqlFOztToGG5+
         kEqQ==
X-Gm-Message-State: APjAAAWhn0zdGp2gU3yBRmSJe01GH7BDTLk+VEnjEIL8bgrjHfZEePG1
        SDUfY3lC8HH4WECEGLz8s8khYVaE
X-Google-Smtp-Source: APXvYqwU+9jc3OYPBoIIgNeIk0H272TiLZQCN13iMu8qFm9nb73gf0ISf9IEuTPB7i2ztl1+HISSSw==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr34676726wrx.122.1566313871352;
        Tue, 20 Aug 2019 08:11:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16sm16777729wrp.62.2019.08.20.08.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:11:10 -0700 (PDT)
Date:   Tue, 20 Aug 2019 08:11:10 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Aug 2019 15:11:02 GMT
Message-Id: <86f12dc77dd94c1b2c6294842d29d8712f79e3d7.1566313865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.git.gitgitgadget@gmail.com>
References: <pull.316.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 6/9] trace2:experiment: clear_ce_flags_1
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

The clear_ce_flags_1 method is used by many types of calls to
unpack_trees(). Add trace2 regions around the method, including
some flag information, so we can get granular performance data
during experiments.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 62276d4fef..8c3b5e8849 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1397,15 +1397,23 @@ static int clear_ce_flags(struct index_state *istate,
 			  struct exclude_list *el)
 {
 	static struct strbuf prefix = STRBUF_INIT;
+	char label[100];
+	int rval;
 
 	strbuf_reset(&prefix);
 
-	return clear_ce_flags_1(istate,
+	xsnprintf(label, sizeof(label), "clear_ce_flags(0x%08lx,0x%08lx)",
+		  (unsigned long)select_mask, (unsigned long)clear_mask);
+	trace2_region_enter("exp", label, the_repository);
+	rval = clear_ce_flags_1(istate,
 				istate->cache,
 				istate->cache_nr,
 				&prefix,
 				select_mask, clear_mask,
 				el, 0);
+	trace2_region_leave("exp", label, the_repository);
+
+	return rval;
 }
 
 /*
-- 
gitgitgadget

