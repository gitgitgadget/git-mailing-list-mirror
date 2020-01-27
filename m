Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07384C33CB1
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 10:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3B220702
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 10:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgA0KRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:17:01 -0500
Received: from unsecure-smtp.soverin.net ([94.130.159.241]:48472 "EHLO
        g02sm02.soverin.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725990AbgA0KRB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 05:17:01 -0500
Received: from soverin.net by soverin.net
From:   Zeger-Jan van de Weg <git@zjvandeweg.nl>
To:     git@vger.kernel.org
Cc:     Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: [PATCH v2 0/1] config: read instructions from stdin
Date:   Mon, 27 Jan 2020 11:09:32 +0100
Message-Id: <20200127100933.10765-1-git@zjvandeweg.nl>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at g02sm02
X-Virus-Status: Clean
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch is a continuation of my previous work on `git config --add
--stdin`.[1] In the review it was noted that the approach could be more
extensible by using a DSL or instruction set like `update-ref`.

Like the previous patch, it hides input from the system allowing to set
secrets in the config file more securely.

[1]: https://public-inbox.org/git/20190917133135.190145-1-git@zjvandeweg.nl/T/#m287ad04b3dec77269643e35698df7fe4eb2f4f4f

Zeger-Jan van de Weg (1):
  config: learn the --stdin option for instructions

 Documentation/git-config.txt |  29 ++++++++++
 builtin/config.c             | 104 +++++++++++++++++++++++++++++++++++
 t/t1300-config.sh            |  60 ++++++++++++++++++++
 3 files changed, 193 insertions(+)

-- 
2.24.1

