Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F978201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 22:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbdKLWHZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 17:07:25 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56016 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750921AbdKLWHZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2017 17:07:25 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1A47660488;
        Sun, 12 Nov 2017 22:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1510524444;
        bh=W2P7UKtsN5K42ZZxt+xbvK65xAdvdiFJ+VVlt5nf2Yk=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tAKhif9Xji9cgu8bW3oHPe4bFR0f7Nxfw0tGTcRCtoSPF2EUIvWSiyIZ3nII/LTvF
         fGxGWZsxXGFE+bC9dfqbfMML0xLOXpMZqKOLnqWL7WNvLd6itM8j7w1793Ff4AQave
         lvDsLZUduT0V5vJdM8bTwLUJgvXm48iylxcxod5x5yzLECq1xc7tbhRlrD2UpI5OBc
         pq4LYJJrzRcO54fvBlEA0tXEV6RB+DBTzNYOZyG00Pf9kEgmzCi7Vc5Ulx5IJzT0d+
         nXyp1B1EREJnVlcpvxn1yINXFu9XfVlR7VFeZ43C5HfsX8YSIqs/MEd/1WLZIIxB6w
         h0UOe9bkv2eugdU+VY1FLVbyPmEWNjdEBV033NpSNBBMHKB3IeQh/LVj/WLXH4ZVeT
         3lA7nzjljza56MB1r8cZuftpFZHmjL+L1NDUUzVo4tAWHtcFU86uxPpwbC1gUlPfyX
         daN3os6Rb4njzqGncipUrzijK2HxWBbC5d9oQHLXIUB6sYacGwC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2 0/2] Convert SubmittingPatches to AsciiDoc
Date:   Sun, 12 Nov 2017 22:07:16 +0000
Message-Id: <20171112220718.792129-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.448.gf294e3d99a
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series converts SubmittingPatches into AsciiDoc and builds it as
part of the technical documentation.  The goal is to provide a format
that is more easily linkable both from our website and by others, as the
Git Project's patch submission standards are widely referenced and used
as examples.

Changes from v1:
* Switch all branch names, paths, and commit message trailers to use
  backticks.
* Move footnotes directly above relevant paragraph.
* Fix quoting of mail message.

brian m. carlson (2):
  Documentation: enable compat-mode for Asciidoctor
  Documentation: convert SubmittingPatches to AsciiDoc

 Documentation/.gitignore        |   1 +
 Documentation/Makefile          |   6 +
 Documentation/SubmittingPatches | 340 +++++++++++++++++++++-------------------
 3 files changed, 189 insertions(+), 158 deletions(-)

