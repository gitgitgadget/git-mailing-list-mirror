Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 883ED200B9
	for <e@80x24.org>; Tue,  8 May 2018 01:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753558AbeEHB66 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 21:58:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42084 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753529AbeEHB65 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 May 2018 21:58:57 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F384F60444;
        Tue,  8 May 2018 01:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525744732;
        bh=jT2oE/ZdbMWuY4eIn+a2GWc+jgBr/wQ7ij9gAN7WvSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=K7Xk4q1EeQY78z8DVOobHQZgpq2uJP0aAeUqURXHrKzxM7JxJgCxsIiyNsMVQ+VyK
         5vmC7tWvErdOklXKXZWT2WikpxMYTV4OZC87S0LeLqXZnj98BS+pgCLpn53DtEoR+a
         wVBEBiSZPgGPRkZDalPk2OwzD4eI0JTLRSzMNyyXg66PoaUlfoSamUcwbeKyC8JMOq
         2GOD8Z3Ws9M55GFDsfCMTWJyTsUZWZsZAUc8k/fE9UwEfLT5RuyPW8UNDm+9HFTLwk
         sl1Co6Bsa7jCqNMeU8Dq3cMz/suGC5uIvgfCimTQI9oaXsITAzBlkEpuRSkHSOIpkL
         M816LUgV4tQbIKs10Lslk1/YnzCTjBBfuK++gdi4fgf1Qf9eRrBSjnNynq/Z2dQID3
         OEwvf2pn+HVLhALPAzWLCIzp25NHBvIZxcSipPlXv4cz9Lr1aTJD+0hKUM3iCjOZgy
         hCNq5a2qYKhX6oOlliKrtdP/RysnFkdAwI1UNwal673DxFwy1IP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2] mailmap: update brian m. carlson's email address
Date:   Tue,  8 May 2018 01:58:45 +0000
Message-Id: <20180508015845.268572-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180506232421.975789-1-sandals@crustytoothpaste.net>
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An earlier change, cdb6b5ac (".mailmap: Combine more (name, email) to
individual persons", 2013-08-12), noted that there were two name
spellings and two email addresses and mapped the crustytoothpaste.net
address to the crustytoothpaste.ath.cx address.  The latter is an older,
obsolete address, while the former is current, so switch the order of
the addresses so that git log displays the correct address.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I intentionally avoided the use of the first person here, because I
wasn't sure what the preference of the list was on that.  Hopefully it
reads naturally and isn't awkward.

If not, I can send a v3.

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
