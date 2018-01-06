Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4811F406
	for <e@80x24.org>; Sat,  6 Jan 2018 18:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753137AbeAFSqr (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 13:46:47 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41058 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753059AbeAFSqp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 13:46:45 -0500
Received: by mail-pl0-f65.google.com with SMTP id g2so5107773pli.8
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 10:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=MZ14h/OhyCbZk1NSVkNLd+Qu0ckYCtB0aDycA5fpvWU=;
        b=l7Puc9c5D+8Ra71t4Iio2IJ+EYcM5TxPauboJ5ON6a6FuUevpkIInBiH76xFS8wYSF
         JmnH8OoeQPfMlMKP8uopNXT2HVWlWCRf6DhOABraYPzcOXrasVUxf51Vr0UJ2da5Jt4+
         LKekIpx0ebenZo+1MRAJJs12GiQQRATkaGkF1PtDPouC3ywlYSrHJvuptxT2YACiHWnO
         1X+96qO3mQhMjEnXq/CbNn5eOP3LGFOvM7WEUymBVypaHbQuUYXp9bMXITLkiazD5vel
         vH8Ig4yvyCPooLY/DSGUVBaHh+nfRMbMeUVRHiyRutEcYKpzSqEDrBtRM0Cd0fl+gnIj
         pIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=MZ14h/OhyCbZk1NSVkNLd+Qu0ckYCtB0aDycA5fpvWU=;
        b=cLwJlkgqJjXFuEy8HZiXDPTkeoE4WCsHSD4wi6rsEnHj601nS9i2FCcKLAlV6iuZwM
         K1djw3qGyCMiVF+LcNsKjKsIX0nIFKc9ues/T7O/L2LDetgdDK8i5+O8UPMDWOabUM7S
         5CXFVeUc561TjLVHDlJbwVNH13b22ddxYUlOhr/VMG4tZY9WCQrgbVwm+iLsQXplrR1y
         FZBvv4PS+StaxUDVhUdTm+s2BiC5jdG1/b2h5P6IySYwSXDFVXzdricSQvl3YydkatH7
         Q8ZHd9IHMi4fvKr8DJI+EaO7cJEntzGv7Xz4wbt6OQtJqxUM4/+BjoiBcGJh9GzdMcs/
         mqYg==
X-Gm-Message-State: AKGB3mJUASikjY+Gb3GIlMDTYrgTS90csMrDn8Cc7EPfFXVgTRGfxlsH
        eob6BCse7JvEz3rjsvfOgDEyq8WB
X-Google-Smtp-Source: ACJfBos0r2u9Iuy3EL+eGtuqeHz1ur8yZNzgqIiVnM+5E8lUOYubhBmUyxxG4IwwWHQd+LAsVAU0Fw==
X-Received: by 10.84.252.146 with SMTP id y18mr7203140pll.139.1515264405106;
        Sat, 06 Jan 2018 10:46:45 -0800 (PST)
Received: from localhost.localdomain ([117.246.198.31])
        by smtp.gmail.com with ESMTPSA id j14sm21141273pfj.93.2018.01.06.10.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jan 2018 10:46:44 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/8] Doc/gitsubmodules: avoid abbreviations
Date:   Sun,  7 Jan 2018 00:16:10 +0530
Message-Id: <20180106184614.20115-5-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac8367
In-Reply-To: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Documentation/gitsubmodules.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 3f73983d5..e3c798d2a 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -76,9 +76,9 @@ The configuration of submodules
 Submodule operations can be configured using the following mechanisms
 (from highest to lowest precedence):
 
- * The command line for those commands that support taking submodule specs.
-   Most commands have a boolean flag '--recurse-submodules' whether to
-   recurse into submodules. Examples are `ls-files` or `checkout`.
+ * The command line for those commands that support taking submodule
+   specifications. Most commands have a boolean flag '--recurse-submodules
+   whether to recurse into submodules. Examples are `ls-files` or `checkout`.
    Some commands take enums, such as `fetch` and `push`, where you can
    specify how submodules are affected.
 
-- 
2.16.0.rc0.223.g4a4ac8367

