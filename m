Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE65BC2D0EF
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 04:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11C82054F
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 04:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403819AbgDPET3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 00:19:29 -0400
Received: from aibo.runbox.com ([91.220.196.211]:57568 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389455AbgDPET0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 00:19:26 -0400
Received: from [10.9.9.204] (helo=mailfront22.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <me@pluvano.com>)
        id 1jOvzm-0003Ic-LC; Thu, 16 Apr 2020 06:19:22 +0200
Received: by mailfront22.runbox with esmtpsa  [Authenticated alias (964124)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1jOvzX-0006TH-4T; Thu, 16 Apr 2020 06:19:07 +0200
From:   Emma Brooks <me@pluvano.com>
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>, Emma Brooks <me@pluvano.com>
Subject: [PATCH] Documentation: explain "mboxrd" pretty format
Date:   Thu, 16 Apr 2020 04:16:59 +0000
Message-Id: <20200416041658.85100-1-me@pluvano.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "mboxrd" pretty format was introduced in 9f23e04061 (pretty: support
"mboxrd" output format, 2016-06-05) but wasn't mentioned in the
documentation.

Signed-off-by: Emma Brooks <me@pluvano.com>
---
 Documentation/pretty-formats.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index a4b6f49186..547a552463 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -83,6 +83,12 @@ placeholders, its output is not affected by other options like
 
 	  <full commit message>
 
+* 'mboxrd'
++
+Like 'email', but lines in the commit message starting with "From "
+(preceded by zero or more ">") are quoted with ">" so they aren't
+confused as starting a new commit.
+
 * 'raw'
 +
 The 'raw' format shows the entire commit exactly as
