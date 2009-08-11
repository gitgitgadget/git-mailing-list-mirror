From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a foreign
 vcs
Date: Wed, 12 Aug 2009 01:53:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908120128120.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org> <7v1vnk79lt.fsf@alter.siamese.dyndns.org> <36ca99e90908110831g2ad52a5ar4a755723a6682f77@mail.gmail.com> <alpine.DEB.1.00.0908111817490.4638@intel-tinevez-2-302>
 <20090811214849.GA3868@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 01:53:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb19W-0001Ye-Mu
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 01:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892AbZHKXxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 19:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754831AbZHKXxD
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 19:53:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:35744 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754383AbZHKXxC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 19:53:02 -0400
Received: (qmail invoked by alias); 11 Aug 2009 23:53:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 12 Aug 2009 01:53:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18MMkVWVUYM8l2xXebjDd/yBP5bOvHDvhluwsNzAH
	N0UtVRsYD4HrzO
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090811214849.GA3868@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125624>

Hi,

On Tue, 11 Aug 2009, Jeff King wrote:

> On Tue, Aug 11, 2009 at 06:20:54PM +0200, Johannes Schindelin wrote:
> 
> > >        o   [user@]host.xz:/path/to/repo.git/
> > 
> > That is a valid concern.  I'd suggest to disallow @ and . in the protocol 
> > name (maybe even everything non-alnum).  For shortcuts that really read 
> > like "svn", I think it is not too much asked for to require adjusting the 
> > URL (by prefixing ssh:// and adjusting the path).
> > 
> > If there is really anybody who uses Git via ssh to access a server called 
> > "svn", we could just as well have a little fun with them, don't you agree?
> 
> It is not actually that unreasonable. I have remotes which point to:
> 
>   vcs:git/foo.git

That is still not "svn".

> where "vcs" is a shorthand for vcs.gtisc.gatech.edu, defined in my 
> .ssh/config (it's a machine which hosts several different version 
> control systems). So I could see somebody having something like "svn" if 
> they were, e.g., hosting a git-to-svn conversion on their company's svn 
> server.

If _I_ were to judge whether to make it convenient for computer-savvy 
people like you who would have _no_ problem diagnosing the problem (_if_ 
they have the problem, having edited .ssh/config themselves!), who would 
curse briefly, and then go on fixing the problem, or in the alternative 
make it convenient for people who do not know their way around .ssh/config 
as well as you (and who happen to make up the _vast_ majority of Git users 
by now [*1*]), and who would really prefer to have an easy way to clone 
"foreign" repositories, I have _no_ problem deciding which way to go.

So I'm a bastard.  Big news.  But I'm a pragmatic one.

Ciao,
Dscho

Footnote [*1*]: Maybe I was helping to increase the number of Git users 
who do not know .ssh/config with my work on Git for Windows, but that was 
not my original intention.  Maybe I should start to feel better about 
it...
