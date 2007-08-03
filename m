From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 3 Aug 2007 20:33:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708032027250.14781@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> 
 <46B32C8D.4060804@trolltech.com>  <Pine.LNX.4.64.0708031434130.14781@racer.site>
  <46B34B0D.6030106@trolltech.com>  <Pine.LNX.4.64.0708031649480.14781@racer.site>
  <46B36B7F.8010008@trolltech.com>  <fd2562310708031133m72b43265n35277c360ef2ca7a@mail.gmail.com>
  <46B3764E.6090106@trolltech.com>  <Pine.LNX.4.64.0708031954480.14781@racer.site>
  <46B37B09.1030808@trolltech.com> <fd2562310708031213sabc4599m79166f52e78edde3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: Mike Pape <dotzenlabs@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 21:34:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH2uR-000263-1o
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 21:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbXHCTdu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 15:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbXHCTdu
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 15:33:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:46313 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750988AbXHCTdt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 15:33:49 -0400
Received: (qmail invoked by alias); 03 Aug 2007 19:33:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 03 Aug 2007 21:33:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19mxDVk9q1m/O51FfyxbS+KNew3gJC6lIYQk4eT9T
	CrGOjbRmKbJbwW
X-X-Sender: gene099@racer.site
In-Reply-To: <fd2562310708031213sabc4599m79166f52e78edde3@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54748>

Hi,

On Fri, 3 Aug 2007, Mike Pape wrote:

> On 8/3/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> > Johannes Schindelin wrote:
> > > On Fri, 3 Aug 2007, Marius Storm-Olsen wrote:
> > >> Mike Pape wrote:
> > >>> Works for me as well now.  One catch is that at work, I'm behind
> > >>> a firewall so git:// doesn't work for me.  I have a packaged
> > >>> version that adds curl and expat, enables them in the build, and
> > >>> then falls back to http:// if git:// fails in /etc/profile.  Is
> > >>> that something you'd want up on code.google.com?
> > >> Ooo, I'd like your built curl and expat libs in a zip, pretty
> > >> please! :-)
> > >>
> > >> Then we can add it to the package. The more complete MinGW port,
> > >> the better. Do you have anywhere you can put out such a zip, so I
> > >> can get ahold of it? You can mail me privately, if you'd like.
> > >
> > > I already installed curl, didn't I?
> >
> > Ah, yes, you did.
> > However, we don't use it, due to Makefile's
> >         NO_CURL=YesPlease
> > for MINGW builds.
> >
> 
> Was it in the latest version (0.2)?  I didn't see it there.  Either
> way, I had to make a couple changes to the Makefile to get it to work
> and also add expat (unless I somehow missed that too).  Marius, do you
> still want a zipped copy or do you have it already?

Okay, I am really close to initialising the repository on

	http://repo.or.cz/w/git/mingw/msysgit.git

now.

Everybody interested in contributing, please register as a user on 
repo.or.cz and mail me your user name.

Ciao,
Dscho
