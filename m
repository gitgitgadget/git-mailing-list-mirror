From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT on MinGW problem
Date: Fri, 25 May 2007 11:20:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705251113280.4648@racer.site>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
 <4656A304.AF39A0B6@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri May 25 12:21:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrWv6-0006AU-An
	for gcvg-git@gmane.org; Fri, 25 May 2007 12:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761021AbXEYKUt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 06:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761012AbXEYKUt
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 06:20:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:34124 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760877AbXEYKUs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 06:20:48 -0400
Received: (qmail invoked by alias); 25 May 2007 10:20:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp013) with SMTP; 25 May 2007 12:20:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Xl3Bp9SBXJxV5n5XtAieEDlBeOX+BzIwQ/g6uRj
	zm1z0qKB8M3tNg
X-X-Sender: gene099@racer.site
In-Reply-To: <4656A304.AF39A0B6@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48354>

Hi,

On Fri, 25 May 2007, Johannes Sixt wrote:

> * I personally think that the files should go into
> 
> 	$PROGRAMFILES/Git/{bin,share,lib}
> instead of
> 	$PROGRAMFILES/Git/usr/{bin,share,lib}

Agree. It is trivial, but it will help others. It might also be a good 
idea to have a shortcut in "$PF/Git/Git Gui.lnk" to the git gui (once it 
is working, that is).

> * git-gui and gitk don't work out of the box because they have the path
> to wish hardcoded. They can't be started from CMD at all. I have written
> wrappers gitk.cmd and git-gui.cmd with these 2 lines:
> 
> @echo off
> start wish84 D:/MSYS/1.0/git/bin/gitk %*
> 
> But as you can see, the path is still hard-coded (but it is good enough
> for me for the moment).

I'd also like to see bash, perl and wish bundled with the install (Windows 
lusers are so used to one big install package, so it is an _advantage_ to 
have a bigger download).

> * perl scripts like git-remote contain a hard-coded path to the
> installation directory and don't work for this reason.

GITPERLLIB should be set from the wrapper script, I think.

Ciao,
Dscho
