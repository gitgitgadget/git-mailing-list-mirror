Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63722207B3
	for <e@80x24.org>; Fri,  5 May 2017 23:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbdEEXqw (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 19:46:52 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34351 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdEEXqv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 19:46:51 -0400
Received: by mail-pg0-f42.google.com with SMTP id 12so9637426pgc.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 16:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=BUx7WMX0fvuW5nZVxDekLDx3CVSxcmG8K/j5/eBNtfw=;
        b=dXFOnIrSkeIM1c41GsZhPB+fDHRsPcdD29xz4p7jPmTlJtBGDXPenJI/dkxbkvXZCQ
         L+03Mm7Fg+rYIoqpN4t75Rwnpwx2d5Qdakyh4Z48SBP5FVcjxLHtWod160U3K8Esty78
         s+5Or823/V0Wqn4DjxRGpKSdZg1VVp9hbLtZ3Du0Gp6dbdDYRid/vSpvvOVNJl9JWw4r
         2Iq/iKAnmn/XDMMEphoYZopV9uHG91zGFadqU0X3HY/6jKc8iADj8VT+0kwEVYq+0rpk
         DEBiVmvIxsdRlsth0HCmVg5FSrguczQKVVtLIqgVwfV8hvVq5JmgWbnbAMtPh8Eb/Te3
         rDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=BUx7WMX0fvuW5nZVxDekLDx3CVSxcmG8K/j5/eBNtfw=;
        b=UoDO/B6vCx8n7gGzFpB9Qp+n9d5V7RJU4RS7dJqBM4Jhj/+KMoGMomBhJBzuicmibZ
         Rr3H5OzOjjOuDxSEj8gv+YLVt59VQOurOH/8j+LAPiSTq6QKwoFYV+41ahdlsQ6gaHlM
         PXHakBj0ZJI9y0R43U+lm4KepKgtAWVjh1Q6DfKNTR8lB9j4Az7roNOY23Sdt2u6AVvv
         ElnXbSR70ryU+iH1RMkukHn0EnOPKHmtdMl6IOjt9Xf830C3D5+bvnjaS9gyLXGkovvd
         MIpYIA5P3tNoFqREqeLHCKl/ZbBPN1VVv2td/ETL79abM26WGXmrdBIRJ50mYClGeNlv
         vZtg==
X-Gm-Message-State: AN3rC/6ZJqfduHiXq4VRiEbD1wd++HNFIZF4KD/XOBRrWANR4mBkTMu3
        WrPRUpu/byqQEd0a
X-Received: by 10.99.160.68 with SMTP id u4mr6303254pgn.39.1494028010903;
        Fri, 05 May 2017 16:46:50 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id c77sm11096576pfe.37.2017.05.05.16.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 16:46:49 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [PATCH 1/3] docs: correct receive.advertisePushOptions default
Date:   Fri,  5 May 2017 16:46:42 -0700
Message-Id: <28c40105e53a4d4d828092bc1697fff8992419d6.1494027001.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <cover.1494027001.git.jonathantanmy@google.com>
References: <cover.1494027001.git.jonathantanmy@google.com>
In-Reply-To: <cover.1494027001.git.jonathantanmy@google.com>
References: <cover.1494027001.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit c714e45 ("receive-pack: implement advertising and receiving
push options", 2016-07-14), receive-pack was taught to (among other
things) advertise that it understood push options, depending on
configuration. It was documented that it advertised such ability by
default; however, it actually does not. (In that commit, notice that
advertise_push_options defaults to 0, unlike advertise_atomic_push which
defaults to 1.)

Update the documentation to state that it does not advertise the ability
by default.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/config.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d5..f49a2f3cb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2620,9 +2620,8 @@ receive.advertiseAtomic::
 	capability, set this variable to false.
 
 receive.advertisePushOptions::
-	By default, git-receive-pack will advertise the push options
-	capability to its clients. If you don't want to advertise this
-	capability, set this variable to false.
+	When set to true, git-receive-pack will advertise the push options
+	capability to its clients.
 
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
-- 
2.13.0.rc1.294.g07d810a77f-goog

