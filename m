Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02434C10F29
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 15:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FF920663
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 15:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgCQPqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:46:22 -0400
Received: from mail-gateway-shared13.cyon.net ([194.126.200.66]:46834 "EHLO
        mail-gateway-shared13.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbgCQPqV (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 17 Mar 2020 11:46:21 -0400
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2020 11:46:20 EDT
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared13.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1jEEGY-0000rH-7m
        for git@vger.kernel.org; Tue, 17 Mar 2020 16:36:30 +0100
Received: from [10.20.10.230] (port=50324 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.93)
        (envelope-from <bb@drbeat.li>)
        id 1jEEGX-009cuW-2h; Tue, 17 Mar 2020 16:36:25 +0100
Received: by drbeat.li (Postfix, from userid 1000)
        id CD7A81801DB; Tue, 17 Mar 2020 16:36:24 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] unicode: update the width tables to Unicode 13.0
Date:   Tue, 17 Mar 2020 16:36:05 +0100
Message-Id: <20200317153605.1177454-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-OutGoing-Spam-Status: No, score=-0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that Unicode 13.0 has been announced[0], update the character
width tables to the new version.

[0] https://home.unicode.org/announcing-the-unicode-standard-version-13-0/

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 unicode-width.h | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/unicode-width.h b/unicode-width.h
index c9d027625d..b50e686bae 100644
--- a/unicode-width.h
+++ b/unicode-width.h
@@ -59,7 +59,7 @@ static const struct interval zero_width[] = {
 { 0x0B3F, 0x0B3F },
 { 0x0B41, 0x0B44 },
 { 0x0B4D, 0x0B4D },
-{ 0x0B56, 0x0B56 },
+{ 0x0B55, 0x0B56 },
 { 0x0B62, 0x0B63 },
 { 0x0B82, 0x0B82 },
 { 0x0BC0, 0x0BC0 },
@@ -82,6 +82,7 @@ static const struct interval zero_width[] = {
 { 0x0D41, 0x0D44 },
 { 0x0D4D, 0x0D4D },
 { 0x0D62, 0x0D63 },
+{ 0x0D81, 0x0D81 },
 { 0x0DCA, 0x0DCA },
 { 0x0DD2, 0x0DD4 },
 { 0x0DD6, 0x0DD6 },
@@ -139,7 +140,7 @@ static const struct interval zero_width[] = {
 { 0x1A65, 0x1A6C },
 { 0x1A73, 0x1A7C },
 { 0x1A7F, 0x1A7F },
-{ 0x1AB0, 0x1ABE },
+{ 0x1AB0, 0x1AC0 },
 { 0x1B00, 0x1B03 },
 { 0x1B34, 0x1B34 },
 { 0x1B36, 0x1B3A },
@@ -182,6 +183,7 @@ static const struct interval zero_width[] = {
 { 0xA806, 0xA806 },
 { 0xA80B, 0xA80B },
 { 0xA825, 0xA826 },
+{ 0xA82C, 0xA82C },
 { 0xA8C4, 0xA8C5 },
 { 0xA8E0, 0xA8F1 },
 { 0xA8FF, 0xA8FF },
@@ -223,6 +225,7 @@ static const struct interval zero_width[] = {
 { 0x10A3F, 0x10A3F },
 { 0x10AE5, 0x10AE6 },
 { 0x10D24, 0x10D27 },
+{ 0x10EAB, 0x10EAC },
 { 0x10F46, 0x10F50 },
 { 0x11001, 0x11001 },
 { 0x11038, 0x11046 },
@@ -238,6 +241,7 @@ static const struct interval zero_width[] = {
 { 0x11180, 0x11181 },
 { 0x111B6, 0x111BE },
 { 0x111C9, 0x111CC },
+{ 0x111CF, 0x111CF },
 { 0x1122F, 0x11231 },
 { 0x11234, 0x11234 },
 { 0x11236, 0x11237 },
@@ -273,6 +277,9 @@ static const struct interval zero_width[] = {
 { 0x11727, 0x1172B },
 { 0x1182F, 0x11837 },
 { 0x11839, 0x1183A },
+{ 0x1193B, 0x1193C },
+{ 0x1193E, 0x1193E },
+{ 0x11943, 0x11943 },
 { 0x119D4, 0x119D7 },
 { 0x119DA, 0x119DB },
 { 0x119E0, 0x119E0 },
@@ -305,6 +312,7 @@ static const struct interval zero_width[] = {
 { 0x16B30, 0x16B36 },
 { 0x16F4F, 0x16F4F },
 { 0x16F8F, 0x16F92 },
+{ 0x16FE4, 0x16FE4 },
 { 0x1BC9D, 0x1BC9E },
 { 0x1BCA0, 0x1BCA3 },
 { 0x1D167, 0x1D169 },
@@ -376,8 +384,7 @@ static const struct interval double_width[] = {
 { 0x3099, 0x30FF },
 { 0x3105, 0x312F },
 { 0x3131, 0x318E },
-{ 0x3190, 0x31BA },
-{ 0x31C0, 0x31E3 },
+{ 0x3190, 0x31E3 },
 { 0x31F0, 0x321E },
 { 0x3220, 0x3247 },
 { 0x3250, 0x4DBF },
@@ -392,9 +399,11 @@ static const struct interval double_width[] = {
 { 0xFE68, 0xFE6B },
 { 0xFF01, 0xFF60 },
 { 0xFFE0, 0xFFE6 },
-{ 0x16FE0, 0x16FE3 },
+{ 0x16FE0, 0x16FE4 },
+{ 0x16FF0, 0x16FF1 },
 { 0x17000, 0x187F7 },
-{ 0x18800, 0x18AF2 },
+{ 0x18800, 0x18CD5 },
+{ 0x18D00, 0x18D08 },
 { 0x1B000, 0x1B11E },
 { 0x1B150, 0x1B152 },
 { 0x1B164, 0x1B167 },
@@ -429,20 +438,22 @@ static const struct interval double_width[] = {
 { 0x1F680, 0x1F6C5 },
 { 0x1F6CC, 0x1F6CC },
 { 0x1F6D0, 0x1F6D2 },
-{ 0x1F6D5, 0x1F6D5 },
+{ 0x1F6D5, 0x1F6D7 },
 { 0x1F6EB, 0x1F6EC },
-{ 0x1F6F4, 0x1F6FA },
+{ 0x1F6F4, 0x1F6FC },
 { 0x1F7E0, 0x1F7EB },
-{ 0x1F90D, 0x1F971 },
-{ 0x1F973, 0x1F976 },
-{ 0x1F97A, 0x1F9A2 },
-{ 0x1F9A5, 0x1F9AA },
-{ 0x1F9AE, 0x1F9CA },
+{ 0x1F90C, 0x1F93A },
+{ 0x1F93C, 0x1F945 },
+{ 0x1F947, 0x1F978 },
+{ 0x1F97A, 0x1F9CB },
 { 0x1F9CD, 0x1F9FF },
-{ 0x1FA70, 0x1FA73 },
+{ 0x1FA70, 0x1FA74 },
 { 0x1FA78, 0x1FA7A },
-{ 0x1FA80, 0x1FA82 },
-{ 0x1FA90, 0x1FA95 },
+{ 0x1FA80, 0x1FA86 },
+{ 0x1FA90, 0x1FAA8 },
+{ 0x1FAB0, 0x1FAB6 },
+{ 0x1FAC0, 0x1FAC2 },
+{ 0x1FAD0, 0x1FAD6 },
 { 0x20000, 0x2FFFD },
 { 0x30000, 0x3FFFD }
 };
-- 
2.25.0.341.g760bfbb309

