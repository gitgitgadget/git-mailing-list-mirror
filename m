Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24BA31F462
	for <e@80x24.org>; Wed, 29 May 2019 20:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfE2U5t (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 16:57:49 -0400
Received: from mail-gateway-shared10.cyon.net ([194.126.200.61]:38710 "EHLO
        mail-gateway-shared10.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725990AbfE2U5t (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 May 2019 16:57:49 -0400
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 16:57:48 EDT
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared10.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1hW5XV-0007Ud-VL
        for git@vger.kernel.org; Wed, 29 May 2019 22:51:16 +0200
Received: from [10.20.10.230] (port=15170 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1hW5XU-008aEf-Mm; Wed, 29 May 2019 22:51:12 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 74674180616; Wed, 29 May 2019 22:51:12 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] unicode: update the width tables to Unicode 12.1
Date:   Wed, 29 May 2019 22:50:45 +0200
Message-Id: <20190529205045.22903-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-OutGoing-Spam-Status: No, score=-0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that Unicode 12.1 has been announced[0], update the character
width tables to the new version.

[0] http://blog.unicode.org/2019/05/unicode-12-1-en.html

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 unicode-width.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/unicode-width.h b/unicode-width.h
index 93a48f3bf8..c9d027625d 100644
--- a/unicode-width.h
+++ b/unicode-width.h
@@ -380,8 +380,7 @@ static const struct interval double_width[] = {
 { 0x31C0, 0x31E3 },
 { 0x31F0, 0x321E },
 { 0x3220, 0x3247 },
-{ 0x3250, 0x32FE },
-{ 0x3300, 0x4DBF },
+{ 0x3250, 0x4DBF },
 { 0x4E00, 0xA48C },
 { 0xA490, 0xA4C6 },
 { 0xA960, 0xA97C },
-- 
2.21.0.1020.gf2820cf01a

