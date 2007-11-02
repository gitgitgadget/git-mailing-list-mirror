From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 2 Nov 2007 11:03:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711021102380.4362@racer.site>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
 <7vmytycykt.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org>
 <472AF01F.9030002@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 02 12:04:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InuK6-0005PE-T0
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 12:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbXKBLEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 07:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbXKBLEH
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 07:04:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:41865 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753071AbXKBLEF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 07:04:05 -0400
Received: (qmail invoked by alias); 02 Nov 2007 11:04:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 02 Nov 2007 12:04:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RBPpN6QsRlKVopE52UAIoDIw8x7mCb8Nowog084
	5AL3+c3v1R4h6p
X-X-Sender: gene099@racer.site
In-Reply-To: <472AF01F.9030002@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63103>

Hi,

On Fri, 2 Nov 2007, Andreas Ericsson wrote:

> Linus Torvalds wrote:
> > 
> > On Wed, 31 Oct 2007, Junio C Hamano wrote:
> > > * ph/parseopt (Tue Oct 30 14:15:21 2007 -0500) 23 commits
> > >  + ...
> > > 
> > > It appears 1.5.4 will be, to a certain extent, a "Let's clean up
> > > the internal implementation" release.  This series should become
> > > part of it.  Hopefully will merge to 'master' soon, but I
> > > haven't looked this series very closely yet.
> > 
> > I certainly think this should go in, but it does make one deficiency
> > painfully clear: the remaining shell scripts end up having all the old
> > flags behaviour.
> > 
> > So while you can combine flags for *most* programs, you still won't be able
> > to say things like
> > 
> > 	git clean -qdx
> > 
> > just because that's still a shellscript, and doing any fancy argument
> > parsing in shell is just painful.
> > 
> > Is somebody still working on doing the shell->C conversion?
> > 
> 
> Me, although my git work is happening with the speed of continental drift
> at the moment.
> 
> git-merge and git-pull are (slowly) being converted. It's more in the
> nature of a learning experience for me than "oh shit I need this fast"
> though. Hence the blazing speed with which I work ;-)

If you would share what you have on repo.or.cz, others could help at a 
faster pace, instead of duplicating your work or waiting for you to 
finish.

Ciao,
Dscho
