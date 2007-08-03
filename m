From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 3 Aug 2007 19:55:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708031954480.14781@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>
 <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
 <Pine.LNX.4.64.0708031334530.14781@racer.site> <46B328EA.4030309@trolltech.com>
 <Pine.LNX.4.64.0708031411360.14781@racer.site> <46B32C8D.4060804@trolltech.com>
 <Pine.LNX.4.64.0708031434130.14781@racer.site> <46B34B0D.6030106@trolltech.com>
 <Pine.LNX.4.64.0708031649480.14781@racer.site> <46B36B7F.8010008@trolltech.com>
 <fd2562310708031133m72b43265n35277c360ef2ca7a@mail.gmail.com>
 <46B3764E.6090106@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Pape <dotzenlabs@gmail.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 20:55:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH2JL-0006hA-K9
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 20:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320AbXHCSzi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 14:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752973AbXHCSzi
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 14:55:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:57639 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752172AbXHCSzh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 14:55:37 -0400
Received: (qmail invoked by alias); 03 Aug 2007 18:55:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 03 Aug 2007 20:55:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18mFzFJJ+YmF2reqAbi6X1WNlPIVblnU8Ou+oy/wX
	qwyhuOWqboveOL
X-X-Sender: gene099@racer.site
In-Reply-To: <46B3764E.6090106@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54741>

Hi,

On Fri, 3 Aug 2007, Marius Storm-Olsen wrote:

> Mike Pape wrote:
> >>>> 3) When "Setting up git" the second time, it feels like the whole thing
> >>>> is hanging; have let it run for ~5min now without anything happening.
> >>>> Not sure what's going on here. It looks like git.exe was ran with any
> >>>> options, but that should not consume 100% CPU.. Hmm
> >>> Yep.  I did not test the initial phase, and there is a serious bug in
> >>> setup_git_directory_gently() in origin/devel.  I fixed that.
> >> Yup, work now.
> > 
> > Works for me as well now.  One catch is that at work, I'm behind a
> > firewall so git:// doesn't work for me.  I have a packaged version
> > that adds curl and expat, enables them in the build, and then falls
> > back to http:// if git:// fails in /etc/profile.  Is that something
> > you'd want up on code.google.com?
> 
> Ooo, I'd like your built curl and expat libs in a zip, pretty please! :-)
> 
> Then we can add it to the package. The more complete MinGW port, the
> better. Do you have anywhere you can put out such a zip, so I can get
> ahold of it? You can mail me privately, if you'd like.

I already installed curl, didn't I?

Ciao,
Dscho
