Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B79C77B7A
	for <git@archiver.kernel.org>; Wed, 17 May 2023 07:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjEQHMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 03:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEQHMl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 03:12:41 -0400
X-Greylist: delayed 346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 00:12:30 PDT
Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [IPv6:2a01:4f8:13a:16c2::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82D41BE3
        for <git@vger.kernel.org>; Wed, 17 May 2023 00:12:30 -0700 (PDT)
Received: from leda.eworm.de (unknown [185.209.196.154])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id A118221FCA4;
        Wed, 17 May 2023 09:06:40 +0200 (CEST)
Received: by leda.eworm.de (Postfix, from userid 1000)
        id 1D018180A97; Wed, 17 May 2023 09:06:40 +0200 (CEST)
From:   Christian Hesse <list@eworm.de>
To:     git@vger.kernel.org
Cc:     Christian Hesse <mail@eworm.de>
Subject: [PATCH 1/1] imap-send: include strbuf.h
Date:   Wed, 17 May 2023 09:06:32 +0200
Message-Id: <20230517070632.71884-1-list@eworm.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Hesse <mail@eworm.de>

We use xstrfmt() here, so let's include the header file.

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 imap-send.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/imap-send.c b/imap-send.c
index a62424e90a..7f5426177a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -29,6 +29,7 @@
 #include "run-command.h"
 #include "parse-options.h"
 #include "setup.h"
+#include "strbuf.h"
 #include "wrapper.h"
 #if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
 typedef void *SSL;
-- 
2.40.1

