Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78AB21F453
	for <e@80x24.org>; Wed,  6 Feb 2019 17:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbfBFRQL (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:16:11 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42675 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731551AbfBFRQH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:16:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id r15so5086227eds.9
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 09:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+HNHRZvwJJmm0VWKLgMxINFpvo+ixKycoqwfuPzDbZo=;
        b=AXOIr+UR1WP8VkhHW095QJr9cROEdDhD7d/vATOblYNdUbCBMfb/RFi12uTxBc5B2j
         TejzXkDHCRC7H/ES1xi9nBYG81R6zYSD/+kq48a+Lu9bYgnVxDz2CdFeAvJ/V+3M8TWQ
         Y/eJWJVjPvKol9+JisoBm2I6wmQaqze6lF+izzR35nNt09Tl/9DsSvPpgh/TaPDJ15RW
         uzvz5EWMf742Jaa0UXhYIA+vri6XzTHR/N6A8zdS3bqrRDxiGOJ3kE8VlG/3sYvg3N6m
         x1PRTdGdRCqE45rhYWS0pCbGkyELa7/3z58U5rw9rOLG+UCKd5BpYn/AK2759s7xVLeI
         jMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+HNHRZvwJJmm0VWKLgMxINFpvo+ixKycoqwfuPzDbZo=;
        b=Au3QcqH0zYotOE0kASbIHiikLI0zhdEkjNAoVSBvskiNfkdg6UaV/Pda0zBGrksEvA
         lHAMIgSYq9PgcuFY4/bP5b+PBDDpILyW3eFWIL7m5BnuG++/lyTla5onHsLlk9EqI2lA
         o3wn3YZSzrDT+N4gKQtLLd2NVo7rm0j0osDKHkP3VXrGGIRSgfeBRJ8HZcT+8iQjzqAc
         NG0SnkKP8iOzLMfCCvKpdJ0AxT+Uj0UFSjxSr7ag9Y1Emc6tg8rQ1WG4i0gKfKRsYvNS
         lDFH00uAPhn45D/OP+8YeUPzqNoc8w/9nk8V/xI6YKy279DYv/tIlztt/BVnCq05dz8p
         v2og==
X-Gm-Message-State: AHQUAuYKXQc2O/WM/kNExe9qC+uNsSzqHgMieeN+3sbiYIMS77WYbRYJ
        A7P2W8zR97vFka5EmT5hNPIEtOqQ
X-Google-Smtp-Source: AHgI3IZSAZ72WeFoXtSFDacBZNykwr2DxlmnRtrUcc9iN4dXNUB8DIsznbAGfPukR1yEZ74RqAcW7g==
X-Received: by 2002:a50:983a:: with SMTP id g55mr9103352edb.143.1549473366666;
        Wed, 06 Feb 2019 09:16:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a27sm6155080eda.65.2019.02.06.09.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:16:06 -0800 (PST)
Date:   Wed, 06 Feb 2019 09:16:06 -0800 (PST)
X-Google-Original-Date: Wed, 06 Feb 2019 17:15:50 GMT
Message-Id: <93a25d09a15d67ca9f139d1bc1a2fa04840fa463.1549473351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v6.git.gitgitgadget@gmail.com>
References: <pull.108.v5.git.gitgitgadget@gmail.com>
        <pull.108.v6.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 15/15] trace2: add for_each macros to clang-format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index de1c8b5c77..41d4cd23fd 100644
--- a/.clang-format
+++ b/.clang-format
@@ -149,7 +149,7 @@ Cpp11BracedListStyle: false
 
 # A list of macros that should be interpreted as foreach loops instead of as
 # function calls.
-ForEachMacros: ['for_each_string_list_item']
+ForEachMacros: ['for_each_string_list_item', 'for_each_wanted_builtin', 'for_each_builtin', 'for_each_ut']
 
 # The maximum number of consecutive empty lines to keep.
 MaxEmptyLinesToKeep: 1
-- 
gitgitgadget
