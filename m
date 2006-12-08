X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 1/2] Allow users to require source branch on git-checkout -b.
Date: Thu, 7 Dec 2006 23:45:16 -0500
Message-ID: <20061208044516.GC5939@fieldses.org>
References: <20061207100152.GA12966@spearce.org> <7vlkljsd1k.fsf@assigned-by-dhcp.cox.net> <20061207195715.GG12143@spearce.org> <7v64cns8nf.fsf@assigned-by-dhcp.cox.net> <20061207214053.GC31035@fieldses.org> <20061207215914.GC12502@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 04:45:26 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061207215914.GC12502@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33655>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsXbv-0003EF-2k for gcvg-git@gmane.org; Fri, 08 Dec
 2006 05:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424375AbWLHEpT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 23:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424387AbWLHEpT
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 23:45:19 -0500
Received: from mail.fieldses.org ([66.93.2.214]:34815 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1424375AbWLHEpS (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 23:45:18 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GsXbo-00029S-8U; Thu, 07 Dec 2006
 23:45:16 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Thu, Dec 07, 2006 at 04:59:14PM -0500, Shawn Pearce wrote:
> I'm seeing bad branches all to often with some of the folks I have
> to work with.  They apparently have been unable to learn the new
> trick of either remembering what branch they are currently on and
> what changes it has, or to always supply the branch they want to
> start from with their new branch.

Well, it's true that "git branch" is the first thing I type whenever I
sit down, just to remember where I am....

Would the trick of putting the branch name in the shell prompt work?

> Consequently they are cussing at Git rather often, as "this damn
> Git crap always does the wrong with my files".  Despite it being
> their own fault for not thinking before doing...
> 
> Of course many of these users also don't understand the value of a
> good short diff for a simple change.  *sigh*  But right now I just
> want to stop them from creating branches off the wrong branch point
> 95% of the time.

But my main complaint is just that I wouldn't want to see the behavior
of defaulting to HEAD--behavior which is simple, easy to explain, and
shared by most other git commands--by something significantly more
complicated.  That's more a complaint about Junio's suggestion than
yours, though.

