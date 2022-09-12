Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0E9ECAAA1
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 05:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiILFv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 01:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiILFv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 01:51:58 -0400
X-Greylist: delayed 393 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Sep 2022 22:51:56 PDT
Received: from mailproxy09.manitu.net (mailproxy09.manitu.net [217.11.48.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D842529A
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 22:51:56 -0700 (PDT)
Received: from localhost (p200300ef4f07e90026418cfffe37d02a.dip0.t-ipconnect.de [IPv6:2003:ef:4f07:e900:2641:8cff:fe37:d02a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: u16723@rkita.de)
        by mailproxy09.manitu.net (Postfix) with ESMTPSA id 2874512000C1;
        Mon, 12 Sep 2022 07:45:23 +0200 (CEST)
From:   Rene Kita <mail@rkta.de>
To:     git@vger.kernel.org
Cc:     Rene Kita <mail@rkta.de>
Subject: [PATCH 2/2] blame: Document that --show-name is negatable
Date:   Mon, 12 Sep 2022 07:45:15 +0200
Message-Id: <20220912054515.29559-3-mail@rkta.de>
X-Mailer: git-send-email 2.37.3.544.g5c9b9c0a4e
In-Reply-To: <20220912054515.29559-1-mail@rkta.de>
References: <20220912054515.29559-1-mail@rkta.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Kita <mail@rkta.de>
---
 Documentation/git-blame.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index d7a46cc674..75e115f97e 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -63,7 +63,7 @@ include::blame-options.txt[]
 	of code to have been moved.
 
 -f::
---show-name::
+--[no-]show-name::
 	Show the filename in the original commit.  By default
 	the filename is shown if there is any line that came from a
 	file with a different name, due to rename detection.
-- 
2.37.3.544.g5c9b9c0a4e

