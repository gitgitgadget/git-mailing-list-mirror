X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Allow users to require source branch on git-checkout -b.
Date: Fri, 8 Dec 2006 00:59:38 -0500
Message-ID: <20061208055938.GB13999@spearce.org>
References: <20061207100152.GA12966@spearce.org> <7vlkljsd1k.fsf@assigned-by-dhcp.cox.net> <20061207195715.GG12143@spearce.org> <7v64cns8nf.fsf@assigned-by-dhcp.cox.net> <20061207214053.GC31035@fieldses.org> <20061207215914.GC12502@spearce.org> <20061208044516.GC5939@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 05:59:52 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061208044516.GC5939@fieldses.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33658>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsYly-0008OH-Bj for gcvg-git@gmane.org; Fri, 08 Dec
 2006 06:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424645AbWLHF7o (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 00:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424711AbWLHF7o
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 00:59:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34344 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1424645AbWLHF7o (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 00:59:44 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsYlo-0007JW-DF; Fri, 08 Dec 2006 00:59:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 F18DB20FB6E; Fri,  8 Dec 2006 00:59:38 -0500 (EST)
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Thu, Dec 07, 2006 at 04:59:14PM -0500, Shawn Pearce wrote:
> > I'm seeing bad branches all to often with some of the folks I have
> > to work with.  They apparently have been unable to learn the new
> > trick of either remembering what branch they are currently on and
> > what changes it has, or to always supply the branch they want to
> > start from with their new branch.
> 
> Would the trick of putting the branch name in the shell prompt work?

Its in the prompt for all of these users; I forced it in as part of
the system's /etc/profile.d.  They just forget that they should think
about where they should start their branch from before they make it.
 
> But my main complaint is just that I wouldn't want to see the behavior
> of defaulting to HEAD--behavior which is simple, easy to explain, and
> shared by most other git commands--by something significantly more
> complicated.  That's more a complaint about Junio's suggestion than
> yours, though.

True, defaulting to HEAD is something that is done almost everywhere.
Changing it for `git checkout -b` may surprise a lot of people,
almost as much as --index vs. --cached.

Maybe what I should do is stop whining about the command line
Porcelain-ish and get branch controls working in git-gui.  Then I
can take away the command line from these users who are causing me
so much grief.

-- 
