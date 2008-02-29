From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Summer of Code 2008
Date: Fri, 29 Feb 2008 13:03:15 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802291302560.22527@racer.site>
References: <200802262356.28971.jnareb@gmail.com> <20080228063621.GR8410@spearce.org> <alpine.LSU.1.00.0802281021070.22527@racer.site> <200802291304.16026.jnareb@gmail.com> <Pine.LNX.4.64.0802291241400.18516@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org, John Hawley <warthog9@kernel.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Feb 29 14:04:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV4ua-0002dG-Mm
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 14:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460AbYB2NDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 08:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754529AbYB2NDw
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 08:03:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:37638 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751633AbYB2NDw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 08:03:52 -0500
Received: (qmail invoked by alias); 29 Feb 2008 13:03:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 29 Feb 2008 14:03:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19JyAZ8jbpJnC9NQeMlDQ2puipbgO5F4fFHUsMGWe
	zFDvwysire/1VE
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0802291241400.18516@reaper.quantumfyre.co.uk>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75532>

Hi,

On Fri, 29 Feb 2008, Julian Phillips wrote:

> On Fri, 29 Feb 2008, Jakub Narebski wrote:
> 
> > * Git / Subversion Interoperability
> > 
> >  The idea here is implement something in Git that speaks the Subversion
> >  protocol on the wire, but uses Git as the backend storage. (This would
> >  be like the existing git-cvsserver.)
> > 
> >  There are two potential approaches:
> > 
> >   1. git-svnserver
> >   2. write a backend for Subversion
> > 
> >  Goal: To be able to access git repository, at minimum read-only, from
> >  a Subversion client, at least svn CLI.
> >  Language: Open for proposal.
> >  Suggested mentors:
> >    Eric Wong (git-svn author)
> >    Matthias Urlichs (git-svnimport author)
> >  Notes: I don't think we could pass it as Subversion SoC project, but
> >  I guess that we could ask for co-mentor for the Subversion protocol,
> >  or Subversion backend part of this task.
> 
> FWIW: I have a partially implemented python git-svnserver that speaks the
> svn:// protocol ... so far I can checkout from a git repos using the svn
> client, and not much else.  It's been on the backburner for a while, but I had
> recently thought about revisiting it - but getting someone else to do the
> implementation works too ;)

How about publishing it, so other people can take up the ball?

Ciao,
Dscho

