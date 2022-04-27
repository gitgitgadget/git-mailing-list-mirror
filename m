Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAF2C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 20:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbiD0UeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 16:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiD0UeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 16:34:09 -0400
X-Greylist: delayed 2129 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Apr 2022 13:30:56 PDT
Received: from smtp.onerussian.com (washoe.dartmouth.edu [129.170.30.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5D1B3C78
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 13:30:55 -0700 (PDT)
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <yoh@onerussian.com>)
        id 1njnkx-0001vA-CO; Wed, 27 Apr 2022 15:55:23 -0400
From:   Yaroslav Halchenko <debian@onerussian.com>
To:     git@vger.kernel.org
Cc:     Yaroslav Halchenko <debian@onerussian.com>
Date:   Wed, 27 Apr 2022 15:54:50 -0400
Message-Id: <20220427195450.366703-1-debian@onerussian.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org, yoh@onerussian.com
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: [PATCH] Documentation: replace - use consistent 'replace reference'
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a new user to 'git replace' I found it a little uncertain about what
"'replace' reference" documentation was talking since there was only
"replacement" mentioned in the command summary.  Decided to make it more
consistent as 'replace reference' after checking that in a few spots there is a
use of multi word entries within <>.

Signed-off-by: Yaroslav Halchenko <debian@onerussian.com>
---
 Documentation/git-replace.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index f271d758c3..71f98edfe3 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -8,7 +8,7 @@ git-replace - Create, list, delete refs to replace objects
 SYNOPSIS
 --------
 [verse]
-'git replace' [-f] <object> <replacement>
+'git replace' [-f] <object> <replace reference>
 'git replace' [-f] --edit <object>
 'git replace' [-f] --graft <commit> [<parent>...]
 'git replace' [-f] --convert-graft-file
@@ -17,16 +17,16 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Adds a 'replace' reference in `refs/replace/` namespace.
+Adds a 'replace reference' in `refs/replace/` namespace.
 
-The name of the 'replace' reference is the SHA-1 of the object that is
-replaced. The content of the 'replace' reference is the SHA-1 of the
+The name of the 'replace reference' is the SHA-1 of the object that is
+replaced. The content of the 'replace reference' is the SHA-1 of the
 replacement object.
 
 The replaced object and the replacement object must be of the same type.
 This restriction can be bypassed using `-f`.
 
-Unless `-f` is given, the 'replace' reference must not yet exist.
+Unless `-f` is given, the 'replace reference' must not yet exist.
 
 There is no other restriction on the replaced and replacement objects.
 Merge commits can be replaced by non-merge commits and vice versa.
-- 
2.35.1

