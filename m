Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4446CC43381
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 14:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE7365086
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 14:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhCPOtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhCPOtV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 10:49:21 -0400
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 Mar 2021 07:49:20 PDT
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54D2C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 07:49:20 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyleam.com; s=key1;
        t=1615905649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rnpLrIjk4qjkM0csS5tr+VCI7HuV5Il2q63GBDiIbg8=;
        b=hRjknxOCXI17BxoKb1yVcyD8dyyc1tqMM3FH7Lhr7EmC652upd0a2oUZFchG9SGS7P98eo
        Y8PW/YotbSjqQGdWML97BLIAYNhldqTRFA5cz76izFaX/3Yv8MbrSA4YNzjqF/vTfhahI2
        9eirgopv8mHMCqhOnNr4esD7CpSphUINn9jJFLzuRTeGy++LqzbImjEAfHHckJwn9AaMOK
        fw89VIHgbPYmRVBOZxivl3tr8Z0G5xU7vC7ClD9e1KCiVAvFLrQRUXoCu4I3Xn7gpYfxI4
        kW2CPzl0JDqpp+orrrdqfb8mkd0o1nvGknWmUbt1zW+9tz1fmxJumfNyWElz0A==
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Subject: [PATCH] config.txt: add missing period
Date:   Tue, 16 Mar 2021 10:40:40 -0400
Message-Id: <20210316144040.23976-1-kyle@kyleam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: kyle@kyleam.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6ba50b1104..06615d840b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -46,7 +46,7 @@ Subsection names are case sensitive and can contain any characters except
 newline and the null byte. Doublequote `"` and backslash can be included
 by escaping them as `\"` and `\\`, respectively. Backslashes preceding
 other characters are dropped when reading; for example, `\t` is read as
-`t` and `\0` is read as `0` Section headers cannot span multiple lines.
+`t` and `\0` is read as `0`. Section headers cannot span multiple lines.
 Variables may belong directly to a section or to a given subsection. You
 can have `[section]` if you have `[section "subsection"]`, but you don't
 need to.
-- 
2.31.0.rc2.327.gc8bc67eb22

