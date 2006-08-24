From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] adding support for md5
Date: Thu, 24 Aug 2006 04:08:07 -0400
Message-ID: <20060824080807.GG25247@spearce.org>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com> <Pine.LNX.4.64.0608191339010.11811@g5.osdl.org> <20060821204430.GA2700@tuatara.stupidest.org> <7vr6z9s376.fsf@assigned-by-dhcp.cox.net> <20060823041453.GA25796@spearce.org> <7v3bbojbzj.fsf@assigned-by-dhcp.cox.net> <20060823064900.GA26340@spearce.org> <7vac5ubn57.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 10:08:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGAGH-0004p6-ON
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 10:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWHXIIW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 04:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWHXIIW
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 04:08:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:31622 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750819AbWHXIIV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 04:08:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GGAG9-00029f-51; Thu, 24 Aug 2006 04:08:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3833A20FB82; Thu, 24 Aug 2006 04:08:07 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac5ubn57.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25946>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> >> > What about all of those memcpy(a, b, 20)'s?  :-)
> >> 
> >> Surely.  If you are inclined to, go wild.
> >
> > Like this?  :-)
> 
> Except some minor nits, yes.
> 
>  * I would have preferred two patches, one for "master" and one
>    for the C merge-recursive topic (or at least "next").

Doh.  I didn't realize this was something you were interested in
pulling into master.  Otherwise I would have done this.  Next time
I'll try to keep that in mind.
 
>  * You missed a few in "master".

Not surprising since I typically work against and use next.
 
>  * The cast in the second hunk in combine-diff.c was wrong;
>    breakage was caught by our testsuite.

OK, that's just flat out stupid of me.  I apologize for making you
fix my mistakes.  :-)

> I've pushed out a fixed up result in "master" and "next".

Thanks.

-- 
Shawn.
