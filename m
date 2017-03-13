Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 679A020373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753705AbdCMUJ1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:09:27 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33285 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753452AbdCMUJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:09:16 -0400
Received: by mail-pg0-f67.google.com with SMTP id 77so19330863pgc.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NxuT5HlL4nOO04D4m0d3fXiHr5237Bips7Fc0suoNXY=;
        b=lBeRcUKw3N+6QvzHQSJzXkFa1qfIo798rV2cYVEKe/L4U7rQaKJrJxRQIfRMQdQv9V
         XYomdSlTTKJ+oc3CzLy1tKSEO90gbL836LkZsz8sShGHGnMtHPd3YnMOJuvM1TQLV04n
         UlcwhMKYRern63kq3BwTuB5HyM07IfACahLY8Db+lwRpk4bipdB2SbtAMb1JfmwV09MG
         tVCf6QcdatUMgRP/TgA9NKkDa1WQahOhFlWlAKclW72A4lIMINiPUotUnD5VOrVDxANM
         VROgzQBrX0xBSiV3jeN9RLnd8ZGLWCcJzCCoeK5L8upbc09t6+R6U8DmLMl0vyhGvprp
         xVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NxuT5HlL4nOO04D4m0d3fXiHr5237Bips7Fc0suoNXY=;
        b=Fb8KY+FNDrtlu1UYrcrjjKaFN/JioGbNJzD5i/5IZRFu03pXnUv0bybeA5h9gVyPQf
         KSdyUuJWb+JBOhYZZYqkWqyNXYaMpCFq5SkP2D4KuiVsbkqeNYSAQ0zKkVO+ayWcWaoq
         g0FqiUk+fzrwH0E/DF/JO4FNky6JNF8SE+1/6/0pFe2fUDJZAvMs5QFCiNtudmAo8Ud4
         U7IvkFxblFsqWGFbN+Z9FwahD19FqU8cSuLvLYuwTGArH85OskKDrInl4LDa+Xi98lvo
         DcvDnfbfIgkovabQwxtAg+1HOkp0VDagKJYPxuyEj2VYTFYJL21lSAGUezDQHsAZi2Vc
         jQ/g==
X-Gm-Message-State: AMke39m+4xCFJFlT3YAT/ET0+4l9gB/3VhmfbJbTs7+0jONhvoi3tkz8uycrOOhiRL8KoA==
X-Received: by 10.98.19.12 with SMTP id b12mr39650629pfj.150.1489435755500;
        Mon, 13 Mar 2017 13:09:15 -0700 (PDT)
Received: from localhost.localdomain ([45.251.232.36])
        by smtp.gmail.com with ESMTPSA id s20sm34294681pfg.11.2017.03.13.13.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 13:09:14 -0700 (PDT)
From:   sourav mondal <souravcristiano502@gmail.com>
To:     git@vger.kernel.org
Cc:     sourav mondal <souravcristiano502@gmail.com>
Subject: [PATCH]v2 adding built-in driver for javascript
Date:   Tue, 14 Mar 2017 01:38:54 +0530
Message-Id: <20170313200854.6905-1-souravcristiano502@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

javascript is one of the famous langugae,it's needs a built-in driver. As it was not present in the userdiff & this leads to the patch.
	first line consists of some of the well used javascript keywords.statements in js use one or many keywords like variable declaration, function definition, logical opreation etc.The following line is for statements of type object.method() & it is expected to end any statement using ";". The word_regex in js is usual alpha-numeric.last two line shows all the different types of opreators in js and different types of number system used in js are also defined.     

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

