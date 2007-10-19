From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Qgit performance and maintain CVS environment with GIT repository
Date: Fri, 19 Oct 2007 01:50:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710190125230.25221@racer.site>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>  <47159779.6010502@bluelane.com>
  <e5bfff550710170030y7778e96ax146acea7a0e57a67@mail.gmail.com> 
 <200710171800.37345.robin.rosenberg.lists@dewire.com>
 <e5bfff550710171626h733228aw7a251746d2b43c63@mail.gmail.com>
 <4717EF40.6000509@bluelane.com> <Pine.LNX.4.64.0710190054570.25221@racer.site>
 <4717F8CF.9060103@bluelane.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	piet.delaney@gmail.piet.net,
	Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org,
	piet.delaney@gmail.com, Piet Delaney <pdelaney@bluelane.com>
To: Pete/Piet Delaney <pete@bluelane.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 02:50:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iig4l-0003Lj-3Q
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 02:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758560AbXJSAuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 20:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758724AbXJSAuo
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 20:50:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:35217 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757125AbXJSAun (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 20:50:43 -0400
Received: (qmail invoked by alias); 19 Oct 2007 00:50:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 19 Oct 2007 02:50:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/j2NYwdPPjvMt9nmeyDeutlVkIKtDBz2cG7oNrOM
	Lq2uX2GmZxGBUm
X-X-Sender: gene099@racer.site
In-Reply-To: <4717F8CF.9060103@bluelane.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61587>

Hi,

On Thu, 18 Oct 2007, Pete/Piet Delaney wrote:

> I'll try the git-cvsserver path. If anyone has any war stories to share 
> on the path this would be an ideal time to share them.

I was responsible for a medium long running CVS repository, and I wanted 
to switch to git.  For a long time, I just ran tests and tried to flesh 
out things, and eventually went for it.

A few of the patches to git-cvsserver from me were direct results of 
problems we ran to.  But mind you, that was almost over a year ago.

In the meantime, many of my developers switched.  Some because it was 
easier than waiting for me to fix the bugs with the cvs server.

Some because they saw me working with git.

I still do not know why the third group switched.

Now I have exactly one dev left, who refuses to use anything else than 
cvs.  Fine with me.  I can live with other people using inferiour programs 
than myself.

I even patched cvsserver not to print the "committed using git-cvsserver" 
message locally.

But then, I was never a cvs "power" user.  Only a git power user.

Ciao,
Dscho
