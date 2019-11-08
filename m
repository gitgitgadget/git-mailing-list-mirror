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
	by dcvr.yhbt.net (Postfix) with ESMTP id 95F711F454
	for <e@80x24.org>; Fri,  8 Nov 2019 20:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbfKHUIT (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 15:08:19 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:40894 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387873AbfKHUIT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 15:08:19 -0500
Received: by mail-pg1-f171.google.com with SMTP id 15so4622004pgt.7
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 12:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8eDJCZrugmEGKhkv+uuQd28FJVQmMZLCOJLpYsLcLFc=;
        b=E+XUGpLiblVqkp3G6GiAXvF07m+SNRtVPZPTBOvXRQdSCNdjtf7YCrixS3NDCs2vFW
         UuPtuNvWG1i8oPnvJ0VaVbR3riU/9BvjpYuMf36iEXKq6QhyzVP8pUkuiOqB9U9e1dcr
         gJtDqHhn05fTgbE+emFOhHf7uELpjEcTRqpX5/VWyz0oaWPaZ5C5WS2KZbL8GIzDgIbK
         DocNYSNxz5QustPiaPIwscD37DpFG/+NRNAhQGDL4qhr+rVe95NDgK4AMTId/cFfNKfo
         +WlxIFY7XjCe+xrzlvFjexIUH4Z6nx1r5xar4LGG0bv8zmTHPAWPFN0+j1IsfS6lWiuv
         Cevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8eDJCZrugmEGKhkv+uuQd28FJVQmMZLCOJLpYsLcLFc=;
        b=iHtaL7ZTICMIRs5e6eVW9tUr1EvhYTuCRp5tsnERQqaz4BEpmWwK4cKRlrDwqyCTWP
         Oy6ZdFoBcdztXKq2WIi6wlcbGhLIo0sl595wy9BvJGZJi9ioJHVMrEI2k6iAF2/xmJXk
         dsFSdiCOcNGiMWSYX9/WuDx67ZJOOpfD4W9sHZBcC1F7TKoegUVhawlNQjswKfcv5qoS
         y/Ll8OHuVYD1FR0SV7aO4tDoHMZuS8YCNHVdKAmgZijj4tTIiWAIpgGKgjzZ3q13TFe/
         W/EOjwPgkRdfKaZLnuS8FhXbQS1HvAL0EDF+q6tQQWkxg9Oigb8sWDyoi1mVGGd3Mrlo
         IcDw==
X-Gm-Message-State: APjAAAUPnTO1R4PbJx8O2CubvG2DtD5XHrVmcDN8udfnKiqScZFAbKe0
        7Ua59hjyBzwR7s7nJgCINPXh9XLp
X-Google-Smtp-Source: APXvYqy+6S0XPVfSdvvmzK7zGkyrYzkXAqTlWQo0I7jPrRFsBsBZpZJbe/qaF+dIuKNO6oa0vmHZPg==
X-Received: by 2002:a65:6201:: with SMTP id d1mr13694047pgv.182.1573243698283;
        Fri, 08 Nov 2019 12:08:18 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id g6sm6516512pfh.125.2019.11.08.12.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 12:08:17 -0800 (PST)
Date:   Fri, 8 Nov 2019 12:08:16 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/10] SubmittingPatches: use generic terms for hash
Message-ID: <b34e9aea563454a117b2bb027da8f02fc67698eb.1573241590.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <cover.1573241590.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573241590.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Git is planning on upgrading from SHA-1 to be more hash-agnostic,
replace specific references to SHA-1 with more generic terminology.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 1a60cc1329..bb7e33ce15 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -142,7 +142,7 @@ archive, summarize the relevant points of the discussion.
 
 [[commit-reference]]
 If you want to reference a previous commit in the history of a stable
-branch, use the format "abbreviated sha1 (subject, date)",
+branch, use the format "abbreviated hash (subject, date)",
 with the subject enclosed in a pair of double-quotes, like this:
 
 ....
-- 
2.24.0.298.g3e88fbd976

