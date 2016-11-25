Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD7A41FBB0
	for <e@80x24.org>; Fri, 25 Nov 2016 17:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932254AbcKYRfu (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 12:35:50 -0500
Received: from wp260.webpack.hosteurope.de ([80.237.133.29]:59200 "EHLO
        wp260.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754953AbcKYRfr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 Nov 2016 12:35:47 -0500
Received: from p549a87ab.dip0.t-ipconnect.de ([84.154.135.171] helo=gentp.lnet); authenticated
        by wp260.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1cAKP7-0001AE-4j; Fri, 25 Nov 2016 18:35:17 +0100
Received: by gentp.lnet (Postfix, from userid 1000)
        id A2BEB2603C1; Fri, 25 Nov 2016 18:35:15 +0100 (CET)
From:   Luis Ressel <aranea@aixah.de>
To:     git@vger.kernel.org
Subject: [PATCH] date-formats.txt: Typo fix
Date:   Fri, 25 Nov 2016 18:34:46 +0100
Message-Id: <20161125173446.9396-1-aranea@aixah.de>
X-Mailer: git-send-email 2.10.2
X-bounce-key: webpack.hosteurope.de;aranea@aixah.de;1480095347;2457bcab;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Last time I checked, I was living in the UTC+01:00 time zone. UTC+02:00
would be Central European _Summer_ Time.
---
 Documentation/date-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index 35e8da2..9c3084e 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -11,7 +11,7 @@ Git internal format::
 	It is `<unix timestamp> <time zone offset>`, where `<unix
 	timestamp>` is the number of seconds since the UNIX epoch.
 	`<time zone offset>` is a positive or negative offset from UTC.
-	For example CET (which is 2 hours ahead UTC) is `+0200`.
+	For example CET (which is 1 hours ahead of UTC) is `+0100`.
 
 RFC 2822::
 	The standard email format as described by RFC 2822, for example
-- 
2.10.2

