From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 15:31:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0607271457250.9789@iabervon.org>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com> 
 <20060727114105.GZ13776@pasky.or.cz>  <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
  <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com> 
 <20060727131127.GA13776@pasky.or.cz> <9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com>
 <Pine.LNX.4.64.0607270936200.4168@g5.osdl.org> <Pine.LNX.4.63.0607271846390.8976@alpha.polcom.net>
 <Pine.LNX.4.64.0607271003270.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Grzegorz Kulewski <kangur@polcom.net>,
	Jon Smirl <jonsmirl@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 21:30:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6BYX-0001Eu-BA
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 21:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWG0T36 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 15:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbWG0T36
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 15:29:58 -0400
Received: from iabervon.org ([66.92.72.58]:24838 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750992AbWG0T35 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 15:29:57 -0400
Received: (qmail 28830 invoked by uid 1000); 27 Jul 2006 15:31:02 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Jul 2006 15:31:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607271003270.4168@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24333>

On Thu, 27 Jul 2006, Linus Torvalds wrote:

> On Thu, 27 Jul 2006, Grzegorz Kulewski wrote:
> > 
> > I think that part of the anwser for question "Why do people use GIT?" is that
> > they trust you and other maintainers that you do a good and stable job. Won't
> > creating several ports/forks/whatever destroy at least part of this?
> 
> Sure. But the point is, the GPLv2 isn't exactly up for discussion. People 
> can complain all they want, but if they want to trust me, they'll take the 
> GPLv2. It's that easy.

I think there'd be a justification for licensing part of git like sparse 
is licensed, for the same reasons. It wouldn't include any of the 
interesting operations, probably, but it would be worth having a canonical 
implementation of reading and writing the data structures, so other 
implementations don't screw that up. I wouldn't like to have someone write 
a version that generated subtly corrupt git objects that it accepts along 
with proper objects, such that we have to work around the breakage. It's a 
bit less likely to happen if there's no licensing reason not to use the 
same code.

	-Daniel
*This .sig left intentionally blank*
