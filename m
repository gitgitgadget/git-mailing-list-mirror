From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Fri, 3 Aug 2007 05:03:10 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708030454200.14781@racer.site>
References: <46AFCF3E.5010805@alum.mit.edu> 
 <8b65902a0708010438s24d16109k601b52c04cf9c066@mail.gmail.com> 
 <46B1F96B.7050107@alum.mit.edu> <46a038f90708021608o21480074ybcfada767afc7b04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Guilhem Bonnefille <guilhem.bonnefille@gmail.com>,
	git@vger.kernel.org, users@cvs2svn.tigris.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 06:03:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGoO9-0003ol-A0
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 06:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbXHCEDm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 00:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbXHCEDm
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 00:03:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:33569 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751032AbXHCEDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 00:03:41 -0400
Received: (qmail invoked by alias); 03 Aug 2007 04:03:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp005) with SMTP; 03 Aug 2007 06:03:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0zad39ou06ed7BYT02rxDx7Aoui3Fk3gq1rX44d
	LorAJH6yt/aCUW
X-X-Sender: gene099@racer.site
In-Reply-To: <46a038f90708021608o21480074ybcfada767afc7b04@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54666>

Hi,

On Fri, 3 Aug 2007, Martin Langhoff wrote:

> On 8/3/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> > cvsps is not a conversion tool at all, though it is used by other
> > conversion tools to generate the changesets.  It appears (I hope I am
> > not misinterpreting things) to emphasize speed and incremental
> > operation, for example attempting to make changesets consistent from one
> > run to the next, even if the CVS repository has been changed prudently
> > between runs.  cvsps does not appear to attempt to create atomic branch
> > and tag creation commits or handle CVS's special vendorbranch behavior.
> >  cvsps operates via the CVS protocol; you don't need filesystem access
> > to the CVS repository.
> 
> 100% in agreement. And though I can't claim to be happy with cvsps, in
> many scenarios it is mighty useful, in spite of its significant warts.
>  The "does incrementals" is hugely important these days, as lots of
> people use git to run "vendor branches" of upstream projects that use
> CVS.

Me too: 100% agreement.  A couple of people seem to be content to proclaim 
that their incomplete solutions are better, but in the end of the day, 
they are as bad as the programs they purport to replace: incomplete.

For the moment, I help myself with tracking the different branches 
individually, but there, really, git-cvsimport is as good as the other 
"solutions", with the further advantage that they are actually hackable, 
and not closed to everybody outside a very small community.

So I look forward to testing cvs2svn(git-branch) this weekend.

Ciao,
Dscho
