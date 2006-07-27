From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 22:41:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607272240190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com> 
 <20060727114105.GZ13776@pasky.or.cz>  <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
  <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com> 
 <20060727131127.GA13776@pasky.or.cz> <9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com>
 <Pine.LNX.4.64.0607270936200.4168@g5.osdl.org> <Pine.LNX.4.63.0607271846390.8976@alpha.polcom.net>
 <Pine.LNX.4.64.0607271003270.4168@g5.osdl.org> <Pine.LNX.4.64.0607271457250.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Grzegorz Kulewski <kangur@polcom.net>,
	Jon Smirl <jonsmirl@gmail.com>, Petr Baudis <pasky@suse.cz>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 22:41:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Cfr-0002yY-KO
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 22:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWG0Uli (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 16:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWG0Ulh
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 16:41:37 -0400
Received: from mail.gmx.de ([213.165.64.21]:63385 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750783AbWG0Ulh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 16:41:37 -0400
Received: (qmail invoked by alias); 27 Jul 2006 20:41:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 27 Jul 2006 22:41:35 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0607271457250.9789@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24341>

Hi,

On Thu, 27 Jul 2006, Daniel Barkalow wrote:

> On Thu, 27 Jul 2006, Linus Torvalds wrote:
> 
> > On Thu, 27 Jul 2006, Grzegorz Kulewski wrote:
> > > 
> > > I think that part of the anwser for question "Why do people use GIT?" is that
> > > they trust you and other maintainers that you do a good and stable job. Won't
> > > creating several ports/forks/whatever destroy at least part of this?
> > 
> > Sure. But the point is, the GPLv2 isn't exactly up for discussion. People 
> > can complain all they want, but if they want to trust me, they'll take the 
> > GPLv2. It's that easy.
> 
> I think there'd be a justification for licensing part of git like sparse 
> is licensed, for the same reasons. It wouldn't include any of the 
> interesting operations, probably, but it would be worth having a canonical 
> implementation of reading and writing the data structures, so other 
> implementations don't screw that up.

You could probably even get away just copying these I/O operations, 
because there is obviously no other way to do it. Ergo, no enforcable 
copyright on those code sections.

Ciao,
Dscho
