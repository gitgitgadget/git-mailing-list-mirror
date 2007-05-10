From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: Merging commits together into a super-commit
Date: Thu, 10 May 2007 13:43:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705101342060.4167@racer.site>
References: <000e01c792f5$0861abd0$0b0aa8c0@abf.local>
 <1178796748.5806.102.camel@murta.transitives.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Raimund Bauer <ray@softwarelandschaft.com>, git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Thu May 10 13:44:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm74e-0004pf-OY
	for gcvg-git@gmane.org; Thu, 10 May 2007 13:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761473AbXEJLnt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 07:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761758AbXEJLnt
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 07:43:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:58376 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761738AbXEJLns (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 07:43:48 -0400
Received: (qmail invoked by alias); 10 May 2007 11:43:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 10 May 2007 13:43:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18QDeNlebkQNYE7I3x8Yyb8yZu3nuSx7frm64FrNV
	Tr93AXt2iM26+n
X-X-Sender: gene099@racer.site
In-Reply-To: <1178796748.5806.102.camel@murta.transitives.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46860>

Hi,

On Thu, 10 May 2007, Alex Bennee wrote:

> On Thu, 2007-05-10 at 13:19 +0200, Raimund Bauer wrote:
> > > Hi,
> >  <snip> 
> > You don't want to be 
> > > correcting a whole bunch of merge failures for every commit 
> > > in your current tree.
> > > 
> > > So far the only was I can see to do this is a:
> > > 
> > > git-diff master..HEAD > my.patch
> > > 
> > > And then re-applying your patch in stages, manually doing the commits.
> > > 
> > > Am I missing something?
> > 
> > git merge --squash ?
> 
> Hmm, that would do although it only works on whole trees, you can't
> specify a range of commits. So you would have to cherrypick groups of
> changes onto other branches and then merge them together with a couple
> of --squashes

Since specifying several commit ranges can always lead to merge conflicts, 
it makes no sense to _not_ accumulate the patches in a separate branch.

Ciao,
Dscho
