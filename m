Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64EDC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 13:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbiHRNOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 09:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244793AbiHRNNu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 09:13:50 -0400
Received: from mailproxy03.manitu.net (mailproxy03.manitu.net [217.11.48.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4439184EF0
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 06:13:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a5d:5400:e242:9824:2cff:8bd5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy03.manitu.net (Postfix) with ESMTPSA id 15DFF12A018B;
        Thu, 18 Aug 2022 15:13:33 +0200 (CEST)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 4/4] po: adjust README to code
Date:   Thu, 18 Aug 2022 15:13:29 +0200
Message-Id: <e163c87b3efc1571cb3657df6459583af92f9f2b.1660828108.git.git@grubix.eu>
X-Mailer: git-send-email 2.37.2.596.g72ccb331cf
In-Reply-To: <cover.1660828108.git.git@grubix.eu>
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr> <cover.1660828108.git.git@grubix.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we talk about sequencer action names as such (as opposed to command
names) we do translate the action name. Adjust the po README to reflect
this and to match the code base.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 po/README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/README.md b/po/README.md
index 3e4f897d93..90b8455401 100644
--- a/po/README.md
+++ b/po/README.md
@@ -273,7 +273,7 @@ General advice:
 
   ```c
   /* TRANSLATORS: %s will be "revert" or "cherry-pick" */
-  die(_("%s: Unable to write new index file"), action_name(opts));
+  die(_("%s: Unable to write new index file"), _(action_name(opts)));
   ```
 
 We provide wrappers for C, Shell and Perl programs. Here's how they're
-- 
2.37.2.596.g72ccb331cf

