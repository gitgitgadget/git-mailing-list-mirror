From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Funny error with git gc...
Date: Fri, 15 May 2009 21:24:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905152122240.26154@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0905152000520.4449@intel-tinevez-2-302> <7vmy9etey8.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0905151128230.3343@localhost.localdomain> <alpine.DEB.1.00.0905152105340.26154@pacific.mpi-cbg.de>
 <alpine.LFD.2.01.0905151212160.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 15 21:24:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M531F-0002j9-AT
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 21:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbZEOTYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 15:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752785AbZEOTYX
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 15:24:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:59124 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752495AbZEOTYW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 15:24:22 -0400
Received: (qmail invoked by alias); 15 May 2009 19:24:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 15 May 2009 21:24:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Sj8E6/cySi4yDab0+VebNppON26+XxdDpx/We6y
	hsfnf8w6K0vixa
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.01.0905151212160.3343@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119286>

Hi,

On Fri, 15 May 2009, Linus Torvalds wrote:

> On Fri, 15 May 2009, Johannes Schindelin wrote:
>
> > Linus said:
> >
> > > Dscho? What are your pack-file statistics in this case?
> > 
> > Mostly around 50kB.
> 
> Can you give us an approximation for how many are under 16kB or so?

None.

Starts at around 20kB, median is 34kB.

> The "proper solution" is likely to not avoid repacking. Scripted stuff 
> that does that is buggy.

Yeah, but maybe there are even more clueless people than me running into 
that situation.

Anyway, off for the weekend,
Dscho
