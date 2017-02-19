Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D116201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 22:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbdBSWHi (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 17:07:38 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35853 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdBSWHg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 17:07:36 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so11413588wmd.3
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 14:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=HgeXlXsY6K4ScrRxNWyzIeWY+5gB5Txu3STsbapuGXI=;
        b=Y2FxHMKNbciUOii8Bg3lDYCrg+XNJrw/qek+7LbxL+e0iBKqUyLJYD8qHZZLvqExL/
         RRCnuZz2tgFZb+5iVly+ATDNZySAZLkpwmra0WDnbQIGERmkXF72Jz/FbBrPjVAZ99gt
         xKOStzsh5jRfcn4bhINMK2iOzYiI96E1HpFR8dz4kAA/Zr0TMJ5T6cwJw1EqPawtU6Dx
         nEGlCvZ/iKiJu7rDUFk1YpQbmRNHRqM5AR/uyI/2eL67Pppw2/bruNwSkmUZBTVCPo7/
         5SiaCQ60GAANfxMISpTxL22jxXxXtvrY1GIfTbUhbpWJz0Im+7zFxjZuo4xxcKkk/d8y
         Ws+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=HgeXlXsY6K4ScrRxNWyzIeWY+5gB5Txu3STsbapuGXI=;
        b=nLfOzD7zAbU4Qwz/ebUzoQp8KQY5gGItbnya8Vlp/VidgOjVJgTSWlPVKiutmbbItb
         wnAsTTfpFvCKVSf0RTux2IJxfxnGS5THDtA1uj6x8VT4mK7ydx9OyucJF5QYKEH3xSwq
         3kfw5tP5S8ilab4sH8w7JYHscijGB+lFC6JCX1UdVQVydTDFCr1CvemQS7itdq8upBEA
         WTRyVXgWIpFobt9dD9HX2/9+PpzrVAn8YgAu8QaU0Mtxl7bsUygJ8hS6emPjTTIghl8G
         LaCehCirjjKPlhJ7t8IMMt5kcAuDz0gfqXM+YDy5mMi3AfTR0iWfvcPxvyYec2fUHba4
         meCg==
X-Gm-Message-State: AMke39kLA2F4zOSPteylOulYbiJ4EfTdteOlN/J48caoLJE1+X8Gkz1iaevzY/mnNukn7w==
X-Received: by 10.28.63.15 with SMTP id m15mr16279393wma.119.1487541961615;
        Sun, 19 Feb 2017 14:06:01 -0800 (PST)
Received: from ?IPv6:2001:a61:341c:3300:4459:3755:f78e:4003? ([2001:a61:341c:3300:4459:3755:f78e:4003])
        by smtp.googlemail.com with ESMTPSA id t30sm22198760wra.52.2017.02.19.14.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Feb 2017 14:06:00 -0800 (PST)
To:     gitster@pobox.com
From:   Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH] Documentation: Link git-ls-files to core.quotePath variable.
Cc:     git@vger.kernel.org
Message-ID: <2b0ce702-60de-534b-8a86-5c7ae84060de@gmail.com>
Date:   Sun, 19 Feb 2017 23:05:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a hint for script writers where additional quoting can be configured.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-ls-files.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 446209e..19e0636 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -198,7 +198,8 @@ path. (see linkgit:git-read-tree[1] for more information on state)
 
 When `-z` option is not used, TAB, LF, and backslash characters
 in pathnames are represented as `\t`, `\n`, and `\\`,
-respectively.
+respectively. The path is also quoted according to the
+configuration variable `core.quotePath` (see linkgit:git-config[1]).
 
 
 Exclude Patterns
-- 
2.7.4
