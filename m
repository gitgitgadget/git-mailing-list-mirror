Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E42412018D
	for <e@80x24.org>; Tue,  9 May 2017 19:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbdEITYC (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 15:24:02 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35119 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdEITYA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 15:24:00 -0400
Received: by mail-pf0-f178.google.com with SMTP id v14so4607854pfd.2
        for <git@vger.kernel.org>; Tue, 09 May 2017 12:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=978T3VX1Q06j+KFJs8ayoTawCXRSgCgeeQazYI6jPwg=;
        b=hu0WrmOwe41UhzY0RfeEacgNoF2Oz537NtKXfoAdSkXAyyq8AsQ46KxlKozRBdR/9P
         IiKqebqW09BHcj41KxagO4xP0uetgbUJ3gVBAFMzrhrL6IxmN9xHQPTZMmxOyClaTOxy
         9wkz45c288LXJMlPcYGq8PULjkQKudPvimQTGQ7jX6SGwrM7hunI3CuOQnjCK0if013U
         PDy20MgOhBtx7+qwYNUur62fyJNXmSTW8AhZmkcnIkgoBeJHg8CJZkMYzVufHDX1zSLw
         xDJUdcUn/hDkel7og8lFHjt0x56eL9owTjn/QRV4TFFWMXdN2aFMCrw9TeIb7rjFFhyH
         DmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=978T3VX1Q06j+KFJs8ayoTawCXRSgCgeeQazYI6jPwg=;
        b=ndL3PfS80QuQTd6JRwXpqUxoM4Xj9eMMDK65yw2K7c0ehuUy8U5FVmM0pGVWxzVCyk
         TPzilDQNMxzdTplKWdTNBLll/pCp4RnlWSoF/tRXTGmttb7hJTw6W09FYuPujtjBomaD
         o2b0936AaQLPRZ9+EmXKX+WJSGdbs8d/UT3EYs/uvJY7mlmvNm24Moxt6bESMpRYHo+8
         MJ3BO8roT3J4yL2jTXIH9MM2PuCFLahwVH4oy2Byh/rV4k9W06gPCm4zhdZdQfObB6V3
         yjWgr/0a9a7OYLXGC3R2T2v+AOEcskteeWK0W7sUnECfgX5zXHWLZZlCzvhMy20LDMI6
         0BwQ==
X-Gm-Message-State: AODbwcB1purU7797kX5OIROa3qIUTgx+COEFOBltovdHoXA3+vl9lVKB
        IACHR9hwTWINt6se
X-Received: by 10.98.160.130 with SMTP id p2mr1779933pfl.184.1494357839997;
        Tue, 09 May 2017 12:23:59 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id s18sm1296073pfi.16.2017.05.09.12.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 12:23:59 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v3 1/2] docs: correct receive.advertisePushOptions default
Date:   Tue,  9 May 2017 12:23:52 -0700
Message-Id: <3d79124df1e235e1819cf16a41ecec27391f8609.1494357692.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <cover.1494357692.git.jonathantanmy@google.com>
References: <cover.1494357692.git.jonathantanmy@google.com>
In-Reply-To: <cover.1494357692.git.jonathantanmy@google.com>
References: <CACBZZX5DF6sTTYSUpYnvas925N-XsoUGrM-bYbAN_67g8-w2GQ@mail.gmail.com> <cover.1494357692.git.jonathantanmy@google.com>
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
index 475e874d5..3a847a62e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2620,9 +2620,8 @@ receive.advertiseAtomic::
 	capability, set this variable to false.
 
 receive.advertisePushOptions::
-	By default, git-receive-pack will advertise the push options
-	capability to its clients. If you don't want to advertise this
-	capability, set this variable to false.
+	When set to true, git-receive-pack will advertise the push options
+	capability to its clients. False by default.
 
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
-- 
2.13.0.rc2.291.g57267f2277-goog

