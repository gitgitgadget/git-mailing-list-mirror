From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 3 Aug 2007 19:57:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708031956080.14781@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> 
 <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com> 
 <Pine.LNX.4.64.0708031334530.14781@racer.site>  <46B328EA.4030309@trolltech.com>
  <Pine.LNX.4.64.0708031411360.14781@racer.site>  <46B32C8D.4060804@trolltech.com>
  <Pine.LNX.4.64.0708031434130.14781@racer.site>  <46B34B0D.6030106@trolltech.com>
  <Pine.LNX.4.64.0708031649480.14781@racer.site>  <46B36B7F.8010008@trolltech.com>
 <fd2562310708031133m72b43265n35277c360ef2ca7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: Mike Pape <dotzenlabs@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 20:57:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH2LB-0007MU-JQ
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 20:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbXHCS5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 14:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbXHCS5e
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 14:57:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:47862 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751004AbXHCS5e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 14:57:34 -0400
Received: (qmail invoked by alias); 03 Aug 2007 18:57:32 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 03 Aug 2007 20:57:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18gzOcmK2ggUIUY3oDWcx7FVtSwv83lFzhNl4MGmK
	ahGO/qFWj1+KIa
X-X-Sender: gene099@racer.site
In-Reply-To: <fd2562310708031133m72b43265n35277c360ef2ca7a@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54742>

Hi,

On Fri, 3 Aug 2007, Mike Pape wrote:

> > >> 3) When "Setting up git" the second time, it feels like the whole thing
> > >> is hanging; have let it run for ~5min now without anything happening.
> > >> Not sure what's going on here. It looks like git.exe was ran with any
> > >> options, but that should not consume 100% CPU.. Hmm
> > >
> > > Yep.  I did not test the initial phase, and there is a serious bug in
> > > setup_git_directory_gently() in origin/devel.  I fixed that.
> >
> > Yup, work now.
> 
> Works for me as well now.  One catch is that at work, I'm behind a
> firewall so git:// doesn't work for me.  I have a packaged version
> that adds curl and expat, enables them in the build, and then falls
> back to http:// if git:// fails in /etc/profile.  Is that something
> you'd want up on code.google.com?

Hang on.  Dmitry proposed opening a project on repo.or.cz, but I did not 
think that it made sense.  I am converted now.

I am in the middle of registering it.

Ciao,
Dscho
