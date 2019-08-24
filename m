Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E0A21F461
	for <e@80x24.org>; Sat, 24 Aug 2019 22:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfHXWg5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 18:36:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34569 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbfHXWg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 18:36:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id e8so11706306wme.1
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 15:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8TdPeiwFbGuxF66oVmUppjtAKchqJKNsvl20/Tpf5y8=;
        b=gJDPSDo0IAiPf5k7B10M5PKc8Vdo4oIe2Ieg7I1snxvV2UyblSyNxPeMjhlVZYrA35
         9zXhSLB5A8PEN0De/nmQ7HmyVzGpNoRz/8YrWRIWnGXL7A3aPOr7DYWYWe3AQOyZKXH4
         7TdZGhZ5SBzDwBkHzY1BWIY78Av6lat4iAA+9eFCCxKFe8zjLe/xdLIvC2JVNHUfhHMU
         q51sVMldI6lCKquOBaEiFYT6KxJJRKByd4pn7AHRO5ctbL0SRRhfCeBAmJIpyvFLmX9o
         j8Mcbc0af5zf4dlLbJYyXaddRX4VzRjPEgx3+Wd56Ahg0zVMpHzk3BOLv0SEeoUZ38GK
         aYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8TdPeiwFbGuxF66oVmUppjtAKchqJKNsvl20/Tpf5y8=;
        b=qkvWF4CfLAyk5RhDV6Jz4xSr1K0R2d8QvR1q601pCybznW9a0EoiDrztbbsoNtJHK3
         KXmEnKobSPrP6enofsRupQIBQ80roqfcw00SmxcezQLS4SRmEjrE6llSqYaT4sR05W5N
         esxqNppuHAZv8soeekT3GKkSzK8kvH9g26Vtl/9eAKbVt2EkzXxwxM9KRasYx4FLibj5
         PTpoTFou2OeNvfNQpaQmXOrZct5HO/uDKJepOD8iC6WjusXPPmZ/8EDgFu/deOf0jNn1
         rXUsgOFeMyygzSnuBSV7AUHAnOrpgmu5uHGYWDPWw4ZZO4qYk98zOnOaEsxjUzTRf9V1
         xsWA==
X-Gm-Message-State: APjAAAXz0euQDRsk8AZJYgCEN/r2niWMTpybY8l4Lh5UaKAemzV50ZlM
        gRqFTpz1V+K+pFA0FjFjKxtAsJKf
X-Google-Smtp-Source: APXvYqy0vIrZFUZFgld2myidyuzkEu98kVtyna2aAtilrzndn6FplPP8EiAy/bB3m5AY3eHWv4/aOQ==
X-Received: by 2002:a1c:6504:: with SMTP id z4mr12515093wmb.172.1566686215714;
        Sat, 24 Aug 2019 15:36:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e11sm19514466wrc.4.2019.08.24.15.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 15:36:55 -0700 (PDT)
Date:   Sat, 24 Aug 2019 15:36:55 -0700 (PDT)
X-Google-Original-Date: Sat, 24 Aug 2019 22:36:54 GMT
Message-Id: <c13d9985284d4b452db0d95b6949e02c533db634.1566686214.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.129.git.gitgitgadget@gmail.com>
References: <pull.129.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] hdr-check: make it work on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, we define a specific set of pre-processor macros, among
other reasons: to avoid including syslog.h (which is not available on
Windows).

The hdr-check target did not use those definitions, resulting in a
failure to include said syslog.h.

To fix that, let's let the hdr-check target make use of ALL_CFLAGS,
which does include the pre-processor macros that would e.g. skip the
conditional block including syslog.h.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c5240942f2..b9f00f0ea0 100644
--- a/Makefile
+++ b/Makefile
@@ -2741,7 +2741,7 @@ CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
 HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
 
 $(HCO): %.hco: %.h FORCE
-	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
+	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -include git-compat-util.h -I. -o /dev/null -c -xc $<
 
 .PHONY: hdr-check $(HCO)
 hdr-check: $(HCO)
-- 
gitgitgadget
