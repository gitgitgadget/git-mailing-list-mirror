From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT on MinGW problem
Date: Sat, 26 May 2007 23:17:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705262311380.4648@racer.site>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
 <4656A304.AF39A0B6@eudaptics.com> <Pine.LNX.4.64.0705251113280.4648@racer.site>
 <46588DA4.5020109@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Sun May 27 00:17:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs4a6-0002o3-HD
	for gcvg-git@gmane.org; Sun, 27 May 2007 00:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbXEZWRm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 18:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbXEZWRm
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 18:17:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:53522 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750718AbXEZWRl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 18:17:41 -0400
Received: (qmail invoked by alias); 26 May 2007 22:17:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 27 May 2007 00:17:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/r4SQ1/jfr8Ug+k47LuOK9eSgTrxPUTps3CqxNdk
	GDXmzLHU1xrySN
X-X-Sender: gene099@racer.site
In-Reply-To: <46588DA4.5020109@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48496>

Hi,

[before answering: a big thank you, Han-Wen, for doing that work. I think 
it is very valuable, especially because except Johannes Sixt, I have yet 
to encounter a person wanting "naive" Windows Git, but not hiding under 
the next rock when it comes to work on it.]

On Sat, 26 May 2007, Han-Wen Nienhuys wrote:

> Johannes Schindelin escreveu:
> > 
> > On Fri, 25 May 2007, Johannes Sixt wrote:
> > 
> >> * I personally think that the files should go into
> >>
> >> 	$PROGRAMFILES/Git/{bin,share,lib}
> >> instead of
> >> 	$PROGRAMFILES/Git/usr/{bin,share,lib}
> > 
> > Agree. It is trivial, but it will help others. It might also be a good 
> > idea to have a shortcut in "$PF/Git/Git Gui.lnk" to the git gui (once it 
> > is working, that is).
> > 
> >> * git-gui and gitk don't work out of the box because they have the path
> >> to wish hardcoded. They can't be started from CMD at all. I have written
> >> wrappers gitk.cmd and git-gui.cmd with these 2 lines:
> >>
> >> @echo off
> >> start wish84 D:/MSYS/1.0/git/bin/gitk %*
> >>
> >> But as you can see, the path is still hard-coded (but it is good enough
> >> for me for the moment).
> > 
> > I'd also like to see bash, perl and wish bundled with the install (Windows 
> 
> Where is the info on the wish and bash port to Mingw?

I recently compiled tcl and tk from scratch on MinGW. (No cross-compile.) 
Worked out of the box:

	http://prdownloads.sourceforge.net/tcl/tcl8.4.14-src.tar.gz
	http://prdownloads.sourceforge.net/tcl/tk8.4.14-src.tar.gz

(Now, if only Python worked like that...)

There's a bash src in the Snapshot package of MinGW:

	http://prdownloads.sf.net/mingw/bash-2.05b-MSYS-src.tar.bz2?download

Ciao,
Dscoh
