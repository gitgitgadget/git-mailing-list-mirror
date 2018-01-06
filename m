Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 858051F406
	for <e@80x24.org>; Sat,  6 Jan 2018 18:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbeAFSq5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 13:46:57 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35207 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbeAFSq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 13:46:56 -0500
Received: by mail-pf0-f193.google.com with SMTP id t12so731619pfg.2
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 10:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=rgrD0NKt08H0CgH2kJ6JQnBFCDrfAhaOaUUooxOw4gI=;
        b=AFZA60Af3ZvaLqldAb+GvaRGh+VmdO874igC6pOx400sGCnRdGde7eoLsVcIYooMQM
         QamYYY/k7NLtke5GJYvg9stk8vr+Uida+TCSmyg0F9HYX6sGnKMe4HZqd3CHKhwbT55O
         pj8ifH+47e90c3p6wvvDUpDcVnjgOI/u93BL9sWQLp4BaJzoDPq35dJIFLOspA+j0/2T
         h7SQrQIAkD0IpVVZJdQCjzTA2pP+/uIKbmqiRsfPnWYkPJRrU1p9EMlkV3QwLTLekInz
         DS3oX5OZB1rNXJ1O2PJM8mHziT89xe8Oj7Ko8c277DF18NK0dXhXUUBZC00l+qyMAj2E
         QXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=rgrD0NKt08H0CgH2kJ6JQnBFCDrfAhaOaUUooxOw4gI=;
        b=XVJx6k9EaCI4EKnunB5kfJ/ZcBRwcBik1t4ThJKZvSIySiC8eSivrH6GTj6P1HaPgm
         +GVUz601NoQnMMG+GdWD2hV+VYWK+YpnNkwNbMoxE2aKbLaKwysBbHmJlFT7eGiJmpqK
         0VGDRG8gtJJTcVBh48K3nLMR36EU7kLkb3AUk5teepBMEyiSLAjhb8karcR1Fo+UH3Hp
         9ulmbtFTzS+MnNta8bg0DVvGgn0hybZpBzyPjXKm7upIT0EBMClyaXZvaS29bWKpvJDx
         W4yLEyzS6ZCrzWQpl3mtvwaOJemE2+Cj6iZRGijQi8HAjgVMP49wUpQM+bReW21Tmq9P
         1aAA==
X-Gm-Message-State: AKGB3mIXY1iY0lsP86cMj3vKPamR1ORZ+a/LSijLPvEyLtmHgK9FfpAH
        h3SV/BURaw8/LeEpqlx9v46vTioiHbk=
X-Google-Smtp-Source: ACJfBovibwsRTzSqnJwzUM5j9KPHlkoSA6opng9uBw1mb9JXkipWyitRvMofcQtUJr7ATacmibFajQ==
X-Received: by 10.98.254.24 with SMTP id z24mr6521625pfh.48.1515264415745;
        Sat, 06 Jan 2018 10:46:55 -0800 (PST)
Received: from localhost.localdomain ([117.246.198.31])
        by smtp.gmail.com with ESMTPSA id j14sm21141273pfj.93.2018.01.06.10.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jan 2018 10:46:54 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 8/8] Doc/git-submodule: correctly quote important words
Date:   Sun,  7 Jan 2018 00:16:14 +0530
Message-Id: <20180106184614.20115-9-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac8367
In-Reply-To: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Documentation/git-submodule.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index befbccde6..5c4d941cc 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -132,8 +132,8 @@ expects by cloning missing submodules and updating the working tree of
 the submodules. The "updating" can be done in several ways depending
 on command line options and the value of `submodule.<name>.update`
 configuration variable. The command line option takes precedence over
-the configuration variable. If neither is given, a checkout is performed.
-The update procedures supported both from the command line as well as
+the configuration variable. If neither is given, a 'checkout' is performed.
+The 'update' procedures supported both from the command line as well as
 through the `submodule.<name>.update` configuration are:
 
 	checkout;; the commit recorded in the superproject will be
@@ -150,8 +150,8 @@ checked out in the submodule.
 	merge;; the commit recorded in the superproject will be merged
 	    into the current branch in the submodule.
 
-The following procedures are only available via the `submodule.<name>.update`
-configuration variable:
+The following 'update' procedures are only available via the
+`submodule.<name>.update` configuration variable:
 
 	custom command;; arbitrary shell command that takes a single
 	    argument (the sha1 of the commit recorded in the
-- 
2.16.0.rc0.223.g4a4ac8367

