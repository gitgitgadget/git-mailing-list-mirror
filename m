Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE516C32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 21:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCFA217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 21:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GEjrAsLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgATVWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 16:22:04 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43206 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726897AbgATVWD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Jan 2020 16:22:03 -0500
Received: from camp.crustytoothpaste.net (50-244-106-130-static.hfc.comcastbusiness.net [50.244.106.130])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 716736044F
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 21:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579555322;
        bh=p3j0902jhPDC5sNZBCecPK7JNFuo2CfVJbX6jC7/a2U=;
        h=From:To:Subject:Date:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=GEjrAsLF7yzeAPxHq2NtHxXgYghDhpOen0mfBezAYreDAI2p+yfGVfuqIYP4ndRDA
         cPBn4XwXPEM+ObSoa/lE5jOXiwGG4CfVbNh109rJdz5afqUULmWsgfGJsVyOEAQLwf
         XDZDozHbgtH5nSPLXJfOTfKoa5Nsk5NQ2ROZKIFuVFd1g2guZKq3q6I0fSuSDMCuVE
         VA4oQKIp/fLlgaazUWHR+fSAGNFedObyMouxF3y1RH4fON1oDVRZpKbc5fgBfoksIU
         x7x2upPt9J8ilbv6e4VcWZezfFXaDRRrOWRxker7cIjZiSwltWTnM2Lrh3ViW8isTV
         1PiIYopWAKLbeNfllU1OHxekpAsM8W32vu9ksmxguhAGYi3Ee+28B5AeZXPB4V7z1Z
         MXlQssLX7zcDju6yf8MAtDvejWCk4kkDKwhBCWbAFHezEIlQbIDg4GITaiiPpYgnJN
         iygj3ABNNiDcdMj6n3rqWIKMyTq5DJUa7Ln0JMyTLmBGsGZWHgx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH] docs: use "currently" for the present time
Date:   Mon, 20 Jan 2020 21:21:56 +0000
Message-Id: <20200120212156.4109999-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In many languages, the adverb with the root "actual" means "at the
present time."  However, this usage is considered dated or even archaic
in English, and for referring to events occurring at the present time,
we usually prefer "currently" or "presently".  "Actually" is commonly
used in modern English only for the meaning of "in fact" or to express a
contrast with what is expected.

Since the documentation refers to the available options at the present
time (that is, at the time of writing) instead of drawing a contrast,
let's switch to "currently," which both is commonly used and sounds less
formal than "presently."

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
This is a minor issue I noticed one day and thought I'd send a patch
for.  I should point out that English differs from virtually every other
language I can find that uses something like "actual", so this is an
easy mistake to make.

 Documentation/config/http.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 5a32f5b0a5..8471b39f0f 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -71,7 +71,7 @@ http.saveCookies::
 http.version::
 	Use the specified HTTP protocol version when communicating with a server.
 	If you want to force the default. The available and default version depend
-	on libcurl. Actually the possible values of
+	on libcurl. Currently the possible values of
 	this option are:
 
 	- HTTP/2
@@ -84,7 +84,7 @@ http.sslVersion::
 	particular configuration of the crypto library in use. Internally
 	this sets the 'CURLOPT_SSL_VERSION' option; see the libcurl
 	documentation for more details on the format of this option and
-	for the ssl version supported. Actually the possible values of
+	for the ssl version supported. Currently the possible values of
 	this option are:
 
 	- sslv2
