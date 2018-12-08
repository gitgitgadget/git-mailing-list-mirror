Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1876820A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 15:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeLHPAM (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 10:00:12 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:39726 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeLHPAL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 10:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IrQFjxxhZSvdtGXhkh2oBUwbU+9PXPzNaSiGQINwGpk=; b=WHnz4vKft44ayHD+Aih12o2V67
        AMPWge/Pww0tOm6bJfe+2rEOvz7tTOWkV1DgZFhnbXmJQoThAXojDIBK/axNnUM0s7pi4O4eOIy38
        uRFqLOxb44ThfnsY8+/no1aNFddJkSY89Gwx0BTTgM7Hvf3RVM5ZAnz6hOGJTRQODnUrxyrlhXg86
        P0GLaUxLCaEDJojiKY8wBslwi2xnsTMDXCwGLYf9keTKJQHPpEty6g8jd3q0nBc55/tgXd9Son48Q
        epnTOlCoDEltrPE0Ne2+pasTP5J1aHhk5X7kqEU5kRwvcoGGIC+O2TOvP7ERalSwChjnu8VBG6aV5
        fD766PLQ==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:47682 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gVe5R-0001qh-Ih
        for git@vger.kernel.org; Sat, 08 Dec 2018 10:00:10 -0500
Date:   Sat, 8 Dec 2018 10:00:06 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: Documentation: update "man git-add" to include "[]"
Message-ID: <alpine.LFD.2.21.1812080958180.26244@localhost.localdomain>
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


Current "man git-add" emphasizes single letter interactive
shortcut commands with "[]".

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 45652fe4a6..ad9bd7c7a6 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -239,8 +239,8 @@ and type return, like this:

 ------------
     *** Commands ***
-      1: status       2: update       3: revert       4: add untracked
-      5: patch        6: diff         7: quit         8: help
+      1: [s]tatus     2: [u]pdate     3: [r]evert     4: [a]dd untracked
+      5: [p]atch      6: [d]iff       7: [q]uit       8: [h]elp
     What now> 1
 ------------


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
