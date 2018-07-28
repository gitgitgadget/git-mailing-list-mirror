Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2AAD1F597
	for <e@80x24.org>; Sat, 28 Jul 2018 21:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbeG1Woa (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 18:44:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34731 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730551AbeG1Woa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 18:44:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so2923233pfi.1
        for <git@vger.kernel.org>; Sat, 28 Jul 2018 14:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7gWEO30ZKzgTmd77axeW3GLF6F6gEZnOHmXbrDYUfzQ=;
        b=FKQTvBTFUGvumejipXUXPdILsb3QYcmrKUtp2NOpNZqGYhF50+rLQNdAZWi7dOX46t
         SpEnv5rAGSF2u2giOmctUZ6fZNdKpw1vJxjRugDVr6H9q0mvyn22Jgatf2Nb7VYF9YTP
         XQkYVthmVmJmEpICWxOJLTrO/F09/MJcGZdZEfoZSm2XXu6uYFD5e8/qyU9G+JQ8uTw6
         dPc8feeEd4Wn+cMnXCZmaK3G9ZuQte2tHgUJtVhG+KoOpXrPv3AYoijzFbfOS1+tDeGL
         FU40tc4KlloT8EuoRXLf68adevW3PzWhzSAG4raBtIf8h/XFlGQe+ANDKoBbJi7N5MQJ
         1ySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7gWEO30ZKzgTmd77axeW3GLF6F6gEZnOHmXbrDYUfzQ=;
        b=SiCgLeSiDRiVFiPuT91B/AZcj2wTPsUgvYzxeeXrREwu755Tg/Wwb2k96R3T3cqaFN
         WRLdttL56qVgUvSRTFJ/pEtGY9dxX4fAxbnN1jjKXEIygVlIhj1Jf+lfMJRUMgACyrVm
         G6kbfGMPcgeCGx3QaDKPvVQVsVET286mamrDrChNokqMTn8dWOg+3uC4ozvoTV3OWiqD
         nVee2wd2Dxm4KiP+BVo9W7G7p6MfRbSmuGReJnhMJWB3aNjQLhemMYGMb2mZ1IrslpFd
         RuyrgI8srqa7H1nwXtdH/CN2jXXhBXcmcSpJkbZnsGFRCAWvaOdGSmmSk2PTdPhM082I
         3Isg==
X-Gm-Message-State: AOUpUlHWrL+SKpL77dw+pSO/1a3ZTLIF3zHqWIlrS5sZ85NrLbgnRHoA
        mVAvGTvziZMZnLen5ssixSdwq4FZ
X-Google-Smtp-Source: AAOMgpflj/W7afKqWagie3LWie1z350XNy45y3p/0BiXkspIiX5/0sheYOzsip97YhdtTe2G1sRCHA==
X-Received: by 2002:a62:2b4c:: with SMTP id r73-v6mr11938641pfr.134.1532812600354;
        Sat, 28 Jul 2018 14:16:40 -0700 (PDT)
Received: from localhost (c-73-223-63-143.hsd1.ca.comcast.net. [73.223.63.143])
        by smtp.gmail.com with ESMTPSA id y3-v6sm9835400pge.29.2018.07.28.14.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Jul 2018 14:16:39 -0700 (PDT)
From:   Masaya Suzuki <draftcode@gmail.com>
X-Google-Original-From: Masaya Suzuki <masayasuzuki@google.com>
Received: by localhost (sSMTP sendmail emulation); Sat, 28 Jul 2018 14:16:37 -0700
To:     git@vger.kernel.org
Cc:     Masaya Suzuki <masayasuzuki@google.com>
Subject: [PATCH] doc: fix want-capability separator
Date:   Sat, 28 Jul 2018 14:16:30 -0700
Message-Id: <20180728211630.29573-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.18.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unlike ref advertisement, client capabilities and the first want are
separated by SP, not NUL, in the implementation. Fix the documentation
to align with the implementation. pack-protocol.txt is already fixed.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 Documentation/technical/http-protocol.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 64f49d0bb..9c5b6f0fa 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -338,11 +338,11 @@ server advertises capability `allow-tip-sha1-in-want` or
 		       request_end
   request_end       =  "0000" / "done"
 
-  want_list         =  PKT-LINE(want NUL cap_list LF)
+  want_list         =  PKT-LINE(want SP cap_list LF)
 		       *(want_pkt)
   want_pkt          =  PKT-LINE(want LF)
   want              =  "want" SP id
-  cap_list          =  *(SP capability) SP
+  cap_list          =  capability *(SP capability)
 
   have_list         =  *PKT-LINE("have" SP id LF)
 
-- 
2.18.0

