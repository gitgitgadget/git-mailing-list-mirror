From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "Producting Open Source Software" book and distributed SCMs
Date: Tue, 1 May 2007 17:45:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705011734460.4010@racer.site>
References: <200704300120.42576.jnareb@gmail.com> <Pine.LNX.4.64.0705011057130.29859@racer.site>
 <20070501152342.GB26093@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue May 01 17:45:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiuXX-0000Fb-UC
	for gcvg-git@gmane.org; Tue, 01 May 2007 17:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbXEAPpQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 11:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752817AbXEAPpQ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 11:45:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:48340 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752702AbXEAPpN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 11:45:13 -0400
Received: (qmail invoked by alias); 01 May 2007 15:45:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 01 May 2007 17:45:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5RHBGUov5mEcovzdoeZ0fI2I6Q1P/7pHAwRnsEw
	ZafbRqipmMBizS
X-X-Sender: gene099@racer.site
In-Reply-To: <20070501152342.GB26093@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45951>

Hi,

On Tue, 1 May 2007, Theodore Tso wrote:

> On Tue, May 01, 2007 at 11:35:54AM +0200, Johannes Schindelin wrote:
> > > [...]
> > 
> > Forks are good. In fact, we all "forked" with CVS as soon as we began 
> > hacking. Everybody who claims to never have started over from a fresh 
> > checkout, or from an "update -C"ed state, is probably lying, or a bad 
> > developer. Thinking about it, I believe that the difference between 
> > forking and branching is philosophical, not technical. You can always 
> > merge a fork.
> 
> There's a confusion going on here between a "fork" meaning a branch in 
> the SCM sense of the word, and a "Project Fork" where there are two 
> camps competing for developers and users.

So you agree! I said that it is a philosophical, and not a technical 
issue.

> So for example, having kerenl developers develop using branches which 
> are then merged into the -mm tree and then into Linus tree --- Good.  
> In the suspend-to-disk world, where we have *three* separate 
> implementations, with two in the mainline tree, and one very popular 
> one, suspend2, with features that niether of the in-mainline 
> implementations have, and with Pavel constantly casting aspersions at 
> Nigel because he's splitting the development effort --- Not So Good.

But why! Because Pavel is just ignoring reality. I always wondered why the 
work of Nigel was never considered for inclusion, even if it was clearly 
superiour from a usability view point.

And if it is usable, but not clean, then clean it up. Instead, Pavel seems 
to never even have considering casting his planet sized ego aside and 
admit that his work is just not up to par with Nigel's, and start to 
clean up suspend2.

So in that case, I am even _more_ happy that forking is so easy, because I 
did not _have_ to suffer all that much from people who cannot enter my 
flat because their head does not fit through the door, but I could just 
happily use suspend2 and be fine.

BTW the same goes for Reiser4, which is quite fast and flexible, and I do 
not care at all about the ardent discussions around it.

> I prefer to use the term "branch" to talk about a SCM and development 
> series, and to use the term "fork" to talk about the political/project 
> issues.  So for example, even though Ingo Molnar's CONFIG_PREEMPT_RT 
> patchset has been a very long-running thing, it is constantly getting 
> rebased against the kernel, and there is no expectation that this would 
> replace the mainline kernel.  That makes a code branch, and not a fork.

I refuse to get involved in such a sophistic (not to be confused with 
sophisticated) discussion.

I am _only_ interested in the technical side. Philosophical discussions, 
while fun when not taken too seriously, _can_ take all the fun out for me 
when the participants get too religious about their beliefs. So please, 
keep me out of them.

Ciao,
Dscho
