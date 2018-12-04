Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A9E8211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 05:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLDFno (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 00:43:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44500 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeLDFnn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 00:43:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so13672846lji.11
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 21:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/3ekb/qM9GNhQ5lCDym2I3bilt0X9rpaEbC/JctZsb4=;
        b=pA12DskwBKTVWRik0iS25wy0uJEbLigAh8hemAvO563/4lChx/3uqwnXJJRBooRjwM
         Mro5aDwfGnYjzjfnz54RK1XkCgEFUllYV/M/AMhoMYo4EItxom/vgyi1q/DY/qPm8kAP
         UOWIAHeeaZUX19rkhh11Hqs1RmNwKlySSDajHTyHWP3bR6cnxRIaN3jw03jz1bnk1qnn
         vSMo2N645t7dnL57ovmtb7S952IRuXSAR72pacRpn9u+CZbvXem87OjlnX5egmIU/U8E
         TG0xcdw+Z5uMoEtw3/csGc7eggVIoI/HPcf2uKmfbV4Bifx4/pj016fVEe8ScvIA3qtf
         FEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/3ekb/qM9GNhQ5lCDym2I3bilt0X9rpaEbC/JctZsb4=;
        b=CA/7sk0Ox/c3C4/DkvFefX5QxjWAH9IDBK2uUlmqqy1gelIhNeyTw9LkpntEpcsJNs
         3R49ZcO/3YrMleMbJEhTWfuwMhS9z4RnX5cxdTDQ6G4GH4ym+iNOtxhinbzc0Mhny6kv
         vjU6LRgqzvj31bgt3LM2PPGzdsmd2gkxvtBZfUocHugkUaRUj8mO3yvc4nbvde3GEDSF
         V1U2av/OA94Z1GYln0X0FIY5ozbJYauiKwBYZjb9XaFlc7/vbs/HEusi5iW8ueb6XVag
         C0ptmK/BVJl2lYu8ENqzjhILyAKvLOX0Ao4QrUYFNLmqn996yt35Um8iFl6k0MUFVKiS
         4dLg==
X-Gm-Message-State: AA+aEWYC1ESqKtf1Ld9SdD4JXq38Yxjtem3khzu5TvxZlTb1hRTSeCmv
        7rER4ndp8ybI1lHwY6U5kOML+v0N
X-Google-Smtp-Source: AFSGD/WoqXDb0xPXMUt1ExzuS4LkF+j2e+LVm5EwXZSQKHgd//xAC6Jc5mzGXcafmoxg3LkkBKZJzw==
X-Received: by 2002:a2e:55d3:: with SMTP id g80-v6mr13040984lje.78.1543902221409;
        Mon, 03 Dec 2018 21:43:41 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id m77sm2779217lfg.3.2018.12.03.21.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 21:43:40 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2 2/3] RelNotes 2.20: clarify sentence
Date:   Tue,  4 Dec 2018 06:43:18 +0100
Message-Id: <3027a34938bef003e61c1c02f8bedf9f1f917888.1543901498.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.1.gc81af441bb
In-Reply-To: <cover.1543901498.git.martin.agren@gmail.com>
References: <xmqq36reghdk.fsf@gitster-ct.c.googlers.com> <cover.1543901498.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had to read this sentence a few times to understand it. Let's try to
clarify it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/RelNotes/2.20.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.20.0.txt b/Documentation/RelNotes/2.20.0.txt
index f4e79c4cfb..1a5bbd2e91 100644
--- a/Documentation/RelNotes/2.20.0.txt
+++ b/Documentation/RelNotes/2.20.0.txt
@@ -305,7 +305,7 @@ Performance, Internal Implementation, Development Support etc.
 
  * The overly large Documentation/config.txt file have been split into
    million little pieces.  This potentially allows each individual piece
-   included into the manual page of the command it affects more easily.
+   to be included into the manual page of the command it affects more easily.
 
  * Replace three string-list instances used as look-up tables in "git
    fetch" with hashmaps.
-- 
2.20.0.rc2.1.gc81af441bb

