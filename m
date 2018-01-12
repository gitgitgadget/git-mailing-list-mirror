Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F03E61F404
	for <e@80x24.org>; Fri, 12 Jan 2018 10:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754759AbeALKrs (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 05:47:48 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:43945 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754576AbeALKrr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 05:47:47 -0500
Received: by mail-wm0-f65.google.com with SMTP id g1so11135586wmg.2
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 02:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yn29hPekTEHm0ogF3LQuOjvq8pYLDGGmWVpzi1AKGkk=;
        b=sLkqS5PcAQ6PV8VKpopS8O3PcNa96txb5JyDdhA/Fre1/VHRRpGphxrV0lxL8Ho6Xf
         vWrljua7Ox97No5ABtQt229EEaXggHpFndinyXpjjif5JV2l6Xi+i4sGoMoPBiXJTF+C
         N/Qy3yTwpJH7Kf8gfde4CqPbFG2vcIHNU0kKm+28Gy7VmNALyyoINy4U6nQ9dcBVccGu
         6nwEkGSMFkTM57Pr5e7tzAK5D25x9hvk0Dc5IX0TSFsX5ZByNbNM0yvtemDkia5MrjAT
         btkDSXSW2P3t+OGG9DNqwct6esrhchoB5IPjmq50pF4xhGOotRzI6X3QOT9KnraBhMeN
         tSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yn29hPekTEHm0ogF3LQuOjvq8pYLDGGmWVpzi1AKGkk=;
        b=Udek6k+FsnecPbcCmi2nCtEFfodPxeBdNqkyJWQjRErlAucoWFiP+spx//aiToViBV
         kfUOuvJ/s/SK/8njtpFh/bm5GdEoYCp2z548yQfNmg/64+rZOAfGR2GFMh/Kuo+/bS9T
         dmxPr/F1smprQeOoLzjthKJH8tNbPwAhYQ6DbvxpyPfqZSPieUfnVL3fPsqrp7lm+oFU
         re2iEwkEqBGXt+Le0U+eSrJuYYPRlnUKTaQeeUW5GkxbWLMDHHUn0OGrhbI/xo4vHmZ2
         jWIV3VVn5HeZwjHvXdFQpAjcFVvoCKl8NKmXQeEbqc7+P1fQwAMxKuw1/oD8ZvK5Y+Mo
         MGWw==
X-Gm-Message-State: AKwxytfDDbYIBgCpCeI/L1uo531boHmrzb6xbfxnERc0PBpRAbXkSxla
        HdR72hZ05sxxAUYFb3jAMaA=
X-Google-Smtp-Source: ACJfBotyghukskcr/M/7tive9ZIqqVcVGmc5MCuSolD38a4tYJcoqCntspGdk9rJ5SxhOiy7cRx2rw==
X-Received: by 10.28.61.68 with SMTP id k65mr3480552wma.147.1515754066536;
        Fri, 12 Jan 2018 02:47:46 -0800 (PST)
Received: from localhost.localdomain (x4db288cd.dyn.telefonica.de. [77.178.136.205])
        by smtp.gmail.com with ESMTPSA id p72sm1730734wme.17.2018.01.12.02.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Jan 2018 02:47:46 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] RelNotes: minor typofix
Date:   Fri, 12 Jan 2018 11:47:36 +0100
Message-Id: <20180112104736.8103-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc1.105.gdd2bd9e18
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/RelNotes/2.16.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.16.0.txt b/Documentation/RelNotes/2.16.0.txt
index 0c8464492..919f3eb3e 100644
--- a/Documentation/RelNotes/2.16.0.txt
+++ b/Documentation/RelNotes/2.16.0.txt
@@ -341,7 +341,7 @@ Fixes since v2.15
  * Command line completion (in contrib/) has been taught about the
    "--copy" option of "git branch".
 
- * When "git rebase" prepared an mailbox of changes and fed it to "git
+ * When "git rebase" prepared a mailbox of changes and fed it to "git
    am" to replay them, it was confused when a stray "From " happened
    to be in the log message of one of the replayed changes.  This has
    been corrected.
-- 
2.16.0.rc1.105.gdd2bd9e18

