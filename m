From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [PATCH 02/11] Fix declare variable at mid of
 function
Date: Mon, 17 Aug 2009 23:00:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908172258580.8306@pacific.mpi-cbg.de>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com> <1250524872-5148-2-git-send-email-lznuaa@gmail.com> <alpine.DEB.1.00.0908171827040.4991@intel-tinevez-2-302> <7v1vnauto6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 23:00:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md9JS-0000PR-ND
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 23:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758079AbZHQVAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 17:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758074AbZHQVAH
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 17:00:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:55990 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758072AbZHQVAG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 17:00:06 -0400
Received: (qmail invoked by alias); 17 Aug 2009 21:00:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp042) with SMTP; 17 Aug 2009 23:00:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193y2giLXt3oxW+GGKDr3ogEKY+8KtKXTiTYRPrD/
	9GgW1vrNZJWAie
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v1vnauto6.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 17 Aug 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > How about this instead?
> >
> > 	Avoid declaration after instruction
> 
> It's called declaration-after-statement.

Of course.  Thank you.

> I always compile with "-Wall -Wdeclaration-after-statement -Werror" 
> (among other things; if you are interested, see "Make" script in 'todo' 
> branch for details) but this being in compat/mingw.c, obviously it is 
> outside of my coverage.

I have this in my own tree since long ago, back when you sent a mail whose 
reference I did not record, unfortunately.

Of course, msysGit was not there yet to allow me to compile my tree (and 
more importantly, pass the test suite), so I did not realize the 
violations in compat/.

Hence my intention to set the compiler flags just after merging the early 
commits of Frank's work.

Ciao,
Dscho
