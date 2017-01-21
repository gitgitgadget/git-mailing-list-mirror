Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95D5B20ABE
	for <e@80x24.org>; Sat, 21 Jan 2017 01:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbdAUBIi (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 20:08:38 -0500
Received: from 89-28-117-31.starnet.md ([89.28.117.31]:54126 "EHLO
        home.thecybershadow.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbdAUBIg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 20:08:36 -0500
Received: by home.thecybershadow.net (Postfix, from userid 1000)
        id C9BFA55BDEB; Sat, 21 Jan 2017 01:08:32 +0000 (UTC)
From:   Vladimir Panteleev <git@thecybershadow.net>
To:     git@vger.kernel.org
Subject: [PATCH v2] show-ref: Allow -d, --head to work with --verify
Date:   Sat, 21 Jan 2017 01:08:17 +0000
Message-Id: <20170121010821.25046-1-git@thecybershadow.net>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second take for "[PATCH] show-ref: Allow --head to work
with --verify". Thanks to Junio for his extensive feedback.

