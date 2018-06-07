Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372DD1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933036AbeFGOMe (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:12:34 -0400
Received: from siwi.pair.com ([209.68.5.199]:45508 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932875AbeFGOMb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:12:31 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 06CA33F415C;
        Thu,  7 Jun 2018 10:12:31 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8D28F3F4051;
        Thu,  7 Jun 2018 10:12:30 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v8 0/2] json-writer V8
Date:   Thu,  7 Jun 2018 14:12:07 +0000
Message-Id: <20180607141209.24423-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Here is V8 of my json-writer patches.  Please replace the existing V5/V6/V7
version of the jh/json-writer branch with this one.

This version uses perl rather than python to test the generated JSON.

Jeff Hostetler (2):
  json_writer: new routines to create data in JSON format
  json-writer: t0019: add perl unit test

 Makefile                    |   2 +
 json-writer.c               | 419 ++++++++++++++++++++++++++++++++
 json-writer.h               | 113 +++++++++
 t/helper/test-json-writer.c | 572 ++++++++++++++++++++++++++++++++++++++++++++
 t/t0019-json-writer.sh      | 274 +++++++++++++++++++++
 t/t0019/parse_json.perl     |  52 ++++
 6 files changed, 1432 insertions(+)
 create mode 100644 json-writer.c
 create mode 100644 json-writer.h
 create mode 100644 t/helper/test-json-writer.c
 create mode 100755 t/t0019-json-writer.sh
 create mode 100644 t/t0019/parse_json.perl

-- 
2.9.3

