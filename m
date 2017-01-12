Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA4E11FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 00:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbdAMACe (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 19:02:34 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33041 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdAMACd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 19:02:33 -0500
Received: by mail-pf0-f173.google.com with SMTP id y143so20800287pfb.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 16:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BKI2AWbcg1Ix4vmXfQV8XnRSEWkizgotH8adx5f+LAY=;
        b=bIHMq02aZnI3e8XJV7Bk0hLqVHY5MOWo3emRKtQrmqb/hjBY8x5yM27q/+AdndzC4h
         tCYqwB9NEzfAbPjDOcqtTM2JnkLJ7FBm1ha38TH+XPNKSlVKZqTa1O3VT1Q9fgxtKkMY
         IG2tpbRfzlYGvbXCnL61tPJcm0zW/aUEUEV4VpmWZZhobVrBjOUGXI+EFRuEWJXjO/Xa
         eR69wvmTDlTcyqfQzKszQhrNpuwEzF8tp0SyzZ+5CgR7ZOBpguMdClQCdqpwZEFb85//
         fxvoQgmNyKxLgj2zQCL4NNyoyVp4VdHBpXkePrioHacPeXmasGCnSm2qcDO4NG+fprB4
         ZURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BKI2AWbcg1Ix4vmXfQV8XnRSEWkizgotH8adx5f+LAY=;
        b=rnTzoQ0zNvWA4+31dZzeujA4jIfnB3lrx/RH1xoGbhREMlDe+0ntAuGX4lsjXqoPdP
         CED/MIyRd70ITc2qs49TGA6mWzeF6L1hTIREs7TShjPJGRIDqj5MiF9HhsRMZ03tIDvt
         CHdvf4p1MVE8FDjthSYMmdlzvYKQfZ29CBk33kEIZXWXkUdSBfR4ikhb4FO1H4yxLnhq
         nvkSe8rBedMsIe/xTqM9eA5GKOF/z2Tpgl4uKSfpwswpd44IHp7veIVB4LjZufGQVqx4
         aE3GtRJtOBMqB9h7LA6s1zhVj/pzrFH9toWv7vg37d48deaGKAwUcY+I9BVzhIgA1XA/
         lPFw==
X-Gm-Message-State: AIkVDXJ4Hrf3Bl6+nZ0FFJsaqTI0nEbCv2y8w9gm49CCyAMuHIIdXZY1KaPixnpPhrxsK+YN
X-Received: by 10.99.217.21 with SMTP id r21mr20560687pgg.78.1484265249645;
        Thu, 12 Jan 2017 15:54:09 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:08 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 05/27] attr.c: complete a sentence in a comment
Date:   Thu, 12 Jan 2017 15:53:32 -0800
Message-Id: <20170112235354.153403-6-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 6b55a57ef..9bdf87a6f 100644
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
2.11.0.390.gc69c2f50cf-goog

