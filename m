X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Allow users to require source branch on git-checkout -b.
Date: Thu, 7 Dec 2006 16:59:14 -0500
Message-ID: <20061207215914.GC12502@spearce.org>
References: <20061207100152.GA12966@spearce.org> <7vlkljsd1k.fsf@assigned-by-dhcp.cox.net> <20061207195715.GG12143@spearce.org> <7v64cns8nf.fsf@assigned-by-dhcp.cox.net> <20061207214053.GC31035@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 21:59:30 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061207214053.GC31035@fieldses.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33638>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsRH1-0003Ja-9G for gcvg-git@gmane.org; Thu, 07 Dec
 2006 22:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163457AbWLGV7U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 16:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163469AbWLGV7U
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 16:59:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43359 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163457AbWLGV7T (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 16:59:19 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsRGl-0000F9-M7; Thu, 07 Dec 2006 16:59:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 3CF2A20FB6E; Thu,  7 Dec 2006 16:59:14 -0500 (EST)
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Thu, Dec 07, 2006 at 01:23:00PM -0800, Junio C Hamano wrote:
> > Under my suggestion, the new git-checkout -b (and git-branch)
> > would:
> > 
[snip]
> 
> That makes the default behavior more complicated to explain.  Is there
> really sufficient evidence that this a serious problem?

I'm seeing bad branches all to often with some of the folks I have
to work with.  They apparently have been unable to learn the new
trick of either remembering what branch they are currently on and
what changes it has, or to always supply the branch they want to
start from with their new branch.

Consequently they are cussing at Git rather often, as "this damn
Git crap always does the wrong with my files".  Despite it being
their own fault for not thinking before doing...

Of course many of these users also don't understand the value of a
good short diff for a simple change.  *sigh*  But right now I just
want to stop them from creating branches off the wrong branch point
95% of the time.

-- 
