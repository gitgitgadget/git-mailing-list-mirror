Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41756C433FE
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 12:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhLPMGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 07:06:12 -0500
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:59816 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234746AbhLPMGI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 07:06:08 -0500
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:69ff:d346:3fb6:6239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 420BE5754BD;
        Thu, 16 Dec 2021 12:57:09 +0100 (CET)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1639655829; bh=NHWTgwczO/K6OlGUVsV4X2J41K0mSqqqjwMFBKQLCTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IQJBfmVuCBzhB9Ue5QpttBKuEpQoTwI1bHdZ/oqcxPutIrgYlfW1HhFGs0+sKDE55
         0qQ8s5zkG7T73JxtDoDC1rFqVKT/keGH1u/RCvH30Nm4CjKIoIoatJUqJg1xEuhl6R
         F+6VJsP4ka0bog498H8zKvOT1BauUvrh0aiTcBns=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH 1/1] grep: align default colors with GNU grep ones
Date:   Thu, 16 Dec 2021 12:56:22 +0100
Message-Id: <20211216115622.85506-2-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216115622.85506-1-lenaic@lhuard.fr>
References: <20211216115622.85506-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
---
 grep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index fe847a0111..ca4f321cb3 100644
--- a/grep.c
+++ b/grep.c
@@ -26,10 +26,10 @@ static struct grep_opt grep_defaults = {
 	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED,
 	.colors = {
 		[GREP_COLOR_CONTEXT] = "",
-		[GREP_COLOR_FILENAME] = "",
+		[GREP_COLOR_FILENAME] = GIT_COLOR_MAGENTA,
 		[GREP_COLOR_FUNCTION] = "",
-		[GREP_COLOR_LINENO] = "",
-		[GREP_COLOR_COLUMNNO] = "",
+		[GREP_COLOR_LINENO] = GIT_COLOR_GREEN,
+		[GREP_COLOR_COLUMNNO] = GIT_COLOR_GREEN,
 		[GREP_COLOR_MATCH_CONTEXT] = GIT_COLOR_BOLD_RED,
 		[GREP_COLOR_MATCH_SELECTED] = GIT_COLOR_BOLD_RED,
 		[GREP_COLOR_SELECTED] = "",
-- 
2.34.1

