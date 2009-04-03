From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] NO_PERL support
Date: Fri, 3 Apr 2009 17:02:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904031701430.10279@pacific.mpi-cbg.de>
References: <20090403T065545Z@curie.orbis-terrarum.net> <20090403132029.GC21153@coredump.intra.peff.net> <alpine.DEB.1.00.0904031649400.10279@pacific.mpi-cbg.de> <20090403145329.GA25967@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 03 17:03:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpkvH-0004Kn-Bx
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 17:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933547AbZDCO74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 10:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933598AbZDCO7z
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 10:59:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:38264 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934735AbZDCO7y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 10:59:54 -0400
Received: (qmail invoked by alias); 03 Apr 2009 14:59:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 03 Apr 2009 16:59:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19yEPdesohyZIonZY5eriKZBNCek3q44VqOJx0/PK
	tCvy1JmnW+6jVz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090403145329.GA25967@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115535>

Hi,

On Fri, 3 Apr 2009, Jeff King wrote:

> On Fri, Apr 03, 2009 at 04:51:09PM +0200, Johannes Schindelin wrote:
> 
> > > Hmm. With this patch, a user with a NO_PERL build will just get:
> > > 
> > >   $ git svn
> > >   git: 'svn' is not a git-command. See 'git --help'.
> > >   $ git add -i
> > >   error: unknown switch `i'
> > >   usage: ...
> > > 
> > > I wonder if we should be a little nicer and say "we know about this
> > > command or option, but we did not build support for it". OTOH, what you
> > > have mirrors what NO_TCLTK does, so perhaps it is not a big deal.
> > 
> > Actually, "add -i" is a part of another program that does work without 
> > Perl, so it is quite a different kind of kettle.
> > 
> > It is not like "git gui" works with NO_TCLTK but "git gui -i" does not.
> 
> Yes, there are really two cases here:
> 
>   1. options to programs that will be disabled
> 
>   2. whole programs that will not be installed
> 
> Are you proposing to print "sorry, perl support not compiled in" (or
> whatever) for case 1, but ignore case 2? (And I am not sure if that is a
> bad idea, but I am trying to be clear on what you mean).

1) as it is all too easy, but not 2) as that would require too much work, 
which would be overkill.

Just my 1ct,
Dscho
