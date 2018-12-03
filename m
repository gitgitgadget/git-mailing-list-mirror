Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9CB5211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 20:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLCUWL (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 15:22:11 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37000 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeLCUWL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 15:22:11 -0500
Received: by mail-lf1-f65.google.com with SMTP id p17so10209367lfh.4
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 12:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=no0+ssyJSiBfGPtV20zD63H7M4B7Gnyuzs2jrp5CHUQ=;
        b=mCrsQGfmWUf1ozWySUlTBFzfixtOlyLCGu4w4IQ3ycq9uLweOwYUhppqoU3XcY/JMG
         ZUL9ANxenVy7blEh0ewBznNYRNlPzQy5NqBN6LbM6RYKQHQx6O/xVDM2x48edDMBmJfg
         hTNZC6C8/NcFnE5FrWPB4iTNH/xAsInOykTfCV7CCXc3K5E7A6pF6IATMgTc8wsAvyRn
         pCky4w5deLt5F+pzPOZzfZGifm3R90umKZb0wceL+oPS+o2umDk8g4sYRYpbEvpHj9Vt
         v2ORw8mDhOn2rVe1FQ18+Lq8+j8IILfKbKgbTBc1gsSjG7a4fm3navc5qEUOjkWcbcM3
         y0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=no0+ssyJSiBfGPtV20zD63H7M4B7Gnyuzs2jrp5CHUQ=;
        b=RnbTC78YfmE8hRc9zboYi/GwzWyFuc005FJcEjQicY5+ETJefaGw1koyo6wK3WaTeo
         oNqyQ/temC4ThifN5w/1DpPP32N3pTsiVT//EgbhixLDlkxmcMeamSI4m8bgcTnLI1ZQ
         7/GXJq+v97ZwYdCwSW+rcr2jncwQIXRzPmNL+VKBpXOVFUFUjNl1sUxMSDhy4PzQZ+/8
         H4W6r5L0BLvnp32lHkvBDq3siA5o1ZY1UTU63aeRfuwexvlwSZVThJfloF7hO7IwREs7
         1YGu42TNKQqIPanwIullE1dqloSFhvHgaSsGq5FMN3SeBVZGgpDSBHG1YME+kARLcEUx
         4FBA==
X-Gm-Message-State: AA+aEWb2hFAYKQXuuElWjnCaSJ+qY/S/pMeqqSv522m5CK9VbUqFH24S
        +s6Xlq41TkyZ+ypy7ch517pGtj6g
X-Google-Smtp-Source: AFSGD/Ue4p+9+FMJXPIu+dA9lPppgU6JfHZi1uk50INHh3N4p337J/bttpcjMG88h8AfkVVYgTVyKg==
X-Received: by 2002:a19:a502:: with SMTP id o2mr9880324lfe.92.1543868527655;
        Mon, 03 Dec 2018 12:22:07 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id j12-v6sm2705104ljh.66.2018.12.03.12.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 12:22:06 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 2/3] RelNotes 2.20: clarify sentence
Date:   Mon,  3 Dec 2018 21:21:50 +0100
Message-Id: <eccb7edd082b55ba1ddd8f0eebb7c2bb9a1f6ada.1543868120.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.1.gfcc5f94f1e
In-Reply-To: <cover.1543868120.git.martin.agren@gmail.com>
References: <xmqq36rhjnts.fsf@gitster-ct.c.googlers.com> <cover.1543868120.git.martin.agren@gmail.com>
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
index e5ab8cc609..201135d80c 100644
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
2.20.0.rc2.1.gfcc5f94f1e

