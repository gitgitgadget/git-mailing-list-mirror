From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 15:48:25 -0500
Message-ID: <20060323204825.GE30176@spearce.org>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org> <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org> <44223B90.3040500@zytor.com> <1143128751.6850.35.camel@neko.keithp.com> <Pine.LNX.4.64.0603230758260.26286@g5.osdl.org> <BAYC1-PASMTP0912D2287AB923F3338969AEDE0@CEZ.ICE> <Pine.LNX.4.64.0603231134160.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sean <seanlkml@sympatico.ca>, keithp@keithp.com, hpa@zytor.com,
	jbglaw@lug-owl.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 21:49:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMWjp-0004IL-Il
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 21:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWCWUsx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 15:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbWCWUsx
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 15:48:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:19400 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1422685AbWCWUsv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 15:48:51 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FMWjE-0002e6-0B; Thu, 23 Mar 2006 15:48:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 51A2320FB89; Thu, 23 Mar 2006 15:48:25 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603231134160.26286@g5.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17870>

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> On Thu, 23 Mar 2006, sean wrote:
> > 
> > lol, that sounds like a really good plan.  Perhaps as a two pronged effort
> > its worth changing the notion that git is primarily "plumbing".   Adding
> > some of the nice features of cogito and other "porcelains" into the core
> > git might go a ways toward converting the few naysayers we don't kill.
> 
> Actually, as far as I can tell, git already has a hell of a lot more 
> porcelain than pretty much any non-IDE type traditional SCM. Certainly 
> more than CVS.
> 
> Yeah, I'm not counting things like Eclipse etc. I'm talking about "plain 
> SCM" environments, ie just basic SVN or CVS. What are we missing in that 
> department? (The only thing I can think of is a diff colorizer, which some 
> prople seem to really want).

A pretty native point-and-click Windows GUI so Windows users can
use GIT without knowing how to actually use their computer.  :-)

I'm not trying to bash Windows users.  I'm just saying that there's
definately a large user base for SCMs such as CVS who just want
to check in the latest version of a file they have to maintain.
Many of these people are afraid of a command prompt.  Asking them
to install Cygwin just to check in a file is a difficult challenge.

And even if a user is perfectly comfortable with a command prompt
and could write one-line scripts faster than anyone else, sometimes
users just prefer a GUI interface.

qgit probably comes close in this department but hasn't been packaged
up into a pretty Windows installer.  :-)


But your definately right; once the blame/annotate war settles out
GIT will have pretty much everything one might need - except a good
distributed bug/issue tracking type system.  :-)

-- 
Shawn.
