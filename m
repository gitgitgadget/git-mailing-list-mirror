From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git describe origin ?
Date: Sat, 7 Jul 2007 18:14:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707071812570.4093@racer.site>
References: <38b2ab8a0707070851m25d615bdn4f7286cbadaf1316@mail.gmail.com> 
 <Pine.LNX.4.64.0707071728330.4093@racer.site>
 <38b2ab8a0707070953s33ca0d1aw879fd3d1a986aaeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 19:22:28 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7DzD-0005WV-7o
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 19:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbXGGRWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 13:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbXGGRWK
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 13:22:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:40111 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751724AbXGGRWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 13:22:09 -0400
Received: (qmail invoked by alias); 07 Jul 2007 17:22:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 07 Jul 2007 19:22:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SFIkA6nmSIIGqx0GRmxMJEEnOILYj4itSVnwfxE
	m3EMuBeGaGCvrs
X-X-Sender: gene099@racer.site
In-Reply-To: <38b2ab8a0707070953s33ca0d1aw879fd3d1a986aaeb@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51826>

Hi,

On Sat, 7 Jul 2007, Francis Moreau wrote:

> On 7/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Sat, 7 Jul 2007, Francis Moreau wrote:
> > 
> > > I also played with git remote and did something silly like:
> > > $ git remote add bob /tmp/dummy # dummy does not exist
> > > $ git remote show bob
> > > fatal: '/tmp/dummy': unable to chdir or not a git archive
> > > fatal: The remote end hung up unexpectedly
> > > ls-remote --heads /tmp/dummy: command returned error: 1
> > >
> > > Maybe the output could be improved to be more readable.
> > 
> > The first line is very helpful IMHO:
> > 
> >         fatal: '/tmp/dummy': unable to chdir or not a git archive
> > 
> 
> yep but the 2 others are just noise, aren't they ?

There are actually four programs involved, it seems. You get an error 
message from all except "git remote".

> BTW, shouldn't "git remote add" have complained at first ?

No. Sometimes the URL is not yet available, yet, you want to add it for 
later reference (think bundles). Sometimes you are simply offline.

Ciao,
Dscho
