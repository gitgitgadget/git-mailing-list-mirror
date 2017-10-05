Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56C3A2036B
	for <e@80x24.org>; Thu,  5 Oct 2017 08:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbdJEIRj (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 04:17:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:44830 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbdJEIRh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 04:17:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id 196so819530wma.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 01:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DA2IPM4uwaBNmENfBu61nsEwSTbkDnZFlOGtdk5yL+A=;
        b=WT0IXs1aP8hVnv6xLpQJguU1m/ZAix0ZLTodcfYDkWdWjp25YhA1sbrB/Jse643rFk
         bFfXyvtjNvWi7Iger2c6FhYTBXps6h4pEVOXjIt67OIpXeViv5OvUcjh26V6Pgs7aIKw
         te+09hnDL0/TKZJNLv6ay/VeFPdRs+ZMLjDRiY8H+u8zQZHb7YSzOBEI7N8xi6QN17G5
         HV4F8fpxKMeAIUeCKFBjipWxDQFghfZGiwRn/ukF33cd2ebnQWWri4SE92Kd0tXiIo/0
         pLt3Helk2IljGzsHxu6ys9T8aQ/0BgGu5wLR/2NydHvjBUwjcxJ/r66h9yw4rzE9T/H6
         AsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DA2IPM4uwaBNmENfBu61nsEwSTbkDnZFlOGtdk5yL+A=;
        b=p6g/sTEfW0CdD99Rm3eS3vzRw1mLA5KVhAOJcpi17UUHW7ToEkRY3wnko2sUDBcH1E
         4wZW6hPytsq0J6RKeAY5P0KlfynKau1QXR7wbbi3JZiQrqIIvsBm8ywUOvUuIMquHxBw
         YFpebY4tm75T17zGoU1IgO7HPVaibkzq4QBnx1sq/U+aDXKwBgqUOmjdzilSpOSluayl
         XkoOfQMw+X+CnVsWlH7N7Ip0OT+Hu5/ukdi8M84gygHxKH0RMoC+MFBhKavaUyphsz2/
         4vd9HEcmwZj+s1/xiwp/X0umJ8u8LdY/h1Kkk/IUEykbb3c5EnEfeitD+v1QrXJK32tu
         YhZQ==
X-Gm-Message-State: AMCzsaWSsX7sauBdFtRrEGw2Rj2zU1WqFoJACzfBv2dst24cwtySkhOT
        SvOXAXYDjUToyaZO6WRS7Lni5U7d
X-Google-Smtp-Source: AOwi7QAam34uMzkQRIMYmpfiYQFeCzFe0RREDaeejii/Po7CQDMPnFF0IEAeLb9GG7Sbt2XRJbT4FQ==
X-Received: by 10.28.191.131 with SMTP id o3mr16424880wmi.113.1507191455736;
        Thu, 05 Oct 2017 01:17:35 -0700 (PDT)
Received: from Laptops-nathan.univ-lyon1.fr (wifi-ext-0213.univ-lyon1.fr. [134.214.214.214])
        by smtp.gmail.com with ESMTPSA id y144sm2654972wmd.18.2017.10.05.01.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 01:17:35 -0700 (PDT)
From:   PAYRE NATHAN p1508475 <second.payre@gmail.com>
X-Google-Original-From: PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>
To:     git@vger.kernel.org
Cc:     daniel.bensoussan--bohm@etu.univ-lyon1.fr,
        timothee.albertin@etu.univ-lyon1.fr, rpjday@crashcourse.ca,
        matthieu.moy@univ-lyon1.fr, gitster@pobox.com,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>
Subject: [PATCH] Documentation/git-config.txt: reword missleading sentence
Date:   Thu,  5 Oct 2017 10:17:33 +0200
Message-Id: <20171005081733.18529-1-nathan.payre@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the word "bla" to "section.variable" to make it clear that it's a placeholder for a variable name.

See discussion at: https://public-inbox.org/git/20171002061303.Horde.SL92grZCqTRV9oQkBFPELQ7@crashcourse.ca/

Noticed-by: rpjday@crashcourse.ca
---
 Documentation/git-config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 83f86b923..f9808d7ad 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -177,8 +177,8 @@ See also <<FILES>>.
 	'git-config' will expand leading '{tilde}' to the value of
 	'$HOME', and '{tilde}user' to the home directory for the
 	specified user.  This option has no effect when setting the
-	value (but you can use 'git config bla {tilde}/' from the
-	command line to let your shell do the expansion).
+	value (but you can use 'git config section.variable {tilde}/'
+	from the command line to let your shell do the expansion).
 
 -z::
 --null::
-- 
2.14.2

