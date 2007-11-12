From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
 repositories?
Date: Mon, 12 Nov 2007 17:54:23 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711121751100.4362@racer.site>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br>
 <Pine.LNX.4.64.0711121355380.4362@racer.site> <200711121719.54146.wielemak@science.uva.nl>
 <Pine.LNX.4.64.0711121624330.4362@racer.site> <vpq3avbv2ju.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0711121715090.4362@racer.site> <alpine.LFD.0.9999.0711121231150.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:54:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrdUt-0001XI-4Y
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 18:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbXKLRyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 12:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbXKLRyj
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 12:54:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:36643 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752184AbXKLRyi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 12:54:38 -0500
Received: (qmail invoked by alias); 12 Nov 2007 17:54:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 12 Nov 2007 18:54:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ntktS6+cngtE6YcY4OcQvv8iFYcVDLLuvdMLK8y
	+RLewawLNpUTCz
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.9999.0711121231150.21255@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64676>

Hi,

On Mon, 12 Nov 2007, Nicolas Pitre wrote:

> On Mon, 12 Nov 2007, Johannes Schindelin wrote:
> 
> > On Mon, 12 Nov 2007, Matthieu Moy wrote:
> > 
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > 
> > > > On Mon, 12 Nov 2007, Jan Wielemaker wrote:
> > > >
> > > >> I found out that cloning a empty bare repository produces nothing 
> > > >> at all, [...]
> > > >
> > > > If they are empty, what exactly do you mean to clone?
> > > 
> > > I'd expect an empty repository, with the git remote configured 
> > > correctly.
> > 
> > Yeah, right.
> > 
> > Last time I checked, those geneticists did not clone thin air.  They 
> > always waited until they had something to clone.
> 
> But we're not geneticists, and I think the above usage should "just work 
> (tm)".

I am still convinced that it is not very intelligent to start your 
development from a non-existing branch.

But since you're one of the people knowing git _internals_ pretty well, 
here's another reason just for you why this cannot be done: There is no 
way to find out where the HEAD points to.

Try it.  Create an empty repository.  Then call "git ls-remote <path>" on 
it.  It's _empty_.

Ciao,
Dscho "who is bored with this discussion"
