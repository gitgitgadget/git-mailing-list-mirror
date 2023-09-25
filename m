Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB6CCE79A1
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 19:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjIYTLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 15:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYTLL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 15:11:11 -0400
X-Greylist: delayed 231 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Sep 2023 12:11:02 PDT
Received: from mail-gateway-shared12.cyon.net (mail-gateway-shared12.cyon.net [194.126.200.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A7D95
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 12:11:02 -0700 (PDT)
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared12.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1qkqvE-0001pA-1p
        for git@vger.kernel.org;
        Mon, 25 Sep 2023 21:07:09 +0200
Received: from [10.20.10.230] (port=29484 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.96)
        (envelope-from <bb@drbeat.li>)
        id 1qkqvD-00AbKa-1E;
        Mon, 25 Sep 2023 21:07:07 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id E5347180107; Mon, 25 Sep 2023 21:07:06 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] unicode: update the width tables to Unicode 15.1
Date:   Mon, 25 Sep 2023 21:07:04 +0200
Message-Id: <20230925190704.157731-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.35.1.720.g215f5dbbfb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unicode 15.1 has been announced on 2023-09-12 [0], so update the
character width tables to the new version.

[0] http://blog.unicode.org/2023/09/announcing-unicode-standard-version-151.html

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 unicode-width.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/unicode-width.h b/unicode-width.h
index e15fb0455b..be5bf8c4f2 100644
--- a/unicode-width.h
+++ b/unicode-width.h
@@ -396,14 +396,13 @@ static const struct interval double_width[] = {
 { 0x2E80, 0x2E99 },
 { 0x2E9B, 0x2EF3 },
 { 0x2F00, 0x2FD5 },
-{ 0x2FF0, 0x2FFB },
-{ 0x3000, 0x303E },
+{ 0x2FF0, 0x303E },
 { 0x3041, 0x3096 },
 { 0x3099, 0x30FF },
 { 0x3105, 0x312F },
 { 0x3131, 0x318E },
 { 0x3190, 0x31E3 },
-{ 0x31F0, 0x321E },
+{ 0x31EF, 0x321E },
 { 0x3220, 0x3247 },
 { 0x3250, 0x4DBF },
 { 0x4E00, 0xA48C },
-- 
2.40.1

