From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to stop sharing objects between repositories
Date: Sun, 16 Aug 2009 14:30:15 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908161429590.8306@pacific.mpi-cbg.de>
References: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg> <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de> <20090816122842.GA942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Jensen <jon@endpoint.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 16 14:29:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mceri-00032n-3I
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 14:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbZHPM3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 08:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbZHPM3a
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 08:29:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:54589 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751015AbZHPM33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 08:29:29 -0400
Received: (qmail invoked by alias); 16 Aug 2009 12:29:29 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 16 Aug 2009 14:29:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+35cEXDJ+lz0wG5fAxJ864+GQnh5ub0JrN/a2cp
	CmWnVUwXnrGskT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090816122842.GA942@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126057>

Hi,

On Sun, 16 Aug 2009, Jeff King wrote:

> On Sun, Aug 16, 2009 at 10:43:11AM +0200, Johannes Schindelin wrote:
> 
> > > If there's a better or built-in way to do this with Git tools, I'd like 
> > > to learn it, and I'd be happy to update the wiki accordingly.
> > 
> > I think what you need is done by
> > 
> > 	git repack -l
> > 
> > (I agree it is not well documented, and I'd welcome a documentation 
> > patch.)
> 
> I think it is the opposite; packing _without_ "-l" will create a pack
> with objects from the alternate; using "-l" suppresses them. Running
> "git repack -a" should do the trick, I believe (and you need the "-a" to
> ensure that objects already packed in the repo are re-packed).

Hmm.  I really would like a documentation patch, then.

Ciao,
Dscho
