Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D764AC433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 08:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A854661042
	for <git@archiver.kernel.org>; Mon, 17 May 2021 08:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhEQIEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 04:04:36 -0400
Received: from coleridge.oriole.systems ([89.238.76.34]:49798 "EHLO
        coleridge.oriole.systems" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhEQIEg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 04:04:36 -0400
From:   =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] rev-parse: Fix segfault and translate messages
Date:   Mon, 17 May 2021 10:02:41 +0200
Message-Id: <20210517080243.10191-1-wolf@oriole.systems>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516120449.661636-1-wolf@oriole.systems>
References: <20210516120449.661636-1-wolf@oriole.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a segfault in rev-parse and, whilst we're there, marks
previously untranslated error messages for translation.

Compared to v1, this series simplifies the test for --path-format
without and argument and adds the translation fix on top.

Wolfgang Müller (2):
  rev-parse: fix segfault with missing --path-format argument
  rev-parse: Mark die() messages for translation

 builtin/rev-parse.c  | 30 ++++++++++++++++--------------
 t/t1500-rev-parse.sh |  4 ++++
 2 files changed, 20 insertions(+), 14 deletions(-)

-- 
2.31.1

