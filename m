From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvstrack: work on imported cvs and other git branches
Date: Sun, 1 Jul 2007 17:11:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707011710480.4438@racer.site>
References: <11832957963860-git-send-email-prohaska@zib.de>
 <Pine.LNX.4.64.0707011533370.4438@racer.site> <4880FDC4-BAD5-49B4-871B-98259D691449@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jul 01 18:11:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5211-0002lI-9U
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 18:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbXGAQLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 12:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbXGAQLI
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 12:11:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:42917 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753614AbXGAQLH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 12:11:07 -0400
Received: (qmail invoked by alias); 01 Jul 2007 16:11:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 01 Jul 2007 18:11:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LGe8ijA+LWVXtPMUjDpXl5L8AiDc8VeQgXWbpzr
	Hthu2hfEdzwIMg
X-X-Sender: gene099@racer.site
In-Reply-To: <4880FDC4-BAD5-49B4-871B-98259D691449@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51307>

Hi,

On Sun, 1 Jul 2007, Steffen Prohaska wrote:

> On Jul 1, 2007, at 4:35 PM, Johannes Schindelin wrote:
> 
> > On Sun, 1 Jul 2007, Steffen Prohaska wrote:
> > 
> > > The idea is to import a cvs repository using git cvsimport; build a 
> > > perfect history in git by cherry picking commits that are only in 
> > > cvs but not in git; and export only summaries back to cvs. Cvs 
> > > imports are organized on a separate git branch. git is used for 
> > > merging. The differences can be sent back to cvs as a squashed 
> > > commit together with a shortlog. Sent git commits are noted in the 
> > > cvs commit message and will be ignored in subsequent cvs imports.
> > 
> > Wouldn't it be more intuitive to add a --squash option to 
> > git-cvsexportcommit?
> 
> Maybe.
> 
> But how to handle commits that are sent to cvs and come back
> through git-cvsimport?

Probably I do not really understand what you are doing... If the commits 
come from cvs, then they are already there, no? So where do you want to 
commit the squashed commits?

Ciao,
Dscho
