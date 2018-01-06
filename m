Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A945F1F406
	for <e@80x24.org>; Sat,  6 Jan 2018 18:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeAFSqw (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 13:46:52 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38738 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbeAFSqv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 13:46:51 -0500
Received: by mail-pf0-f193.google.com with SMTP id u25so3562772pfg.5
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 10:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ohTWLm94dxi8UTP45FSXWHLgD+5gs7l+eeUDk3/9FBg=;
        b=EW8m2DF2sysjWgFkGBKY7UZR+9p7fOo/zLYE3sPwHpRN2W0w60j95VgaTbe4xhDpc5
         TLabzKkEqbZJQFrnKrzsx0CmN09xfBw3EcoKefTDGaPWqAPGbvZ4q0FuJHwEgSjX29mi
         7oeuMx01f3CUXugfOct008s/EGR1GlkzZJBD2Az02s+E+phnnyV1bzK+uls3EbokkZKi
         /BbdR3vHTRAkUEVXhGEQ5BAchI4jsDEc4ryCFs6MPSQ2g1QzKBstck+E52cRlZUrfL4J
         LXrmYPwWLGEFuqgt/VGZOpYrWXV60zoQjoS5xKZf5IBGnXpSSTP9rJBRFY/0r/FLgNxq
         0ypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ohTWLm94dxi8UTP45FSXWHLgD+5gs7l+eeUDk3/9FBg=;
        b=TX5YWtEbhPQTSPW6Nk78fWwOAJNzy/TCj6ZRdoEZ1w6bhWDERHBcjtk0amXoqePMJJ
         WQ2PWz9AJH3h1OVWKQz4Mllx0XzfIpBEq140VYBXpvHaxOX2YChj5n+T3cebNpEMzF4E
         p3NZ5AiRhDL9WgZeiuDa84xF6s8kzlATwmW+LrNnhFY8pREihdyRD2N3b0fvPAIrt4lN
         Sh6QWSC3OtSwMFmwb7V0nLuwAVM4yDC6aLRjZRQA27J16U26R0Ei7IcJ0nFPWvHqNN4O
         80iD/CmQ4ekeEUUIeH1ioJhexi1D7r4petJoxWA8jcJErouKpxAzz0tfZeAH7mcs/Wnq
         zhaw==
X-Gm-Message-State: AKGB3mLT2c1JO9No62R8ZTs2QuQRHV9oP2AepjluLKzp4fAuoAEMKbUv
        RNhNzwQQ0ILFyfCuqMO9h+xf0TVO
X-Google-Smtp-Source: ACJfBos/Rg7AyZzX9qTSJELNwKBee+uGxHatgMqTj9DdBUIrM22oMfQp/b99cnreg6N+aonL9bSF9g==
X-Received: by 10.98.220.195 with SMTP id c64mr2597645pfl.47.1515264410296;
        Sat, 06 Jan 2018 10:46:50 -0800 (PST)
Received: from localhost.localdomain ([117.246.198.31])
        by smtp.gmail.com with ESMTPSA id j14sm21141273pfj.93.2018.01.06.10.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jan 2018 10:46:49 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/8] Doc/gitsubmodules: improve readability of certain lines
Date:   Sun,  7 Jan 2018 00:16:12 +0530
Message-Id: <20180106184614.20115-7-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac8367
In-Reply-To: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Documentation/gitsubmodules.txt | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 745a3838e..339fb73db 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -76,9 +76,10 @@ The configuration of submodules
 Submodule operations can be configured using the following mechanisms
 (from highest to lowest precedence):
 
- * The command line for those commands that support taking submodule
-   specifications. Most commands have a boolean flag '--recurse-submodules
-   whether to recurse into submodules. Examples are `ls-files` or `checkout`.
+ * The command line arguments of those commands that support taking submodule
+   specifications. Most commands have a boolean flag '--recurse-submodules'
+   which specify whether they should recurse into submodules. Examples are
+   `ls-files` or `checkout`.
    Some commands take enums, such as `fetch` and `push`, where you can
    specify how submodules are affected.
 
@@ -90,8 +91,8 @@ Submodule operations can be configured using the following mechanisms
 For example an effect from the submodule's `.gitignore` file
 would be observed when you run `git status --ignore-submodules=none` in
 the superproject. This collects information from the submodule's working
-directory by running `status` in the submodule, which does pay attention
-to its `.gitignore` file.
+directory by running `status` in the submodule while paying attention
+to the `.gitignore` file of the submodule.
 +
 The submodule's `$GIT_DIR/config` file would come into play when running
 `git push --recurse-submodules=check` in the superproject, as this would
@@ -107,13 +108,13 @@ If the submodule is not yet initialized, then the configuration
 inside the submodule does not exist yet, so configuration where to
 obtain the submodule from is configured here for example.
 
- * the `.gitmodules` file inside the superproject. Additionally to the
-   required mapping between submodule's name and path, a project usually
+ * The `.gitmodules` file inside the superproject. Additionally, if mapping
+   is required between a submodule's name and its path, a project usually
    uses this file to suggest defaults for the upstream collection
    of repositories.
 +
-This file mainly serves as the mapping between name and path in
-the superproject, such that the submodule's Git directory can be
+This file mainly serves as the mapping between the name and path of submodules
+in the superproject, such that the submodule's Git directory can be
 located.
 +
 If the submodule has never been initialized, this is the only place
-- 
2.16.0.rc0.223.g4a4ac8367

