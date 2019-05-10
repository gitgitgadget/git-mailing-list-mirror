Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9DE41F45F
	for <e@80x24.org>; Fri, 10 May 2019 00:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfEJArf (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 20:47:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44197 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfEJArf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 20:47:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id g9so2201019pfo.11
        for <git@vger.kernel.org>; Thu, 09 May 2019 17:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KrhLZLjcVvBluw0AHFWx0sSuZ83gjQTP2KF7cl243R8=;
        b=nOB5kcvSxPqAOY6Tk8KpuEW9JKa+CuUizF9XO2e4szJPNgUGYACGOZ+7MWA2oy6f79
         dozBMSvT/jXvA5Qq9npjGrMGUoXykvp2178JRvNl4e0c2iMRrbnpV3E68Ro8zWh4Xb7c
         1rUMw8yDV9tXcGDyyZpB9kFx0dSswV7tvlBhaN4E/y27eztgL/2+G688WUYTFOg1smyj
         mi4pHvw+vAfaYFDEl1YYfHqkii6oaw/xHSNm7wJBA4yeVQXevPqxnkEqMnu3CzkfixpF
         Y5bzsI7jJFOBbrlfNqNxfI/M5pUPROEekgSV+FQEI6OMY/cnghVZcbFheP6jZL3IJS8W
         UyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KrhLZLjcVvBluw0AHFWx0sSuZ83gjQTP2KF7cl243R8=;
        b=WqjWRcoQ+Dvg44NMaZpIbfDxwIxl6AXcBIYwCSlA45n2KXOjWquZX++uu8w6EhnMiL
         tcZg7o77AemW98VarQBr2Nn2ZcRVPvKaK2057ZvS2AyE6uSwQWEIsL59Hc1/dFgbleSx
         57B1GFv+eZHWnlexGS+sDJgj41iFl9+SEiyc+QaYOh5Ydd4NzPgm/TFY60zAvw/7dgM0
         woFb7jDlP4AJisfgyzoHhvHAawbVC0cuKly6FxnboO+C/Xs9uYNlgmOjmWcqUT3GHp8j
         iRhQZsfDd8NlJJsmSDKUGjSS3Fond3/FvBygvGnr5ygYfnWAShK0a0PBHn4TwZsT01PL
         AtnQ==
X-Gm-Message-State: APjAAAUoF7gWdOBWAIl4RDhmCYHeuxy1EANKEKP9OnU2BGhPELpE0B6U
        CEG6UZs2RDRAdprqn88xmYszT1w75KE=
X-Google-Smtp-Source: APXvYqxpej2kAJ6J5u4GIogW/YF21n0ShRan+b9TP/YyaIz2IyU8tcCt0jodUEi34NHfAF6HsXKtoA==
X-Received: by 2002:a63:754b:: with SMTP id f11mr9787896pgn.32.1557449254512;
        Thu, 09 May 2019 17:47:34 -0700 (PDT)
Received: from MBP.local.hk ([175.159.177.114])
        by smtp.gmail.com with ESMTPSA id r29sm6940719pgn.14.2019.05.09.17.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 May 2019 17:47:33 -0700 (PDT)
From:   Boxuan Li <liboxuan@connect.hku.hk>
To:     git@vger.kernel.org
Cc:     Boxuan Li <liboxuan@connect.hku.hk>
Subject: [PATCH] doc/gitattributes: add Octave
Date:   Fri, 10 May 2019 08:47:15 +0800
Message-Id: <20190510004715.29298-1-liboxuan@connect.hku.hk>
X-Mailer: git-send-email 2.21.0.777.g83232e3864
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`matlab` pattern is also suitable for source code
in the GNU Octave language.

Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
---
 Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 4fb20cd0e9..1b28381bda 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -819,7 +819,7 @@ patterns are available:
 
 - `java` suitable for source code in the Java language.
 
-- `matlab` suitable for source code in the MATLAB language.
+- `matlab` suitable for source code in the MATLAB/Octave language.
 
 - `objc` suitable for source code in the Objective-C language.
 
-- 
2.21.0.777.g83232e3864

