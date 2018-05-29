Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EFBB1F42D
	for <e@80x24.org>; Tue, 29 May 2018 12:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933734AbeE2MQh (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 08:16:37 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:35970 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933548AbeE2MQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 08:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6LvaQ07faFWAZSiuIdAVtGRz5XuFnnK5Yt970VisNNk=; b=dVmv+ycoBWdJrQQCni3qv81Baw
        48BQ0IIbhGvG/1Suo/khe1219Vx1887c78aAnsqVG+ipR5HngeWDBOpJzFAXv88D+sbtqn8Cei2oS
        ifSoslLnX7tNJ+gNGWLyIbSWGk22Oan7HIU7idmwsME+bLGzvkDp2lemYnWTsarWml+cjfxQ0WpoT
        kEbuZDVi7yL9K5MS9+uX/us7qZ9SccVHs8vvOgA8w/CVq6aOFarFW5opKeGDob5JcF/9TAw9e1Tf1
        xKYIQ1ljD/KTHR7DvxMluodk+apL+SOZFkr6TQeu4w0RN5fMlqxtMAoFd0RvOViXq6ui36Eg1A1iU
        JXuX5IYQ==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:40934 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fNdYC-008GWT-Md
        for git@vger.kernel.org; Tue, 29 May 2018 08:16:30 -0400
Date:   Tue, 29 May 2018 08:14:35 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] Fix grammar in "templates not found" msg
Message-ID: <alpine.LFD.2.21.1805290813440.9388@localhost.localdomain>
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

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 2542c5244..ec898f2c6 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -117,7 +117,7 @@ static void copy_templates(const char *template_dir)

 	dir = opendir(template_path.buf);
 	if (!dir) {
-		warning(_("templates not found %s"), template_dir);
+		warning(_("templates not found in %s"), template_dir);
 		goto free_return;
 	}


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
