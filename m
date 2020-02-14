Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEE9C3F68F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 23:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681EE222C4
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 23:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1XEkjrCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBNXII (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:08:08 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:32950 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727529AbgBNXII (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Feb 2020 18:08:08 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E3E6360799;
        Fri, 14 Feb 2020 23:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581721687;
        bh=x6L+iTpAy3iVbbRDBWTz5ODDwRuokTKLNPNkE+nAkS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=1XEkjrCK1noc7lOrebhTv2Nv4N0CWBMpcD24kk2vJRNoU954JS0OwnxDLWm/hb1vB
         srTmDh6hPMV9OCL5f2AZghge4JJ3yZhbXHpAQ9tR6/n+hwSy0UmxpONdL2bvMEfZxQ
         c/9ApUXxEjXAWVlvlhayxHlTYfFclR/caRHhvZsfYllM0CsbP/QibSJWJKLCCMsw5W
         69Vqyg+gwknjvDbAfeeS30fsSeecBuPGokXfp4l1UHvhlAE7Z9nF75camxhatlQG+a
         vFmXhA7dWIsG3QduXl0byHpLySVgCSv2Dy9IZKvlmSONgDf8Wt0hqyzxnlMeJKTESJ
         Ub1X0rP92BCwwI/zU9KOjYWqTFbr7KoFgoTzQi+4zMibI33q09COLeSSoZcmHYTcxk
         ucsQ1Gez+neW9DNg1yMMmaFZVNBg4M74qB+8yRkf1fohkQlpQqfIUV3bTn8Iq57IMW
         31umzBp1Ie93sVeCcqFQc4i4+TAYWhLXsJt98OOEqAzvXz8Qwd4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 1/3] mailmap: add an additional email address for brian m. carlson
Date:   Fri, 14 Feb 2020 22:59:27 +0000
Message-Id: <20200214225929.541306-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0
In-Reply-To: <20200214225929.541306-1-sandals@crustytoothpaste.net>
References: <20200214225929.541306-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: brian m. carlson <bk2204@github.com>

To more accurately track the provenance of contributions, brian uses a
work email address for commits created at work. Add this email address
to .mailmap so that contributions are properly attributed to the same
person.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 73fd92e192..bde7aba756 100644
--- a/.mailmap
+++ b/.mailmap
@@ -31,6 +31,7 @@ Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
 Brandon Williams <bwilliams.eng@gmail.com> <bmwill@google.com>
 brian m. carlson <sandals@crustytoothpaste.net>
 brian m. carlson <sandals@crustytoothpaste.net> <sandals@crustytoothpaste.ath.cx>
+brian m. carlson <sandals@crustytoothpaste.net> <bk2204@github.com>
 Bryan Larsen <bryan@larsen.st> <bryan.larsen@gmail.com>
 Bryan Larsen <bryan@larsen.st> <bryanlarsen@yahoo.com>
 Cheng Renquan <crquan@gmail.com>
