Return-Path: <SRS0=wQ61=DL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5215BC4727D
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 11:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA1520797
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 11:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="MCX3Pz1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgJDLuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Oct 2020 07:50:09 -0400
Received: from mx1.riseup.net ([198.252.153.129]:45442 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgJDLuI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Oct 2020 07:50:08 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Oct 2020 07:50:08 EDT
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4C41yT3qbYzFdxd
        for <git@vger.kernel.org>; Sun,  4 Oct 2020 04:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1601811665; bh=qJheKqDkcLHPEuJNpL5vTFsW64CvfbwcxE0r0ZYGMho=;
        h=Date:From:To:Subject:From;
        b=MCX3Pz1fiwRQY0gxtffiGQ7PlMaaV+tZ3ON/frCgiJWsBJllWVhyG+p4rgfPaoY0+
         Aa6bP0/iP4Axy76aRMuiSCsfjEITc5VxDRsNPHxR4xxbo6Yymoy6zlTPwhLzNqGiAP
         G/lmXEYCB7l+X48LdDEGId/v2/f6Gn9MzwGMR1TA=
X-Riseup-User-ID: 42AA8CB66D2F5367E09195E052F0FE95E3FA641A8DC31D84DC0E71F37CA099E7
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 4C41yS4q5xz8tp9
        for <git@vger.kernel.org>; Sun,  4 Oct 2020 04:41:03 -0700 (PDT)
Date:   Sun, 4 Oct 2020 11:41:01 +0000
From:   Samanta Navarro <ferivoz@riseup.net>
To:     git@vger.kernel.org
Subject: [PATCH] fast-import: fix typo in documentation
Message-ID: <20201004114101.k5j7vhoxg5pyehmc@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Samanta Navarro <ferivoz@riseup.net>
---
 Documentation/git-fast-import.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 7d9aad2..39cfa05 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -814,7 +814,7 @@ may have uses for this information
 	'original-oid' SP <object-identifier> LF
 ....
 
-where `<object-identifer>` is any string not containing LF.
+where `<object-identifier>` is any string not containing LF.
 
 `tag`
 ~~~~~
-- 
2.28.0

