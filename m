Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661E0C433F5
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 22:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46BA3613B3
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 22:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbhKGW7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 17:59:12 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50824 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235973AbhKGW7C (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 7 Nov 2021 17:59:02 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 92F9A60734;
        Sun,  7 Nov 2021 22:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1636325748;
        bh=bF0CJMkOoI4vuI98buXd8ZxanbEJbrB9X4EJKqb3Osk=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qG0+ZY5jjEIoRpY4/AJP0qiQz3Vh3mm+iKFyeUIwF/N2lANntlwaFh9zrdFBSeZ10
         I3CwrTp/wOEXDIl3NbXzMKNHcw7Ky+DFRyvRWcJkXrro2nlyYYOHN83YpA9o8D6YIc
         0WGwX3GHNNJyeGWi/g+aRPhq8c4IsJSsnxbWpZx9RER9ZjPVss608r6m1bm/tn15oy
         RoBkEGXhCo/Ru3lXNnRl8YEhNRQmC51j8huzjeOwvYKRZfazt8wdzBAhYmWTK7S/h+
         frA2snqFvkgcqvzzoJpdNIvSStwULns0AjAMzoBwAeep5kPoxTVBwM7GGS/WlaCnuH
         uXqgnE6SdXT2rxQ7aGqumDHSXFa2t3pkfMAs+aES/azppEHCAWzRwbrjrnpIp+yAgA
         UXW851edGo/q/w/cncuD6145iUPNKkxdttFfMbND/l9S3F4gG8T1n+kZ67ATLeVWJT
         KfpY61k5WBAWEAAlastK9KqEP1fGH55Gcqw2D34qRrsjua1HZlO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 0/3] Additional FAQ entries
Date:   Sun,  7 Nov 2021 22:55:22 +0000
Message-Id: <20211107225525.431138-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces some additional Git FAQ entries on various
topics.  They are all things I've seen in my professional life or on
Stack Overflow, so I've written documentation.

I've opted not to include backing up repositories in the syncing patch
because I think they're separate topics.  We could well end up with an
additional FAQ entry on that topic, which is left as an exercise for the
reader.

Changes from v1:
* Drop the monorepo patch for now; I want to revise it further.
* Reorder the working tree patch to place more warnings up front.
* Mention core.gitproxy and socat.
* Rephrase text in the EOL entry to read correctly and be easier to
  understand.
* Improve the commit message for the working tree FAQ entry to make it
  clearer that users wish to transfer uncommitted changes.

brian m. carlson (3):
  gitfaq: add documentation on proxies
  gitfaq: give advice on using eol attribute in gitattributes
  gitfaq: add entry about syncing working trees

 Documentation/gitfaq.txt | 90 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 6 deletions(-)

