From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add help.autocorrect to enable/disable autocorrecting
Date: Wed, 23 Jul 2008 20:04:40 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807232003420.8986@racer>
References: <alpine.DEB.1.00.0807222100150.8986@racer> <20080722203730.GC5113@blimp.local> <20080722210354.GD5113@blimp.local> <alpine.DEB.1.00.0807222207110.8986@racer> <20080722212633.GF5113@blimp.local> <alpine.DEB.1.00.0807222242160.8986@racer>
 <20080722222510.GA4474@blimp.local> <alpine.DEB.1.00.0807231743030.8986@racer> <20080723184443.GD5283@blimp.local> <alpine.DEB.1.00.0807231958210.8986@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:05:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLjem-00073k-Lq
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbYGWTEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbYGWTEk
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:04:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:54505 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753772AbYGWTEj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:04:39 -0400
Received: (qmail invoked by alias); 23 Jul 2008 19:04:38 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp027) with SMTP; 23 Jul 2008 21:04:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RziAh3ZsRUjd9QDxfr00fqoKLfNdN4/Y0SiXJqQ
	iTgU+cnSmSqSBu
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0807231958210.8986@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89742>

Hi,

On Wed, 23 Jul 2008, Johannes Schindelin wrote:

> On Wed, 23 Jul 2008, Alex Riesen wrote:
> 
> > Johannes Schindelin, Wed, Jul 23, 2008 18:44:49 +0200:
> > > > +	n = 1;
> > > > +	while (n < main_cmds.cnt &&
> > > > +		best_similarity == similarity(main_cmds.names[n]->name))
> > > > +		++n;
> > > 
> > > Mini-nit: you never ask for the value of n, only if it is 1 or larger.  So 
> > > you do not need to count...
> > 
> > But I do, don't I? AFAICS, I use 0, 1 and >1 (this-these).
> 
> Yes.  So check cnt > 0 && best_similarity > 5 says if it is 0,

Oh, I just realized that my patch is bogus anyway.  It only checks for 
best_similarity > 5 in the case that the first two commands have equal 
similarity.  D'oh.

Ciao,
Dscho
