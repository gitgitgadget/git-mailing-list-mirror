Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D64412079E
	for <e@80x24.org>; Sun, 15 Jan 2017 17:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbdAORyV (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 12:54:21 -0500
Received: from sauhun.de ([89.238.76.85]:46348 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751165AbdAORyU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 12:54:20 -0500
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Jan 2017 12:54:20 EST
Received: from localhost (p54B33795.dip0.t-ipconnect.de [84.179.55.149])
        by pokefinder.org (Postfix) with ESMTPSA id 5996331C094;
        Sun, 15 Jan 2017 18:46:37 +0100 (CET)
From:   Wolfram Sang <wsa@the-dreams.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] request-pull: drop old USAGE stuff
Date:   Sun, 15 Jan 2017 18:46:35 +0100
Message-Id: <20170115174635.2422-1-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

request-pull uses OPTIONS_SPEC, so no need for (meanwhile incomplete)
USAGE and LONG_USAGE anymore.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

 git-request-pull.sh |    3 ---
 1 file changed, 3 deletions(-)

Index: git-2.11.0/git-request-pull.sh
===================================================================
--- git-2.11.0.orig/git-request-pull.sh
+++ git-2.11.0/git-request-pull.sh
@@ -4,9 +4,6 @@
 # This file is licensed under the GPL v2, or a later version
 # at the discretion of Linus Torvalds.
 
-USAGE='<start> <url> [<end>]'
-LONG_USAGE='Summarizes the changes between two commits to the standard output,
-and includes the given URL in the generated summary.'
 SUBDIRECTORY_OK='Yes'
 OPTIONS_KEEPDASHDASH=
 OPTIONS_STUCKLONG=
