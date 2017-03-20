Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993A32095B
	for <e@80x24.org>; Mon, 20 Mar 2017 14:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755519AbdCTO4n (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 10:56:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35003 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754472AbdCTO42 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 10:56:28 -0400
Received: by mail-pf0-f194.google.com with SMTP id n11so6365720pfg.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6q6N364+lSv2XL8QnmlKAPYNGNAdEeF5fnldMxtXsG0=;
        b=q/OB1Y/t2BFzWn3EibTDnboy3fksswqDq/GUgMFgUDUszIBBiVV57ZY1uIN2XJtnRZ
         GcNOOnUIBJniMOFu6DPp9qxbUYuerpSFRXqZqhWpVcdkF1ZUhnoJ4/maxjuUpI8x5XAK
         exHsSAUr1gfDWGAWMtVLui03VU1bl9ujISBu/Qn2GMB2Dm+o1c1StFC54aAYZda+4Rgq
         KnLT6RW1O76gu813y4LNDLj2SGk9CpUymMuirfH/74n3uGpVGMcF7ST+kYfA/D9cHwX+
         JETeAPU8XvmjmsDjH2YC7k8rp6ZwBj4XILYR9eWTi0DtxeT4WgFjZZG2gs2sWMRG9MC3
         497A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6q6N364+lSv2XL8QnmlKAPYNGNAdEeF5fnldMxtXsG0=;
        b=ozXqFBle52HdEOUiehVW4+bx/lq2PgXyF2dXnHkCkUgB4R8o2ZxamFtqUb0zq8VA4z
         0NAjtz6vsY7/1mMComreHglUf/0UWm+L6M36B/j+Q7UqQSZzIsqqF5fnE/qxlcvihvm/
         qNXor3S1bx+w1EhpA2hHBF044LjzH/9EEnGCfPWR1RhmEOZV0hz13U0zC1CSOpk+fmfk
         qEDLxXbT08/nbBEmYkZdm/LIaA/LwVGvXMzaVbobMvCTbMTQuBCqAVGlfRnEqNsWQi8q
         LZRSUDWYhzu7OZqbFNesxO+qW1ySfKmENdvrSvHmrtd0wcApCsRIbYfprmfGjsXhTEKx
         1TqQ==
X-Gm-Message-State: AFeK/H1zjmITEhxWC/WjOEDp7M/Ci7vgKqOlx3DbsvBJbOVwSRmmBKizE718KCrmzFyKjg==
X-Received: by 10.98.32.24 with SMTP id g24mr34460113pfg.115.1490021787262;
        Mon, 20 Mar 2017 07:56:27 -0700 (PDT)
Received: from localhost.localdomain ([202.78.234.44])
        by smtp.gmail.com with ESMTPSA id e2sm34125590pga.61.2017.03.20.07.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Mar 2017 07:56:26 -0700 (PDT)
From:   sourav mondal <souravcristiano502@gmail.com>
To:     git@vger.kernel.org
Cc:     sourav mondal <souravcristiano502@gmail.com>
Subject: [PATCH v3] adding built-in driver for javascript
Date:   Mon, 20 Mar 2017 20:26:05 +0530
Message-Id: <20170320145605.8375-1-souravcristiano502@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

JavaScript is one of the famous langugae, it needs a built-in driver. As it was not present in the userdiff, this leads to the patch.
First line consists of some of the well used javascript keywords. Statements in js use one or many keywords like variable declaration, function definition, logical opreation etc. The following line is for statements of type object.method() & it is expected to end any statement using ";". The word_regex in js is usual alpha-numeric. Last two line shows all the different types of operators in js and different types of number system used in js are also defined.

Signed-off-by: sourav mondal <souravcristiano502@gmail.com>
---

I'm working on "Add more built-in driver for userdiff" as my microproject for Gsoc17. This patch is for javascript which is one of the popular language at this time. I'm willing to add more driver for other laguage that isn't present in userdiff.c and again I'm willing to participate in Gsoc17 with git. I'm eager to know about this patch.

thanks & regards
sourav

 userdiff.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/userdiff.c b/userdiff.c
index 8b732e4..2f8e078 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -160,6 +160,16 @@ IPATTERN("css",
 	 "-?[_a-zA-Z][-_a-zA-Z0-9]*" /* identifiers */
 	 "|-?[0-9]+|\\#[0-9a-fA-F]+" /* numbers */
 ),
+PATTERNS("javascript",
+	 /* keywords/patterns*/
+	 "^[ \t]*(var|if|else|for|do|while|switch|case|function|break|continue|new|return|class|super|instanceof)"
+	 "^[ \t]*(([a-zA-Z_][a-zA-Z0-9])*[ \t]*\\.?[a-zA-Z_]*\\(\\)[ \t]*);$",
+	 /* word_regex */
+	 "[a-zA-Z_][a-zA-Z0-9]*"
+	 "|[-+0-9.eE]+|0[bB]?|[xX]?|o?[0-9a-fA-F]+"
+	 "|[==-+*/%<>&|!**=^]="
+	 "|--|\\+\\+|<<=?|>>>?=?|&&|\|\|"
+),
 { "default", NULL, -1, { NULL, 0 } },
 };
 #undef PATTERNS
-- 
2.9.3

