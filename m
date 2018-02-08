Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A73451F404
	for <e@80x24.org>; Thu,  8 Feb 2018 02:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbeBHC4Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 21:56:25 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58766 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750806AbeBHC4Y (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Feb 2018 21:56:24 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4E4F76042C;
        Thu,  8 Feb 2018 02:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1518058583;
        bh=rBqyhBFTn2HDH1eaumD3DwkjX/W7C4T0b1Vdxyw50+Y=;
        h=From:To:Cc:Subject:Date:Content-Type:From:Reply-To:Subject:Date:
         To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=YrdU21KSKhPGgkDOFhnmmkz/VFoTcHiLalOvByQtN/EHNxflWBCoj4kIJ5UWsiCmZ
         Qp1WtsbPBVdOKYgDIJkK8GZDEDFktI8jNIK43I2TRS75+PY/f34uDj1h6nesdQfHi/
         eX1O6Ew51zzB5KUqBy7qu7+gju1uaHLXOM26JZZKeiggr5H3nJ1NFBrDCdNttmLRCT
         yu2byQxvsUp7zoKyf81zo0vHCmT6c44iBon0FltX/V6ktevjKFU7m+Ii89st5lg8sh
         5DPPzXCJiCKoOrV/9iVWjh/0xcFb5ljSe4ezHpiFrXUED84ipcyIIDBU2SH/3gImHL
         D3kbnuV7j5ltcTfSCZ7gIb/0EVaL4cz+6xT3+tUMdbCfbMgVSPphaPUHFlF6Sfvpg6
         m97WhFKLEv6WPl2BKS+ib9WTlQbGCM8y4Qjk3ju/ymsvmvZho3GBhhCKyYdjQdDYRv
         toQBv1PBuwFmSzCwHv2Me5Fp8Y0tyK+6RoIEADfZx6hogNVL+N9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] docs/interpret-trailers: fix agreement error
Date:   Thu,  8 Feb 2018 02:56:14 +0000
Message-Id: <20180208025614.872885-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.101.gde0f0111ea
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the description of git interpret-trailers, we describe "a group…of
lines" that have certain characteristics.  Because the first option uses
a plural verb (referring to "lines"), the second option must also use
plural verbs for parallelism.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I'm somewhat on the fence about this patch.  To me, the number
disagreement is very jarring.  However, I'm also sympathetic to the fact
that the latter sentence reads more naturally in the singular.

Opinions on improvements welcome.

 Documentation/git-interpret-trailers.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 9dd19a1dd9..de5011e564 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -51,8 +51,8 @@ with only spaces at the end of the commit message part, one blank line
 will be added before the new trailer.
 
 Existing trailers are extracted from the input message by looking for
-a group of one or more lines that (i) are all trailers, or (ii) contains at
-least one Git-generated or user-configured trailer and consists of at
+a group of one or more lines that (i) are all trailers, or (ii) contain at
+least one Git-generated or user-configured trailer and consist of at
 least 25% trailers.
 The group must be preceded by one or more empty (or whitespace-only) lines.
 The group must either be at the end of the message or be the last
