Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AE9C203E2
	for <e@80x24.org>; Tue, 26 Jul 2016 00:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbcGZAfp (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 20:35:45 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35289 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbcGZAfn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 20:35:43 -0400
Received: by mail-pa0-f42.google.com with SMTP id iw10so65933888pac.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 17:35:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zs5z3bQtCdWbNyVolsq+GPGdH2Kp+aYWYPCIq7gaVFY=;
        b=m+mZ+zdfWUwnEWODE1tbHedOm4TzXhyTsPK1Q42psRLShwu9Ay7BCV+Pp1k/xLs94k
         oyDYwgFhBXLr+WkvDfuZjoPpXaUdlb3LjHTmd8X0Tp8yeMHk8/2rI5E00fLencbs/83X
         yc4h3pRPhr2v4FKjV6f+IfFzemEeUaQ7eJREA19tDYXXL7p3wFwGQz/vTZktkE9Gjkia
         07ZlzXs50sXiimj5fppUwr2zRj19/+SIRX3grNmmHuLiWDcIl+mOvl91A0aUyeGa7Chy
         skoiviOl+Kw99l6naxj+Bc7PGT0WNZR5MpaKykKqsFRIKrQRytJDmG2bTvUi6hf0NAnH
         wXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zs5z3bQtCdWbNyVolsq+GPGdH2Kp+aYWYPCIq7gaVFY=;
        b=K7vqnknryVl7s+Icv+K2lbzapOilMfF9cLe3Eo2uJITP8XJYniBWecrOL0CvVYh7Nw
         RnQ1igJuWHiWOKJ3VSZcwR4bATj+akLRAlTE0IYrXPCnfh5xn1Njk2vPKwEbeGaOSWzM
         mn3xfiQ2b06z8HxB89wEZGEpTQU+hNKB0MDg0A7K4b32OnvnxF8aWPtsJososNjTYHoE
         x8Ls1iTWcy4JaD3cuE0YMzH1lWYsse9KMj0ugvAF2u/HgHc5RUdL5Zs0vgKHc7rN98MT
         Du0FnQKlZgnmgg9nhCpBvq5LV5xydPugJRYVYSOzKtFR9xCBUKhAG0YJ8QDVgVtmSIFj
         N2rA==
X-Gm-Message-State: AEkoous5Xl+tL2maDsZJ0462tNvD7oHV3eXhBcHbk/GxaLu3izH9/WlQ3eKxDluruQuqxIJM
X-Received: by 10.66.48.133 with SMTP id l5mr34014368pan.151.1469493342195;
        Mon, 25 Jul 2016 17:35:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e124:dea0:af29:fff8])
        by smtp.gmail.com with ESMTPSA id j7sm42858644paa.30.2016.07.25.17.35.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Jul 2016 17:35:41 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH]submodule deinit: remove outdated comment
Date:	Mon, 25 Jul 2016 17:35:38 -0700
Message-Id: <20160726003538.30990-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.368.g08bb350
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  This is logically part of origin/sb/submodule-deinit-all, but this change
  failed to be there on time.
  
  As I am touching code in the near vincinity, I noticed.
  I do not include this in that series to come as I want to keep that
  series focused, so I send this separately.
  
  Thanks,
  Stefan

 git-submodule.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 42868df..a5e0ad6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -391,8 +391,6 @@ cmd_init()
 #
 # Unregister submodules from .git/config and remove their work tree
 #
-# $@ = requested paths (use '.' to deinit all submodules)
-#
 cmd_deinit()
 {
 	# parse $args after "submodule ... deinit".
-- 
2.9.2.368.g08bb350

