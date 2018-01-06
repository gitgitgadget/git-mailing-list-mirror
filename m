Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45E981F406
	for <e@80x24.org>; Sat,  6 Jan 2018 18:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753099AbeAFSqp (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 13:46:45 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34890 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753059AbeAFSqn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 13:46:43 -0500
Received: by mail-pl0-f65.google.com with SMTP id b96so5123186pli.2
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 10:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=8QlVspJG8pfB5JckMpbC1A7XJPLK4d5J4jTilDb64q0=;
        b=K5NhoydSqaLWTsVJKqMg2ns3J6UnXLKtLx+LCS63Y9Dtfx43qsac0tpteFz1APK/eK
         /wcUDiFfqv2Xwv613WpUFOKhTze+eKf9wI5tlEdiW4zhSk40UtvVialsuGNam1L6Dj7f
         6+Bo/i+dlWI39nYBI35k7ytfCZ4+h4khjgaJEnujydN1ERQo69zAOw5ofON/XyQSjHXy
         MBDOYNdiRyBfUbGvH+tqR6KXCeKl9InLHN1k++bjMwK5R7ZqN2cJPmsod1S4eIjcprwF
         KYR8nCURH2UaTcd6ep1jpe6d6CMXUnDW9Mf4KD3roYFYuShmQIS5ajAG5K3BH+vFaMjR
         R6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=8QlVspJG8pfB5JckMpbC1A7XJPLK4d5J4jTilDb64q0=;
        b=aW3nNSZf1l3Fly6FwJyQ9CmmEYDpcBeE8SUIVe46UOIxa2D6izdwNlpwOlosg6PLra
         5nJ50W0CWrB82KJVbBifvio8L2r0W/rYZ3I8UQt80uAllyQYv2UluFSLz/GHK4BO86uq
         qakdG64J4leXka33tsIRNPblc+svo0b48XcwPh3daMehwbH0HeiLv4d9jwpHPAU0On1c
         EMtNTIjl5NrALa3j1mmU+N8jIOx4Z2EOJXKVgXTj4XWHvHa3XmbWLG9b9ALlE4CNhWES
         /mHJUDssAJYlewwpBhrDpAVAnCAdnxRa7SW02PiO8o4rbwvL/QcDwFmnnBFnrGR+3uLH
         likg==
X-Gm-Message-State: AKGB3mKUYsddnp0Ocklk6jg+N80nd7vUYBMjc4QETHAJp4x+x32CpGsY
        3fs9krfTQlfrjcaNoZlLESNu924Z
X-Google-Smtp-Source: ACJfBosapto8hRnLwvw06Akhjn5OUlSy9jlVjpwEsi0xDoRxPWlX0bPG5r166eqcQj2nUcfmKtFNag==
X-Received: by 10.84.214.8 with SMTP id h8mr7243174pli.148.1515264402546;
        Sat, 06 Jan 2018 10:46:42 -0800 (PST)
Received: from localhost.localdomain ([117.246.198.31])
        by smtp.gmail.com with ESMTPSA id j14sm21141273pfj.93.2018.01.06.10.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jan 2018 10:46:41 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/8] Doc/gitsubmodules: specify how submodules help in reduced size
Date:   Sun,  7 Jan 2018 00:16:09 +0530
Message-Id: <20180106184614.20115-4-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac8367
In-Reply-To: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Documentation/gitsubmodules.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index cb795c6b6..3f73983d5 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -63,6 +63,9 @@ Submodules can be used for at least two different use cases:
     * Transfer size:
       In its current form Git requires the whole working tree present. It
       does not allow partial trees to be transferred in fetch or clone.
+      If you have your project as multiple repositories tied together as
+      submodules in a superproject, you can avoid fetching the working
+      trees of the repositories you are not interested in.
     * Access control:
       By restricting user access to submodules, this can be used to implement
       read/write policies for different users.
-- 
2.16.0.rc0.223.g4a4ac8367

