X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] make commit message a little more consistent and conforting
Date: Thu, 14 Dec 2006 23:24:59 -0500
Message-ID: <20061215042459.GC27343@spearce.org>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612132237.10051.andyparkins@gmail.com> <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com> <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612141343200.18171@xanadu.home> <Pine.LNX.4.64.0612142307160.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 04:25:24 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612142307160.18171@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34471>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv4dN-00046x-EY for gcvg-git@gmane.org; Fri, 15 Dec
 2006 05:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932178AbWLOEZI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 23:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWLOEZI
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 23:25:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53771 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932178AbWLOEZG (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 23:25:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gv4cr-0001xL-L0; Thu, 14 Dec 2006 23:24:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 77FF920FB65; Thu, 14 Dec 2006 23:25:00 -0500 (EST)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> wrote:
> It is nicer to let the user know when a commit succeeded all the time, 
> not only the first time.  Also the commit sha1 is much more useful than 
> the tree sha1 in this case.

I agree the commit sha1 is more useful than the tree sha1, but I'm
not really sure its useful to show the commit sha1 post commit.
If you want to show something the diffstat like what git merge does
is better.

For one thing it confirms that git accepted the changes.  For another
it shows you *which* changes it accepted.  Plus it responds just
like git-merge or git-pull does.

Of course the meaning of the diffstat is entirely different in both
cases; in the commit case its what has been recorded while in the
merge case its not only what has been recorded into your current
branch history but also what has been done to your working directory.

-- 
