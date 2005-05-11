From: Nicolas Pitre <nico@cam.org>
Subject: Re: Core and Not-So Core
Date: Tue, 10 May 2005 22:30:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505102226020.5426@localhost.localdomain>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
 <20050510225235.GD26384@pasky.ji.cz>
 <2cfc403205051017505b57da72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed May 11 04:23:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVgst-0002tb-2f
	for gcvg-git@gmane.org; Wed, 11 May 2005 04:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVEKCas (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 22:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVEKCas
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 22:30:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41569 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261742AbVEKCam
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 22:30:42 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR010.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGB001OG0ALJH@VL-MO-MR010.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 10 May 2005 22:30:23 -0400 (EDT)
In-reply-to: <2cfc403205051017505b57da72@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Jon Seymour <jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 11 May 2005, Jon Seymour wrote:

> On 5/11/05, Petr Baudis <pasky@ucw.cz> wrote:
> > So unlike the objects database which has well-defined format and is
> > supposed to be "public", you should view the directory cache as internal
> > git tools' structure. If you want to mess with it too, either use the
> > proper level of abstraction and call the git tools, or don't mess with
> > it at all. And you need to care about it only if you want the git tools
> > working on the same tree properly too - so in that case use the git
> > tools too.
> 
> I agree in principle, though I'd like users to be able to easily
> switch between the Eclipse and git tools view of the workspace if they
> want to - who am I to say how a user should work? Eclipse does this
> kind of thing quite well with CVS precisely because it shares the
> workspace structures with the CVS command line tools rather than
> "re-inventing" the wheel.

In this case you just need to manage to use the current index format 
somehow.  

Honestly I don't think Linus might be interested into changing the index 
format just to make a Java implementation happier.  So your best bet is 
probably to use it as is or ignore it entirely.


Nicolas
