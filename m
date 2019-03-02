Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0991A20248
	for <e@80x24.org>; Sat,  2 Mar 2019 08:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfCBIv5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 03:51:57 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:45482 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfCBIv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 03:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6zRRuqQQGKF9AIr1Aifkq1tzkhfvOf7kPQEJ1/JPid8=; b=pbBGwK8lAhFPzdWpQjnxWo6LqZ
        pgEH204ZcpLvcc4SYI9LMwbCqg7yBtbe8+XtPWpIPyDn8AVP7XR7VQ4IOcbiNJQR/QR+8G9TJ3AYi
        132B684/D4L5/urBjSUsNgyLxPKhJDXBRZBgBe9syZIW6iXD5FwjvcomCCeU07DHEW2XLMKylHpLR
        zcEJNmzSadwJMOI/6+QMn0qP1s/HUgXHgHBwVCNGQ2fulKBM3M/fuhpqx8VYYtIjIJjeSLB3xLIxb
        9j3Tj9GyITs67bDwFKBRcr6DsaUyobAZBF4knQXn2uOfeN/UJrC4qhMmGm0IxzeAuursgE4GgY45b
        Xf5WoJtQ==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:59080 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h00N7-004Pfu-Rk
        for git@vger.kernel.org; Sat, 02 Mar 2019 03:51:55 -0500
Date:   Sat, 2 Mar 2019 03:51:52 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] docs/git-gc: fix typo "--prune=all" to "--prune=now"
Message-ID: <alpine.LFD.2.21.1903020350010.1955@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index a7442499f6..a7c1b0f60e 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -76,7 +76,7 @@ be performed as well.
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
 	overridable by the config variable `gc.pruneExpire`).
-	--prune=all prunes loose objects regardless of their age and
+	--prune=now prunes loose objects regardless of their age and
 	increases the risk of corruption if another process is writing to
 	the repository concurrently; see "NOTES" below. --prune is on by
 	default.

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
