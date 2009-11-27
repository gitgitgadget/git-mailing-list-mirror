From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 11:53:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911271144230.4521@intel-tinevez-2-302>
References: <20091125203922.GA18487@coredump.intra.peff.net> <7viqcytjic.fsf@alter.siamese.dyndns.org> <20091125210034.GC18487@coredump.intra.peff.net> <7vmy2as319.fsf@alter.siamese.dyndns.org> <20091125214949.GA31473@coredump.intra.peff.net>
 <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com> <20091125222037.GA2861@coredump.intra.peff.net> <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com> <20091127062013.GA20844@coredump.intra.peff.net> <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302>
 <20091127095914.GA4865@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James Pickens <jepicken@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 27 11:53:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDySW-0003k4-47
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 11:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbZK0Kxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 05:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753404AbZK0Kxj
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 05:53:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:54275 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750778AbZK0Kxi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 05:53:38 -0500
Received: (qmail invoked by alias); 27 Nov 2009 10:53:43 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp047) with SMTP; 27 Nov 2009 11:53:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ANhM8QsiAikE34Oe1FPvYjOxBSnNf4b6jl0GxEs
	TnBc/lgo9oVy+w
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20091127095914.GA4865@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133890>

Hi,

On Fri, 27 Nov 2009, Jeff King wrote:

> On Fri, Nov 27, 2009 at 10:31:30AM +0100, Johannes Schindelin wrote:
> 
> > Guess what.  I have a similar problem, only it is that my "git status" 
> > output is _always_ too long, so I always have to page it.
> > 
> > Once upon a time, Junio applied a patch that implied -p with status.  
> > I was overjoyed.  He reverted that patch later.  Yes, exactly.
> > 
> > So I end up doing "git config --global ps '-p status'" on every new 
> 
> If only somebody had written a "pager.status" configuration variable,
> you could use that. Oh wait. I did. And it shipped in v1.6.0.

And it makes things inconsistent.  That is why I do not use it.  Do you 
work on 10 different computers?  I do.  And nothing is more unnerving than 
the same command producing something different on the different computers.

Sure, after a few minutes of fiddling I find out that it was my fault to 
begin with, but dammit! if the tool makes it that hard already for an 
expert, it is outright unusable for new users.

I, for one, do not like Git's reputation, but I am tired of trying to 
fight for the users.  BTW quick question: how many Git _users_ were at the 
GitTogether at MV?  0?

> > account (I usually even forget to curse!), and I really cannot see why 
> > you do not do the equivalent "git config fullgrep grep --full-tree" in 
> > your repositories (or even the global thing).
> >
> > The further benefit is that we stop talking about breaking backwards 
> > compatibility, and we stop talking about making it hard for Git 
> > experts to help newbies.
> 
> I guess you missed the part of the thread where I already discussed
> this. It was here:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/133672

I only skimmed it, yes.  And I did not plan to participate in this thread.  
But it seems that my views are not represented enough, even if gitzilla 
chimed in with the very valid, under-acknowledged and over-ignored 
message: consistency is good.  Corollary: inconsistency is bad.

Ciao,
Dscho
