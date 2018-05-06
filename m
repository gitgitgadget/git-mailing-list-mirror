Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6D5200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeEFXYg (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:24:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41292 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751625AbeEFXYf (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:24:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7F8D560444;
        Sun,  6 May 2018 23:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525649069;
        bh=Z7FIIb2Vjtqb5q9E6y7El/RVuFh1a9KjBms1x5JJYHs=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TkNnDUBU/eigAxi0ic9PTpVKle4eE8g+yneHrPeEute/g35YpOa5C8Px8CyjXFhb5
         Fxqp9whtis9Tu86tVZ7pdbSGvlj/QRY2rMsQXi5HQCDsg1UkH42s53bXfKd1Oo8hdI
         THmmyTb6YCZBbkUecPhDmWT/SAo3OQQ9OTy9A6U6gdDoGFIPnc4CY8VYtwb28SeoNP
         FwxUiLPPQ1J6HF/pQ0pkeK/cSFVqYa3fODgEG3wZTp4dAp5uJIjy35xgqQFWN9qpUE
         RtDkhcdnDHd3K4a2OvappIgG3LkBEyXBmuBZZAfgWI08UJVPHRnAGEEebYH4Ja2TAl
         642tlSGZJotkzQ+YQqtU6aeC20eU56+gNBlf+Sto4f8PNwEOmHv7cmBV+RQhusxYH3
         EbSMJes6h8RYZk3mbICmD4KfUZYoahcJT+j7pJH8Kz8gaPfqrmpekLaw6DiZ8UWotG
         MCWSwOC/wFBT8k4RTNbSt1U2eikoEXgXUYd7t7zn5B2r6HtjJnL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] mailmap: update brian m. carlson's email address
Date:   Sun,  6 May 2018 23:24:21 +0000
Message-Id: <20180506232421.975789-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The order of addresses in the mailmap file was reversed, leading to git
preferring the crustytoothpaste.ath.cx address, which is obsolete, over
the crustytoothpaste.net address, which is current.  Switch the order of
the addresses so that git log displays the correct address.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 .mailmap | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 7c71e88ea5..df7cf6313c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -25,8 +25,8 @@ Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
 Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
 Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
 Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
-brian m. carlson <sandals@crustytoothpaste.ath.cx> Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
-brian m. carlson <sandals@crustytoothpaste.ath.cx> <sandals@crustytoothpaste.net>
+brian m. carlson <sandals@crustytoothpaste.net> Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
+brian m. carlson <sandals@crustytoothpaste.net> <sandals@crustytoothpaste.ath.cx>
 Bryan Larsen <bryan@larsen.st> <bryan.larsen@gmail.com>
 Bryan Larsen <bryan@larsen.st> <bryanlarsen@yahoo.com>
 Cheng Renquan <crquan@gmail.com>
