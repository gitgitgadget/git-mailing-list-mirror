Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D791A201C2
	for <e@80x24.org>; Tue, 18 Apr 2017 19:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757554AbdDRTom (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 15:44:42 -0400
Received: from siwi.pair.com ([209.68.5.199]:23591 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755504AbdDRTol (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 15:44:41 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A56F584590;
        Tue, 18 Apr 2017 15:44:29 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1] diffcore-rename speedup
Date:   Tue, 18 Apr 2017 19:44:20 +0000
Message-Id: <20170418194421.22453-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Here is another micro-optimization for very large repositories.
Speed up register_rename_src() in diffcore-rename.c

Jeff Hostetler (1):
  diffcore-rename: speed up register_rename_src

 diffcore-rename.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.9.3

