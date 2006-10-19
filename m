From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 13:01:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610191250400.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com>
 <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
 <45355CBB.80108@utoronto.ca> <BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE>
 <eh64tk$rug$2@sea.gmane.org> <BAYC1-PASMTP069C473B2E79389E5BFC92AE0F0@CEZ.ICE>
 <eh6dgr$pu8$1@sea.gmane.org> <Pine.LNX.4.63.0610190144450.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <4536DBB1.6050701@spamcop.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 13:02:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaVet-0008HQ-So
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 13:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161405AbWJSLBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 07:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161396AbWJSLBw
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 07:01:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:6085 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161413AbWJSLBv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 07:01:51 -0400
Received: (qmail invoked by alias); 19 Oct 2006 11:01:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 19 Oct 2006 13:01:49 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Charles Duffy <cduffy@spamcop.net>
In-Reply-To: <4536DBB1.6050701@spamcop.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29337>

Hi,

On Wed, 18 Oct 2006, Charles Duffy wrote:

> Johannes Schindelin wrote:

you neatly clipped the most important part of my email: I quoted you 
saying that plugins can even change core behaviour!

> > So, the wonderful upside of plugins you described here are actually the
> > reason I will never, _never_ use bzr with plugins.
> > 
> 
> I presume that for this reason you will also never, _never_ use a 
> non-mainline branch of git -- even if its actual code only touches UI 
> enhancements or something similarly non-core

NO! The point was that I will not gladly run anything which could change 
the core. If I know it touches only the UI, there is no problem.

If I get a shell script using git-core programs to do its job, I 
_know_ that my repository will not be fscked afterwards.

And _that_ was the whole point of my email.

> And that you will never, _never_ use third-party wrappers because they 
> might play LD_PRELOAD tricks. Or run any software with root privileges 
> you haven't personally written. Or...

Most of it comes down to trust. And yes, you are correct, I will not run 
git with some obscure module LD_PRELOADed that some guy from some planet 
sent me.

You might have missed my argument being about the SCM, and not the 
universe and all the rest.

> The claim that an extensibility mechanism should be rejected wholesale 
> on account of being excessively powerful, on the other hand, is just 
> silly.

Oh, but NO! An extensibility mechanism which allows for a fragile system 
_is_ silly. Not my rejection of it.

Just take an example (illustrating that once again, one should not 
attribute everything to malevolence...): I write a plugin for bzr. It does 
really wonderful things, it even cooks you dinner.

Only that I happened to make a small mistake (if you followed some threads 
on the git list, you'd know that small mistakes are a hobby of mine), and 
by this mistake, your repository is ... gone. Small mistake, big 
consequence. That is wrong with such a powerful system which caters for 
developers, which are human after all.

Note that such a small mistake would be much more likely caught in git: if 
it touches the core, plenty of eyes look at it.

Ciao,
Dscho
