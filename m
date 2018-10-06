Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3FEC1F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 04:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbeJFLZL (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 07:25:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36721 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbeJFLZL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 07:25:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so3548766wmf.1
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 21:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:date:from:to:cc:message-id;
        bh=Bz9p/izyxUu015r/vx6vRhGYheBYOH6j4kkJTTrZmtU=;
        b=mSnR9i0XddeVI4yGtMEFptBhKAnuv6jhd9XAKqFeQ5FLzFJBGxJ4T35tCGywybJhDR
         V+Ur9/m0j5xsN6hGOjM8MDSSY9CJKjbArhmmkYtcz9iwdO6rOO55gPj5+JSlkwwlrJJ0
         I9F+1l1DYgHhvE/bl0OBKkxI1COVYyXdP0Ar67vAGMFHnaWYdURftHX1fYVEl3KB/JsB
         AdB7rbm/5hyUdIQq31D17/+maaZBVrQYjCOAppry41gfV2ivcCori7hta4cmaQAHJJT4
         M23OS4l0jUFVo15Sc9KOV8SF9TMA4EB7zKt9PIgRxG1NxNnKNUCWStzsvhQnRnKf5Quh
         Jz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:from:to:cc:message-id;
        bh=Bz9p/izyxUu015r/vx6vRhGYheBYOH6j4kkJTTrZmtU=;
        b=OLRcDzFeqOaW6nYQejPji8NRddnvO8QErfRjtNXjyLUQU38UNOgMBBMm9ZEwh/Y8nw
         xSDiI8kFdyhdYwbizH0H30IMvemwDTweEgjCFbytcpGY3LONZWVueC4sG4Gqg5Ah0VN+
         tj8PTAGecIUGIyJ6Fj3JJl1gEngh6FOhvYj3UFAETgjXePqmxQP1tiAkctF2ZwZnm9yW
         Bthnr6BovQvCeh4GThAA3kTYLHSUFKl7TphyJULanFkTyNKs//F3kXrUHaXN0Vxr2E1A
         KKZjugEby4w4zVSuIZTLxGUk7b+R9DyjaYUZ/ogW1bK9qTEb8NYjgPPGdk0rkX/4Ko7F
         F9xQ==
X-Gm-Message-State: ABuFfoixKyM7rko/s8eWwcYUvo2sOOXFtvNvccAxZoKp9F77nAaihtIy
        gnIfz9HVTOP8HSmQqXHq4QteLo5n
X-Google-Smtp-Source: ACcGV62T728F7d3t7Ul+P031l5Rz4aZQaNnTketkfpT3Cf6yS6zn/HLbFScxBPORsVWhcNIHqbfQyg==
X-Received: by 2002:a1c:1dc8:: with SMTP id d191-v6mr9326190wmd.27.1538799802499;
        Fri, 05 Oct 2018 21:23:22 -0700 (PDT)
Received: from gmail.com (tor-exit.critical.cat. [46.182.106.190])
        by smtp.gmail.com with ESMTPSA id b81-v6sm3658180wmh.47.2018.10.05.21.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 21:23:21 -0700 (PDT)
Subject: [PATCH] docs: typo: s/go/to/
Date:   Sat, 06 Oct 2018 04:20:09 -0000
From:   Michael Witten <mfwitten@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <33ea76c11d984c45bc837207e85e89bb-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/technical/api-history-graph.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-history-graph.txt b/Documentation/technical/api-history-graph.txt
index 18142b6d29..729d6a0cf3 100644
--- a/Documentation/technical/api-history-graph.txt
+++ b/Documentation/technical/api-history-graph.txt
@@ -80,7 +80,7 @@ Calling sequence
   it is invoked.
 
 * For each commit, call `graph_next_line()` repeatedly, until
-  `graph_is_commit_finished()` returns non-zero.  Each call go
+  `graph_is_commit_finished()` returns non-zero.  Each call to
   `graph_next_line()` will output a single line of the graph.  The resulting
   lines will not contain any newlines.  `graph_next_line()` returns 1 if the
   resulting line contains the current commit, or 0 if this is merely a line
-- 
2.18.0

