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
	by dcvr.yhbt.net (Postfix) with ESMTP id 25F741F461
	for <e@80x24.org>; Mon, 26 Aug 2019 15:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbfHZPVy (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 11:21:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36036 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731140AbfHZPVy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 11:21:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so16270587wme.1
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 08:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MgurBnRBMwz4atPXZ5DvIISqC8zDzciWCEjPmfclH8A=;
        b=WKcHcfT860oZ8xFSoW2V/HiDQqLOS2H4GZZsDqlfJsHk3ge/tFPs4FsXhwdlF0Z8va
         GOnU0YxWHCtJRn6dnztgIM0heGkCHO3eU/nrXfBfIoouqSGN0yXd9N5zOTsCtYDfuO5A
         mvPS82KewAIFxOznhiiDKpz5+tCEZqjBWWdynLbVQchQWZCZV/EYH2x1KSKR3BRRFk6P
         /v68cAuo5SbqroE1nLqiiTyGE8cAPejwp8pJUbXMDxN98oNC4JGNoYAz98ELr64tL9H/
         XUBvkxH2G9uwB2ROOYD7lgJdBc4Bfu+/rdE0yP95c5gCoF/PRoxQGib3CsOe0CEXzZbJ
         Eqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MgurBnRBMwz4atPXZ5DvIISqC8zDzciWCEjPmfclH8A=;
        b=huDhMQ9WHOQVzZTQdykPykqKHchn8AJHcTb1kYX+QLw+9e7gacwA3TCBQxEWPq4fgG
         00STFPgUgTZy+TeaWJTDytivMyMcZ2mfC9WqWttP42Eoji26DQQUvYAFL6N3ond0qezN
         DQFgX3FQxtSaiC0gz6sibQMfIWJaGc+GGq85AtufhPZE9dPC+oM0dkSIRIiQFJmeo45e
         XdEvWWZSWcWMxAxuFHlCIr8TD3rvG9nspUBYuUp7m+nQOdaWYhTLpQHI1DObddWqE/mV
         +x9WMTjziYSZJkgpBNX6hKGNFVqBK6G6Oxr5EmSccHVuQ7AN6dPaNEjsLs0cL2hDPlGC
         e06A==
X-Gm-Message-State: APjAAAW+BYhZmb6l1dBZzjv16jRmz/0BBbZYhOG1UYDVcJJkOR3Uhbu9
        0zVrMF/tEWuYGD+nP1djB7a1iHo5M0I=
X-Google-Smtp-Source: APXvYqwusLP/XRX/0gII/moOzYbhg9ZDHgAfQ7j9Qt1BtN/Nc6byn5vuYiQ9fUBNsjhKKyDxf1iD/w==
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr22362039wma.53.1566832912390;
        Mon, 26 Aug 2019 08:21:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c11sm9663663wrs.86.2019.08.26.08.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 08:21:51 -0700 (PDT)
Date:   Mon, 26 Aug 2019 08:21:51 -0700 (PDT)
X-Google-Original-Date: Mon, 26 Aug 2019 15:21:49 GMT
Message-Id: <148e4c1f06ebf86664cd7fa3007fa9e09962c95d.1566832910.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.322.git.gitgitgadget@gmail.com>
References: <pull.322.git.gitgitgadget@gmail.com>
From:   "Andrey Portnoy via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] banned.h: fix vsprintf warning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrey Portnoy <aportnoy@ucsd.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrey Portnoy <aportnoy@ucsd.edu>

Previously sprintf was the argument to the BANNED macro, where vsprintf
is expected.

Signed-off-by: Andrey Portnoy <aportnoy@ucsd.edu>
---
 banned.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/banned.h b/banned.h
index 447af24807..60a18d4403 100644
--- a/banned.h
+++ b/banned.h
@@ -26,7 +26,7 @@
 #define vsprintf(...) BANNED(vsprintf)
 #else
 #define sprintf(buf,fmt,arg) BANNED(sprintf)
-#define vsprintf(buf,fmt,arg) BANNED(sprintf)
+#define vsprintf(buf,fmt,arg) BANNED(vsprintf)
 #endif
 
 #endif /* BANNED_H */
-- 
gitgitgadget
