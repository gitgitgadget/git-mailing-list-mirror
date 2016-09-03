Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 530E31FBB0
	for <e@80x24.org>; Sat,  3 Sep 2016 03:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbcICDQy (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 23:16:54 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34525 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752827AbcICDQy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 23:16:54 -0400
Received: by mail-pa0-f45.google.com with SMTP id to9so7171009pac.1
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 20:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jQsSWlc66PI14SyUbjB4bHsfKRGPsSswPgKxEwgUhTQ=;
        b=hqg2mReLEuQQ3wucBaTFdY3e8Vj1rnuS2gsLx6arul25ha37aOKbQaT3uFLbq4vvYS
         U5CWNZIdzf2RKnqQ31iX2s8kGx8MHvVsTj3W+hvRTDRSXqLs7u3aOIzxGT/X8ebhyDXk
         vCXoSYk2PRXtnycPOE1F0nXGnDapNU0z7f1aPTLzkXN2A7Z8eDe85Qi8v80aJaRwB/ul
         OghGSVXstywcEN/ggBinIm7MGq2q0m7y/k4boUmP9BRIPlgg1ykSyqprgoLwC7N1GoWI
         ObvGAKvCIkLyvNGs4GdX7R4/p6sHwfLflUITemF7ZcJiE+0amcXBNYrWIPK2KVJr6ClV
         jxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jQsSWlc66PI14SyUbjB4bHsfKRGPsSswPgKxEwgUhTQ=;
        b=gwYBBiV/DSNd/Vl8xo23Aq19YAPCy+ZQfW4de7lJe2qU2zVeRWhZGor5KtL6OtmDO+
         CyZT9CB8GNefVdwhHFc03kWWUur2mGsSGw7e/R9qnRLuEEbS7wJRt+7Ojau5qorZBayb
         szNKky5dhK9CEtfa/cDumzei4pxRJqHOztMYtBfmi/4Ot1AywvNQq8La6Mou2y+RlnY2
         9mnrtfBtXSh1078eSy2DTwjZxdSRgA2VDaMSAvIBd80goiCL94qB2zDoETwBhvojIqqL
         1ftfutJsWkGk66k5zU2jjQy+DXtn6N4ph0xrPDyrrDa4db1uO/PBF3qlnRAJ81YalmIl
         Fkng==
X-Gm-Message-State: AE9vXwPlsjNHGIoUbXnznWVoo1E3Y0JHfKFeKfRkriUL/knY/zpANYSJa0LN20wwDXbIp/WG
X-Received: by 10.66.242.166 with SMTP id wr6mr41773939pac.147.1472872613093;
        Fri, 02 Sep 2016 20:16:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:29f6:f946:ae72:afdc])
        by smtp.gmail.com with ESMTPSA id tr1sm17769172pab.19.2016.09.02.20.16.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Sep 2016 20:16:51 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] xdiff: remove unneeded declarations
Date:   Fri,  2 Sep 2016 20:16:48 -0700
Message-Id: <20160903031648.14465-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.rc2.22.g25cb54d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff/xemit.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 49aa16f..b52b4b9 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -22,15 +22,6 @@
 
 #include "xinclude.h"
 
-
-
-
-static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec);
-static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb);
-
-
-
-
 static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
 
 	*rec = xdf->recs[ri]->ptr;
-- 
2.10.0.rc2.22.g25cb54d.dirty

