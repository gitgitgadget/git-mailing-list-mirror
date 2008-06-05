From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Thu, 5 Jun 2008 14:13:59 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806051408520.21190@racer>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806032115340.13507@racer.site.net> <Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz> <20080604102906.GA2126@diana.vm.bytemark.co.uk> <m3ej7dzc7y.fsf@localhost.localdomain>
 <Pine.LNX.4.61.0806041424140.1798@tm8103-a.perex-int.cz> <alpine.DEB.1.00.0806041641150.13507@racer.site.net> <20080605010330.GB24466@leksak.fem-net> <alpine.DEB.1.00.0806050523120.21190@racer> <4847917A.2050700@viscovery.net>
 <Pine.LNX.4.61.0806051428390.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
X-From: git-owner@vger.kernel.org Thu Jun 05 15:16:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4FKB-0007VB-Nz
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 15:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197AbYFENPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 09:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754165AbYFENPW
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 09:15:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:43304 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754018AbYFENPV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 09:15:21 -0400
Received: (qmail invoked by alias); 05 Jun 2008 13:15:19 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp003) with SMTP; 05 Jun 2008 15:15:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183uhlKMg03ziae83qqzG0Qc28Ebxpr07p1x2WZgN
	j1CKmZDT+PHfZI
X-X-Sender: gene099@racer
In-Reply-To: <Pine.LNX.4.61.0806051428390.1798@tm8103-a.perex-int.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83925>

Hi,

On Thu, 5 Jun 2008, Jaroslav Kysela wrote:

> On Thu, 5 Jun 2008, Johannes Sixt wrote:
> 
> > Johannes Schindelin schrieb:
> > > 
> > > On Thu, 5 Jun 2008, Stephan Beyer wrote:
> > > 
> > >>> - as has been pointed out several times now, you _are_ the 
> > >>>   committer, and you seem to want to lie there.
> > >> Lying is already possible with GIT_COMMITTER_{NAME,EMAIL,NAME} 
> > >> environment variables.
> > > 
> > > Of course it is possible!  I even pointed to a method!
> > > 
> > > The _point_ was that we do not want to recommend it.  And giving 
> > > prominent support for it, such as introducing a command line 
> > > parameter, _would_ have the effect of recommending it.
> > 
> > Furthermore, if you mess with committer dates, you can screw up revision
> > walking to some degree. committer dates aren't merely informational.
> 
> Of course, you can find many reasons to not use this function.

The reasons were not so much about avoiding to use it, but avoiding to 
introduce it, because the existence alone would cause more harm than good.

The existence would help people lie about who did what, and confuse rather 
than help users find who did what (and whom to blame^Wask for assistance).

It would make a wonderfully helpful tool less helpful.

> I just used the proposed function when we migrated from HG to GIT to 
> rebase with actual Linus's tree without touching commiters (because I've 
> not changed patches itself).

But that would have been much easier with a single graft and a subsequent 
clone, no?

> Also, having a possibility to easy remove a changeset (hardly - not 
> revert) without touching all other changesets on top is a function worth 
> to include.

The problem there is that you -- again -- lie about the committers.  They 
_never_ saw, approved, or tested those commits.

Unless the trees were identical, in which case grafting is the way to go.

> If there are not real technical reasons agains, it should go in.

I hope that I finally made it clear that I do not see technical reasons 
against it.

> I saw only "political" comments that it's evil to do so in some (most 
> of) cases.

If you really think this is about politics instead of semantics, then I 
did not get my point across.

Sad,
Dscho
