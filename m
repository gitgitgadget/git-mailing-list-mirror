Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53D561F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 22:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbeJIFRw (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:17:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49404 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725749AbeJIFRw (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:17:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5EB736078E;
        Mon,  8 Oct 2018 22:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539036240;
        bh=dWwBa2cffCy66+Q1ZAee9MksXPsNhrc9M95KWy+Yl4w=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cY9xYBiwiBEhIhGfy7ECmSG6M9JRLBswOslLz6xc8JC5yFbeA1WMjiRWpJ9PJl9ZS
         0G4lfXeW2UeXDBUJTdtxsUmphg7M/typOztNiT2tKkTdb+K4uqoYa26adBJb+1MCj2
         9wrqihZ9CJqO/EuYdCjLW5OBTKAlG4pAF+4nlit+4xzq+0SRo/SNYdm+HmYHlv6arT
         QhicHJ3yPWqSBiWBSJrRTlHoynj5K2s0+OWh7xXjK9tajR5kb0g3Dl7zqqEkRwlSYp
         8MQLfrZI66ZHUMlYtU2xYEUhuQXJ4/msZ/cyNb/XGC0SizX8hEDEWm3q9LYatLZ7ZI
         tgm+n2QbImHGVEUD5+ZxeMTxBwQstVGIcUfkl5rXeAIUKEnivkJsKu8K5P0PDBAWr3
         eGqhWiXZm0xJnwkEqiZ8Dzt+7nDAkC5IdFVeNV/eIvy3YKoxQgRt4JxlTz/8/RUpJs
         VPsCjM76w1B/1dmF/P5/aVsaFysV/xRtlRSemZ8pPDe5MVk1FRA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/2] EditorConfig file
Date:   Mon,  8 Oct 2018 22:03:51 +0000
Message-Id: <20181008220353.780301-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces an EditorConfig file to help developers using any
editor set their editor's settings in conformance with the Git Project's
settings.  This is helpful for developers who work on different projects
with different indentation standards to keep their work in sync.

Changes since v2:
* Add .pl and .pm files.

Changes since v1:
* Add notes to both .editorconfig and .clang-format that they should be
  kept in sync.
* Add commit message line length.

brian m. carlson (2):
  editorconfig: provide editor settings for Git developers
  editorconfig: indicate settings should be kept in sync

 .clang-format |  2 ++
 .editorconfig | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 .editorconfig

