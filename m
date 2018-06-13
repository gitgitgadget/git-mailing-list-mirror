Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D95651F403
	for <e@80x24.org>; Wed, 13 Jun 2018 13:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935509AbeFMNOo (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 09:14:44 -0400
Received: from siwi.pair.com ([209.68.5.199]:10858 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935346AbeFMNOn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 09:14:43 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4447C3F404F;
        Wed, 13 Jun 2018 09:14:43 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CF7173F4047;
        Wed, 13 Jun 2018 09:14:42 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v10] json_writer V10
Date:   Wed, 13 Jun 2018 13:14:29 +0000
Message-Id: <20180613131430.13674-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Here is V10 of my json-writer patch.  I fixed the DEVELOPER=1 warnings
that Eric pointed out and refactored the indent_pretty() code as Junio
suggested.

Jeff Hostetler (1):
  json_writer: new routines to create JSON data

 Makefile                    |   2 +
 json-writer.c               | 414 ++++++++++++++++++++++++++++++++
 json-writer.h               | 105 ++++++++
 t/helper/test-json-writer.c | 565 ++++++++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c        |   1 +
 t/helper/test-tool.h        |   1 +
 t/t0019-json-writer.sh      | 331 ++++++++++++++++++++++++++
 t/t0019/parse_json.perl     |  52 ++++
 8 files changed, 1471 insertions(+)
 create mode 100644 json-writer.c
 create mode 100644 json-writer.h
 create mode 100644 t/helper/test-json-writer.c
 create mode 100755 t/t0019-json-writer.sh
 create mode 100644 t/t0019/parse_json.perl

-- 
2.9.3

