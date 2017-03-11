Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4BD202C1
	for <e@80x24.org>; Sat, 11 Mar 2017 09:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755640AbdCKJYD (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 04:24:03 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32976 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbdCKJYA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 04:24:00 -0500
Received: by mail-pg0-f68.google.com with SMTP id 77so12766865pgc.0
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 01:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0jdMf7JfVSuZCWdtT12ypQ9+6Hp0JXEjCamnKdBuHT8=;
        b=lI+mUCO1h7ZpemAb0xtXMZFVT0GSVj+ccg08WTB1i+TcUIFuTVceRpGiN8CfY4okxF
         LD4IB44iMHdP3Gan9ThU5h0cC0M6ftrf5VP/ypHXHdq3Mimlp7CHizP7iIBT92xU4842
         s9RQNgqHuRiDkck9Ki4hnUZWY3djrYFusPPWTGZZ0cUHW3MRR9WXVQO5iQLbhtG69dNp
         WN2ZbEggG7lqGnd3RxWrND3OrqRV+40ze5LASXv+ViZzLQiqXZo52FSd0UiEzZdLxpCw
         9+vF4IiXmYwhQqPJ23V/gu0E80GURTqUptJs0E7BsssEalr0vJV10ZdkoudUaTlN8Vp/
         EMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0jdMf7JfVSuZCWdtT12ypQ9+6Hp0JXEjCamnKdBuHT8=;
        b=n3w7dVDkL1YmiaGgKILsEZoHib30uMrnD1+EcCWGufFO57vShHGgNV0Qb3xHUXsKJQ
         JO26JvtSa2C7/mffYvYZBDh2A/7eN3evEwXaxF4yjTuPOFFB3WngheHuKGBBECyNTjaU
         aS+IwD0uYOdxeSerDeGjSdus/7x1ZuZKU1FVVOWydc2TGbjAYnXaMI+4cOaN6OGXbiRN
         hMGDezljOX4N4gDOeiJkYZUeiJYPQldj4HM+3jj7SJLH9Fh0ifP+tqyscKodorRGg5i9
         BFqaesHLoouUKegpYtQV09nPGGfzPpykXyFAUhGH9XAOXF4nF4NM/zPB8tgZ/vKQIswE
         nPtg==
X-Gm-Message-State: AMke39msJsAMqPvoy+2sYiYrTdOMSqe7whL5Z5PLHp9GONf+dwsO7RjNE1pdp79+7s2D9Q==
X-Received: by 10.84.143.195 with SMTP id 61mr32130146plz.46.1489224238895;
        Sat, 11 Mar 2017 01:23:58 -0800 (PST)
Received: from localhost.localdomain ([45.251.232.224])
        by smtp.gmail.com with ESMTPSA id 15sm23171343pgh.21.2017.03.11.01.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Mar 2017 01:23:57 -0800 (PST)
From:   sourav mondal <souravcristiano502@gmail.com>
To:     git@vger.kernel.org
Cc:     sourav mondal <souravcristiano502@gmail.com>
Subject: [Gsoc] adding built-in driver for javascript
Date:   Sat, 11 Mar 2017 14:53:38 +0530
Message-Id: <20170311092338.9809-1-souravcristiano502@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm working on "Add more builtin pattern for userdiff" as my microproject for Gsoc17.As I noticed javascript's builtin driver was not present in userdiff of git/git tree. Hopefully this pattern will cover all cases. I'm really eager to know about my work and wiiling to add more pattern for well known lanaguage.

thanks & regards,
sourav   

Signed-off-by: sourav mondal <souravcristiano502@gmail.com>
---
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

