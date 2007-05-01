From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: svn:externals using git submodules
Date: Tue, 1 May 2007 19:16:28 -0400
Message-ID: <20070501231628.GJ5942@spearce.org>
References: <200705011121.17172.andyparkins@gmail.com> <200705011936.14345.andyparkins@gmail.com> <20070501191703.GA25287@pe.Belkin> <200705012048.04817.andyparkins@gmail.com> <20070501202356.GA25531@pe.Belkin> <alpine.LFD.0.98.0705011512300.3808@woody.linux-foundation.org> <7vzm4o41bz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Shoemaker <c.shoemaker@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 02 01:16:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj1aN-0002Rb-37
	for gcvg-git@gmane.org; Wed, 02 May 2007 01:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829AbXEAXQh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 19:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbXEAXQh
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 19:16:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59816 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbXEAXQf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 19:16:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hj1a1-0006Ep-9s; Tue, 01 May 2007 19:16:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CD2B320FBAE; Tue,  1 May 2007 19:16:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vzm4o41bz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45992>

Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > But while I'm encouraged that the whole gitlink thing seems to be working 
> > for Andy, and some others are playing with it too, I'm also a bit 
> > discouraged by the fact that there hasn't been any noise or work on the 
> > porcelain side. I was obviously optimistic and hoping we'd see support in 
> > checkout/diff, but I haven't heard anybody talk about actually 
> > implementing .gitmodules and the porcelain support that uses them..
> 
> The thing is, almost all the core git people happen to be busy
> at the same time at this moment.  Johannes has just moved, Shawn
> and I are deep in day-jobs to the neck, ...

Heh, very true.  My short-term focus (this week) is git-gui,
then pack v4, and probably while working on pack v4 start at least
playing with Linus' gitlink thing and prototyping porcleain over it.
The gitlink work interests me, and I want to spend time on it,
but as Junio said, I'm overbooked...

-- 
Shawn.
