From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 02/40] Compile some programs only conditionally.
Date: Fri, 29 Feb 2008 21:53:51 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802292153210.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <200802282130.10225.johannes.sixt@telecom.at> <alpine.LSU.1.00.0802290046180.22527@racer.site> <200802292158.12398.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Feb 29 22:55:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVDCB-0002m6-Qg
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 22:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934259AbYB2Vyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 16:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761550AbYB2Vyc
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 16:54:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:49790 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761503AbYB2Vyb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 16:54:31 -0500
Received: (qmail invoked by alias); 29 Feb 2008 21:54:28 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp047) with SMTP; 29 Feb 2008 22:54:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/cyeBIA7HcsQ2L4dwIco08DcLINC8f/K07j1/Spn
	c/rf+Qga1+jkc6
X-X-Sender: gene099@racer.site
In-Reply-To: <200802292158.12398.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75572>

Hi,

On Fri, 29 Feb 2008, Johannes Sixt wrote:

> On Friday 29 February 2008 01:47, Johannes Schindelin wrote:
> > On Thu, 28 Feb 2008, Johannes Sixt wrote:
> > > openlog() etc. is only one problem in git-daemon. It also depends on
> > > SIGCHLD, a non-blocking waitpid, and a lot more. The patch that is in
> > > 4msysgit.git allows only a single connection, IIRC, after which it
> > > terminates. But I also think that git-daemon can be made more complete
> > > on Windows, but it certainly requires a major surgery.
> >
> > Okay, I did not look closely enough.  But even a single-connection daemon
> > is better than no daemon, no?
> 
> In principle, yes. But:
> 
> - git-fetch needs two connections if there are new tags in the source repo.
> 
> - The daemon patches in 4msysgit.git could be prettier, they certainly would 
> not pass your scrutiny.

Right.

> git-daemon is not my itch at this time, so I won't scratch it.

Right.  I will mail the correct person.

Ciao,
Dscho

