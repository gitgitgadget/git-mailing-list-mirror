Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB1451F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 00:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfJOANU (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 20:13:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39733 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfJOANU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 20:13:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so21598393wrj.6
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 17:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cXfFX1QtUSkrVZK9tO2zjxDy+XfzfP4gMFSLK3c48t4=;
        b=el+Xvy0TAo70ckredau9wzOrHHKaTwwpz18QeOe7xZrgQrxy3hwWwSZ586GN9ERmD0
         aaDYDSLCSJXQiOHnX5fYUhK8lRC+OuAtdMAUsujHwRh9XSoU9OLT1EbYJ+6GCL9S7xp/
         lf1MPd+wbnou4x55YDQhUL/S7uYr5jRXqrT80GGElJ1+g6Zy1a8m1Nq49EVOl4AsKs42
         fYxzzaQgWsizN68zV+V6gxjjwD7j839wNKTfXDySFAQeOMaU0/mkOaQ+C8H1Uztt/v9s
         Zw28PzhTBZAm3EY80g9u4RkWd7q9jShexVRP7dYMxE0JsOBpHf9fj+3d23R9UD1PXzvy
         QDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cXfFX1QtUSkrVZK9tO2zjxDy+XfzfP4gMFSLK3c48t4=;
        b=gH8loMjL/XLtCw5g5xDMOicqFkawjHgCVvpJjc4L8LdP7boaW5GLmRvLp0m9NSManf
         /bmtIQMnlS8kejbg0SD73c1M07R5gLxHbnaHn9+I3jWzaT/oeZGiEjivfqGa4hxWmvdE
         Jcv71Yqr3jHDR9Rah3rQN0upbHXOiXeYvagMreXNYSv+sFBtld0v1q33rf+s4kuB8wHb
         d+gfKafG+u3wX299EUxBsBZWcoegYHfrk8HFGHzDb+0QcyXFEtGhXsfl5X3VS2xxUPQk
         E33uqQCt5ojTNwkaX4ufdm6+RnySp4Il1GaPKpJI+4uEoBInV5tM0Dz4ztBH7Mms7kvj
         Xx5w==
X-Gm-Message-State: APjAAAWuaCAcLLbOfWi82STVO0hANrTvuIcpdY1dV8v+8c2Oqg1Y4eqN
        vGAokOJ3B2uTTmjJDdtfvIo49/lF
X-Google-Smtp-Source: APXvYqyPjRbjQllIpCY0DrfVfKx/LPcBDkCiCOy0/aAWLDHKgMEwrmHUY/90Z8FmCZD1g9CQTvcWKA==
X-Received: by 2002:adf:ea01:: with SMTP id q1mr8569606wrm.240.1571098398113;
        Mon, 14 Oct 2019 17:13:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9sm23749567wre.74.2019.10.14.17.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 17:13:17 -0700 (PDT)
Message-Id: <364976a833e33696e983bbdd9c1e7974480c1397.1571098396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.389.git.1571098396.gitgitgadget@gmail.com>
References: <pull.389.git.1571098396.gitgitgadget@gmail.com>
From:   "Eric Huber via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 00:13:16 +0000
Subject: [PATCH 1/1] gitk: Preserve window dimensions on exit when not using
 ttk themes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@samba.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Huber <echuber2@illinois.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Huber <echuber2@illinois.edu>

Bug was: gitk would overwrite the botwidth setting in .gitk with
a nonsense value when not using tk themes. I'm not sure if this
is the right fix or not but it seems to work. Moving the affected
line within the conditional results in the expected behavior.

Signed-off-by: Eric Huber <echuber2@illinois.edu>
---
 gitk-git/gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index abe4805ade..4846f2a983 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2526,9 +2526,9 @@ proc makewindow {} {
             bind %W <Map> {}
             %W sashpos 0 $::geometry(botwidth)
         }
+	bind .pwbottom <Configure> {resizecdetpanes %W %w}
     }
-
-    bind .pwbottom <Configure> {resizecdetpanes %W %w}
+    
     pack .ctop -fill both -expand 1
     bindall <1> {selcanvline %W %x %y}
     #bindall <B1-Motion> {selcanvline %W %x %y}
-- 
gitgitgadget
