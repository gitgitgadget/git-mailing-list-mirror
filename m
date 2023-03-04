Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6991C678D5
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 17:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCDRIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 12:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDRIN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 12:08:13 -0500
X-Greylist: delayed 438 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Mar 2023 09:08:10 PST
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B29AD09
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 09:08:10 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4PTWLl5K1Cz1s954
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 18:00:47 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4PTWLl59QNz1qqlR
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 18:00:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id GLZKEBZjvqk0 for <git@vger.kernel.org>;
        Sat,  4 Mar 2023 18:00:47 +0100 (CET)
X-Auth-Info: +6X5S61I0gb+LCgmobqCWWH0gFRteEZ5EKoZzbItMPelp3hwESAxAAyG7kMVsas9
Received: from igel.home (aftr-82-135-86-220.dynamic.mnet-online.de [82.135.86.220])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 18:00:47 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id CE2792C13C8; Sat,  4 Mar 2023 18:00:46 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     git@vger.kernel.org
Subject: [PATCH] git-merge-tree.txt: replace spurious HTML entity
X-Yow:  I am a traffic light, and Alan Ginsberg kidnapped my laundry in 1927!
Date:   Sat, 04 Mar 2023 18:00:46 +0100
Message-ID: <87y1oco3i9.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 Documentation/git-merge-tree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 88ee942101..ffc4fbf7e8 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -108,7 +108,7 @@ This is an integer status followed by a NUL character.  The integer status is:
 
      0: merge had conflicts
      1: merge was clean
-     &lt;0: something prevented the merge from running (e.g. access to repository
+     <0: something prevented the merge from running (e.g. access to repository
 	 objects denied by filesystem)
 
 [[OIDTLT]]
-- 
2.39.1


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
