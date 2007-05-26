From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT on MinGW problem
Date: Sat, 26 May 2007 23:45:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705262343390.4648@racer.site>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
 <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org>
 <Pine.LNX.4.64.0705262318190.4648@racer.site> <7v4plzi508.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 27 00:46:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs51K-0007Mm-MO
	for gcvg-git@gmane.org; Sun, 27 May 2007 00:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbXEZWpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 18:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbXEZWpv
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 18:45:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:52708 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750836AbXEZWpu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 18:45:50 -0400
Received: (qmail invoked by alias); 26 May 2007 22:45:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 27 May 2007 00:45:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//joVudoH/LruB/Jyx0Hzz9ZaMUXhoyJd7WvakkC
	KS161FUOAT1pfT
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4plzi508.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48500>

Hi,

On Sat, 26 May 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> In this, part of the pain is that Git tries to guess the version number
> >> by itself in a complicated way.
> >
> > Yes, I never understood that myself why it has to be so complicated. But 
> > then, it did not make _my_ life hard, so I did not care.
> 
> "echo "MyVersionNumber" >version && make"?

Good to know!

> > OTOH, it _is_ a nice thing to protohype the new commands as shell or perl 
> > scripts. When they stabilize enough, convert them to builtins.
> 
> Protohype is a nice word.  Throw out a half-working stuff and
> advertise it as the best thing since sliced bread even before it
> starts to being useful ;-)

It started out as a typo. But then I liked it so much that I kept it ;-)

> > With add--interactive, I think it's better to leave it [...]
> 
> I do not follow you here.

You mentioned several times that you were unsure if add--interactive was a 
good idea. But I like it very much.

> 
> > But remote will soon be the center of my crosshairs.
> 
> I am afraid that it might be a bit premature.
> 
> I've been hoping that we can make git-clone a thin wrapper
> around init/remote/fetch/checkout.  For one thing, we would want
> to split the separate-remotes layout and bareness to create
> "mirror" (I called it "pure" previously, but this is really a
> mirror) layout for git-clone, among other things, and that kind
> of enhancements would need to be done inside git-remote.

Fair enough.

Ciao,
Dscho
