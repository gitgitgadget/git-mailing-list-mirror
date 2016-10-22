Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28CF20987
	for <e@80x24.org>; Sat, 22 Oct 2016 23:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756253AbcJVXcp (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:32:45 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:35347 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756207AbcJVXcm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:32:42 -0400
Received: by mail-it0-f51.google.com with SMTP id 198so53145800itw.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K81MgPmaANVWtJcEgJxJcOJDJcJD1M6EK7VFU/bGc/M=;
        b=Xcf+gcpJdfgwaadYNrCiWZzEoFl1dWHZC+a/0hjuaqytjtuOWvustCbz6Mt7UIqFB8
         ufyMlMYOiW7Lytm+dGoOIhRfibHJpNtZJ3mdS3azkjOUFCFeL5R+Yh//q/LYpbPLPkHT
         DITzG2qOsDO4INNJlBlW6Zb0hpUtnJ15Q46Nd9rNI/I3X7Cms4BACYw50ti6EJhiPww9
         D3NmMX4f5w+h38NSF0xEBKIsMsdLlRzxqmPd569+g0DN6Jpp28xPRE86FLO11JUePom9
         b1xlji+UaHjMxVHDQwdDqBfcZyVJJ5nLOgNFIVACdLmXun/96QD53384ZD3v7cE/z0lj
         /Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K81MgPmaANVWtJcEgJxJcOJDJcJD1M6EK7VFU/bGc/M=;
        b=iPd+0kkDqBSrDMasivHxomlnL332CvfdRvfuyGVFlE2sBfIqt5PUXNoJomWbD5Evgw
         oinJc6L5P/DHFyZBGCTlUAdjVUX5fDfEayhSFly6P+voV79EW5eAneKZbWzn4EzAMvEn
         iygm71k8jUpyIoSV9O7XKX/gs53UCHd6WC4fRTOqnq4AWeEShHkV4Cvs+hGSpvQwtEQl
         2FNRY0O0nNLtcsDTcUNZvg7OeqMbs82PvYOZ4PQYJ3dPB1gfQeiMFf3DKIxS0O1rvYjk
         tgMChPBSb0c9D+hgsJgPDgG8swo62ffD/q7SusA/xdSD1bu0AkSi7RaZwF/LbDhtvIKY
         YbMA==
X-Gm-Message-State: ABUngvf2FrpgAusM9zjnP/EBQT1y/jtoC+zDC89vvVNIJ2NsguKPc/qGQD5uoFjbERZpisZi
X-Received: by 10.107.9.22 with SMTP id j22mr7375926ioi.150.1477179161334;
        Sat, 22 Oct 2016 16:32:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id e12sm4564531ioe.14.2016.10.22.16.32.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:32:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/36] attr.c: complete a sentence in a comment
Date:   Sat, 22 Oct 2016 16:31:54 -0700
Message-Id: <20161022233225.8883-6-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 05db667..a7f2c3f 100644
--- a/attr.c
+++ b/attr.c
@@ -300,7 +300,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
  * directory (again, reading the file from top to bottom) down to the
  * current directory, and then scan the list backwards to find the first match.
  * This is exactly the same as what is_excluded() does in dir.c to deal with
- * .gitignore
+ * .gitignore file and info/excludes file as a fallback.
  */
 
 static struct attr_stack {
-- 
2.10.1.508.g6572022

