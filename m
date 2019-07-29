Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255EC1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfG2UIi (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38390 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbfG2UIH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so33220733wmj.3
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZsMTYhK2ok2pSdGHeJ351sDFGcg+R6HsHq5y8VmRNuU=;
        b=l5Lc+K10Q5KGFTUC21cAVre6otBPd1JAXLfJ7ON6Xp7vQf9IVFbIa3QrS7rL0rYd5l
         hU/dYzLNnTAT0CcC8Oji0G9C8KxErv38N7ktFEafH1NYkJz5QW5A8RrzdoRh0xq2mmFJ
         IhU4ELit+ME4efWYB9/5c8WKKnYr5XUyNKk+2KZ012sSthfqjdRxJWmopvG8Jvvprcd0
         KuhHhK/taokb7q+9VPvo4eS+O/3UYJSk1PeX/Z5Zjee0nUblvK+elelughOTZ+B1kldQ
         VpMy+KXn6yhi3ZUbQymqRj+NmvBNa7uZZduhGr91Oznmc+sJumM1dIFhBnaNCdsoFIqc
         TWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZsMTYhK2ok2pSdGHeJ351sDFGcg+R6HsHq5y8VmRNuU=;
        b=T736ewdRqQW89y5uTn2U1JeWmTiNoUv8QMvu6q32uPvjTs3JWRasby1+ylcbpopphh
         VQDv2H+gjw7Xb3bZVH7ml+vVQK6ebymhk1H/LYlW2oHP7LqfkXxG8RQSSJy2CQpsmKvs
         LZ4vw0qJ7WdlbhpF3uKRmEBhp8WLGtHW2b5rlv8EsCTuPea2/71pcVTuepTdFp8jtu22
         VZi/2Kjr2tcvqpyiycbkIFp31oCrIhqRm2hG5E9KtPe6Dl3UvJ+8hcmgMUnMvurGUscU
         jwFDCtBdQj8JXCQZEiYbx2fSmfrt+DBNnYRKigRZzMRII8v4hYACoPh+ZrQjpSfhxnRP
         xOHg==
X-Gm-Message-State: APjAAAWpFsEfM5XXQwWHn0E8f+JexNy68eVDL7eBD88lrJI/g9qEeFvb
        ptIr+/JJjaqiHUF+eGB7sKjWCgoq
X-Google-Smtp-Source: APXvYqx5EnUcKmgl1v5/TnD0LmuX5HRxop8ikt0usSc/lHg6bXUu4BHneob65dmGWMG20bcQZmD4bQ==
X-Received: by 2002:a05:600c:2111:: with SMTP id u17mr81753251wml.64.1564430885679;
        Mon, 29 Jul 2019 13:08:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14sm119996385wra.75.2019.07.29.13.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:05 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:05 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:43 GMT
Message-Id: <b8eb868316990ae180323d04efe08ed7d48c61ef.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 07/23] contrib/buildsystems: fix misleading error message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

The error message talked about a "lib option", but it clearly referred
to a link option.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/engine.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 53e65d4db7..11f0e16dda 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -333,7 +333,7 @@ sub handleLinkLine
         } elsif ($part =~ /\.obj$/) {
             # do nothing, 'make' should not be producing .obj, only .o files
         } else {
-            die "Unhandled lib option @ line $lineno: $part";
+            die "Unhandled link option @ line $lineno: $part";
         }
     }
 #    print "AppOut: '$appout'\nLFlags: @lflags\nLibs  : @libs\nOfiles: @objfiles\n";
-- 
gitgitgadget

