From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add the diff option --no-defaults
Date: Sat, 18 Apr 2009 23:15:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904182311330.10279@pacific.mpi-cbg.de>
References: <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de> <20090409084903.GA18947@coredump.intra.peff.net> <alpine.DEB.1.00.0904091242430.10279@pacific.mpi-cbg.de> <20090410080155.GB32195@coredump.intra.peff.net>
 <alpine.DEB.1.00.0904140036341.10279@pacific.mpi-cbg.de> <20090416083443.GA27399@coredump.intra.peff.net> <alpine.DEB.1.00.0904161124000.10279@pacific.mpi-cbg.de> <20090416094154.GA30479@coredump.intra.peff.net> <7v4owok0bh.fsf@gitster.siamese.dyndns.org>
 <20090417115414.GA29121@coredump.intra.peff.net> <alpine.DEB.1.00.0904171514440.6675@intel-tinevez-2-302> <alpine.GSO.2.00.0904180930390.16775@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0904181937520.10279@pacific.mpi-cbg.de>
 <alpine.GSO.2.00.0904181308440.16775@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Sat Apr 18 23:13:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvHrD-0002Ji-C3
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 23:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857AbZDRVMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 17:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754622AbZDRVMO
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 17:12:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:48939 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752645AbZDRVMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 17:12:13 -0400
Received: (qmail invoked by alias); 18 Apr 2009 21:12:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 18 Apr 2009 23:12:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1871ZcSRoQ7wQnuyFFC8KFN8Ps1BuHTwOocL+rmy5
	wbXcxKhqPEAUYY
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.GSO.2.00.0904181308440.16775@kiwi.cs.ucla.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116869>

Hi.

On Sat, 18 Apr 2009, Keith Cascio wrote:

> On Sat, 18 Apr 2009, Johannes Schindelin wrote:
> 
> > And I still do not like the intrusiveness of your patch.  The last 
> > time we did something like that with options (some 
> > parseoptifications), we had a lot of fallout as a consequence.
> 
> [...]
>
> Peff expressed some specific concerns [...]

My concerns were also very specific: your patches are way too large.  
There is a rule of thumb that the likelihood of a bug is the square of the 
number of changed lines, I am sure you heard that before.

> [...] your patch adds at least ten lines outside of diff.h/diff.c.

That is _such_ a red herring.

Ciao,
Dscho
