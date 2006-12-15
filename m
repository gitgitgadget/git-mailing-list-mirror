X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Avoiding uninteresting merges in Cairo
Date: Thu, 14 Dec 2006 22:25:30 -0500
Message-ID: <20061215032530.GM26202@spearce.org>
References: <20061215020629.GK26202@spearce.org> <87tzzx4zm7.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 03:25:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <87tzzx4zm7.wl%cworth@cworth.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34467>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv3hh-000891-9N for gcvg-git@gmane.org; Fri, 15 Dec
 2006 04:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965055AbWLODZm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 22:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbWLODZm
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 22:25:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51769 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751743AbWLODZm (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 22:25:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gv3hO-0006Jo-Nf; Thu, 14 Dec 2006 22:25:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 668E720FB65; Thu, 14 Dec 2006 22:25:30 -0500 (EST)
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> wrote:
> One thing I've been meaning to do is to write up a more complete
> introduction on using git to manage cairo's tree to put into cairo's
> wiki or so, (it would have helped a newcomer like jwatt here).

I saw three things happen to poor jwatt that really threw him for
a loop, and I think they are all more likely related to Git than
to the Cairo project specifically:

 * His user.name/user.email is probably not what he wanted;

 * His Cygwin/Windows system made some *.c/*.c files 0755 without
   him realizing it;

 * gitweb made it appear as though a whole lot of Carl's recent
   work was somehow undone in the merge.

-- 
