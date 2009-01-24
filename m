From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to force a commit date matching info from a mbox ?
Date: Sat, 24 Jan 2009 01:34:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901240133510.3586@pacific.mpi-cbg.de>
References: <7vwscm1nic.fsf@gitster.siamese.dyndns.org> <7vljt26fp9.fsf@gitster.siamese.dyndns.org> <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com> <20090123094529.6117@nanako3.lavabit.com> <20090123172646.6117@nanako3.lavabit.com>
 <7vtz7qxsxc.fsf@gitster.siamese.dyndns.org> <20090123222906.GC11328@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	git list <git@vger.kernel.org>,
	Christian MICHON <christian.michon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 24 01:35:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQWV8-0008Gn-QS
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 01:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbZAXAeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 19:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbZAXAeb
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 19:34:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:46440 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753166AbZAXAea (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 19:34:30 -0500
Received: (qmail invoked by alias); 24 Jan 2009 00:34:29 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp018) with SMTP; 24 Jan 2009 01:34:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TYsVDuOzT3gHVIcxzLeln/JYDPAhSLfLPVgssYA
	vN8bjx0VtfiR3q
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090123222906.GC11328@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106935>

Hi,

On Fri, 23 Jan 2009, Jeff King wrote:

> On Fri, Jan 23, 2009 at 01:39:27AM -0800, Junio C Hamano wrote:
> 
> > > --->8---
> > > Subject: [PATCH] git-am: Add --ignore-date option
> > 
> > Good.
> > 
> > Leaving "Subject: " in saves me typing, because I do not have to insert it
> > manually when editing the submitted patch in my MUA to chop off everything
> > before the scissors.
> 
> Interesting to know. I have intentionally _not_ been including them,
> because I assumed you marked up _after_ git-am (i.e., via "git commit
> --amend) in which case you would have to delete it manually. I suppose
> it makes more sense to do so before git-am, though, since then it will
> respect From: fields and the like (which it would otherwise ignore,
> since they are blocked by all of the cover letter cruft that you will
> end up deleting).
> 
> So good to know, and I will start generating my patches differently.

Note that your patches will not be found using Pasky's "mail" link in 
gitweb, if you do not put the commit subject into the _real_ mail subject.

Dunno if I like that.

Ciao,
Dscho
