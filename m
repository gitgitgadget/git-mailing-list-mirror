X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Avoiding uninteresting merges in Cairo
Date: Thu, 14 Dec 2006 21:06:29 -0500
Message-ID: <20061215020629.GK26202@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 02:06:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34459>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv2T8-00015r-8F for gcvg-git@gmane.org; Fri, 15 Dec
 2006 03:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964966AbWLOCGe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 21:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWLOCGe
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 21:06:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48795 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964966AbWLOCGd (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 21:06:33 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gv2Sq-0003fi-5V; Thu, 14 Dec 2006 21:06:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 AA6A920FB65; Thu, 14 Dec 2006 21:06:29 -0500 (EST)
To: cworth@cworth.org
Sender: git-owner@vger.kernel.org

I was just talking with jwatt today in #git and he pointed me at
the following email from

 http://lists.freedesktop.org/archives/cairo/2006-April/006648.html

after he had a merge gone wrong in his working directory and was
asking for help.

Cario has seriously been using `reset --hard HEAD^` as part of its
workflow since April?  Why haven't you pushed for a rebase merge
strategy to be tried before a trivial index merge as an option in
git-merge (e.g. pull.twohead=rebase recursive)?

-- 
