Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A58C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 20:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B0661181
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 20:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhDIUnr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 16:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhDIUnq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 16:43:46 -0400
X-Greylist: delayed 1172 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Apr 2021 13:43:33 PDT
Received: from chkno.net (unknown [IPv6:2600:1700:5f21:c048::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4CEC061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 13:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=scottworley.com; s=20181127; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+ddU4BHfIWYU3bvo9ztpaXjsnpmHb0CDNbSUnB8QvLA=; b=i9TadGOcEOl+PejjYEVZb55YHL
        /cQdy8/hiyV5Tgw0e1jR5zw6CKv5Cx/X1WyqFEYvW/WRMUUhxTzK4IFQ1NOLnDEd87FgdLQan1gyK
        Xzt8+d9PtM5kngKNjMNzWYQ2+AKRJeL/0j6NWWWUdii+3urNy48GyFZur5/zpbrIrplpj6kvMaiq/
        fdpeIU0laNja41QmgC+u+Ft+cBVqxYbPNNQrMfn94HfO0ODJbL+5wDHmeiP6ifTKmxN1taBW6aOSm
        SJV6rCwljNXbXEBb9+sLiM35AEUCoP2HHQNF3GtcQV3FwE1H9qy8EDmUrCmvsjDsvDHAIcFR+jUW1
        iho2+7tJALquYrUIch8J+5ZQ0qa3eBO9rXHjEzGRw049Wk4yQKc8fY9x/yYfIJ06UBWqGG4LZ46uD
        FJYM1tVcGuz3EBrERmdz231saO0+JPQVBfLUrlEwAELoB8Vg0v5B9+X7pG+fKk8HeLLQEl2DFyfAq
        AlXbFT6hlPVKINyBAUrR+Q/4jUEdpc14QVyd3x657K2bUfmQT1jUkUH+oggeIEju5wM4Pe1PtYdPG
        sZRcNL2TPv2yL09pD2bUdVRmBQ5vLpfLGxa8zu8TJnc5fQ9Jv6PvFc2DnA/bb2AOcAg5dpKInOPE5
        ENKnMDUNl0v7j8+agFyelhHyZVm+NFGbtw8S/SZJs=;
Received: from chkno by chkno.net with local (Exim 4.92.3)
        (envelope-from <scottworley@scottworley.com>)
        id 1lUxe6-0007oW-Gw; Fri, 09 Apr 2021 13:22:26 -0700
From:   scottworley@scottworley.com
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Scott Worley <scottworley@scottworley.com>
Subject: [PATCH] doc: update advice about other implementations' v4 index support
Date:   Fri,  9 Apr 2021 13:22:06 -0700
Message-Id: <20210409202206.29990-1-scottworley@scottworley.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Scott Worley <scottworley@scottworley.com>

Signed-off-by: Scott Worley <scottworley@scottworley.com>
---
 Documentation/git-update-index.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 2853f168d9..e8eca5dadf 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -166,9 +166,10 @@ you will need to handle the situation manually.
 +
 Version 4 performs a simple pathname compression that reduces index
 size by 30%-50% on large repositories, which results in faster load
-time. Version 4 is relatively young (first released in 1.8.0 in
-October 2012). Other Git implementations such as JGit and libgit2
-may not support it yet.
+time. Version 4 is relatively young (first released in git 1.8.0 in
+October 2012, supported in libgit2 0.24.4 from December 2016, go-git
+4.0.0 from January 2018, and jgit 5.9.0 from September 2020). Other
+Git implementations such as Dulwich may not support it yet.
 
 -z::
 	Only meaningful with `--stdin` or `--index-info`; paths are
-- 
2.29.3

