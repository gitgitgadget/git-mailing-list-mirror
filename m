Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8B771F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 11:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394331AbeKWWBF (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 17:01:05 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:48849 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbeKWWBE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 17:01:04 -0500
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id Q9SMg52vNwhzSQ9SSg6d1n; Fri, 23 Nov 2018 11:17:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542971833;
        bh=hWW9Ip0eOtL8RZZi12AwrhDHhdAPaI9JPJVSuvQ4RhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=cG3EkijfC+Lvhht5I89YtZF/F93HDovvGq3VupTuKRma3pkZDPtf+B9J/KPZqVcUX
         Dc7SkKcSB2IW1Uj7uR/wsAK/AbGqFXIPyFlB47FdmikVj8Y1AwbMVGcv7Vfsdhfx10
         3B+U1gFjp9+my9pio4OxUvI9RpdCcu5aiJVusqRk=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=sgcJ5tVGo-PX1bOlNW4A:9
 a=aPqGf9fwU8MMLC3g:21 a=2vQo7RDd6zDzV5U6:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 1/9] diff: document --no-color-moved
Date:   Fri, 23 Nov 2018 11:16:50 +0000
Message-Id: <20181123111658.30342-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123111658.30342-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181123111658.30342-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEY3G6n8ycEBsdxHzH/SEtNYCamnEOCutBxmZBSf5WvgqCBUNuQVreqfYlYIIEI+QyYHprXc036Yhdxb6jcuzkmFZssDLaX3uIvDjNDZoKUYCodGjCij
 x+t9YjvmHP/5bLAXlf1GVyqeobhdzZ/aLkijL0U8VV01zXaj5tZONEYHOHXhhtbpGxEejptPvea32IoVXPdSmmMniCh5GJkTDzj8iy7MzFWl1nIqiwW3OU2j
 KI/bdMy1Hhj5V6VfLvEAaPYQBk3/lxM9YIDk/+rQQdjIJ5qDowobYuKfh3L31Lrz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add documentation for --no-color-moved.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/diff-options.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 0378cd574e..151690f814 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -293,6 +293,10 @@ dimmed-zebra::
 	`dimmed_zebra` is a deprecated synonym.
 --
 
+--no-color-moved::
+	Turn off move detection. This can be used to override configuration
+	settings. It is the same as `--color-moved=no`.
+
 --color-moved-ws=<modes>::
 	This configures how white spaces are ignored when performing the
 	move detection for `--color-moved`.
-- 
2.19.1.1690.g258b440b18

