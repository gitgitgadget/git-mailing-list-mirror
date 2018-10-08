Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A869C1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 20:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJIDmo (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 23:42:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49238 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbeJIDmo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Oct 2018 23:42:44 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6EAA56077F;
        Mon,  8 Oct 2018 20:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539030550;
        bh=m/B1JXoWDkzSCeWcTNiEmmIdb5r4cOFHBP6pax+GmN8=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=olhQW7/G4K/7ow0dEEO9bvPvc0gN6LHoOKd+ymjWDEUMSN0oKARL74KZjYuIlijZT
         aMN9Rezzu+Dlhn6oSnZ3q74gD7Yxl/TD+F4YCfb+gAJPaLgEK6RTNlOwZb2Ng1FaO3
         FSUeid33Ks5zqc8OPPlACUYRtQemz1SReOuZcu/tBQwQqNvYlvIPs2j6GsOzlm+2Fz
         PzEBJpOuqDPoviYQdtmD9V/y7yNn2rSmuf/T+M4SEHbJbYOODgUJ5SygA28CFJ4bEE
         EyAno/NxOCdWUDVItdbA3SoDu8vSdBjFKFtQNd9fvL68aA3dJtwO8caiWk9hoigLs7
         KLLXKhEwyzvo/GSIGXFA7iF47cvFguQ7mC4mYam283lXWP6e5STsTZ+HiqRJ9aXK2V
         awZJkXcUC2YX29BGZsBSIm0TvNKbXfPfRZWu79lKzsjm4RnXyO2YuwK9rXM3jiaxcY
         7UE5AyQwhNcz6vad4bzIb1GM2mWj2Lhyj4naCu8Nz/lrUxjRMfK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] EditorConfig file
Date:   Mon,  8 Oct 2018 20:29:01 +0000
Message-Id: <20181008202903.100166-1-sandals@crustytoothpaste.net>
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

