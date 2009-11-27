From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] grep: --full-tree
Date: Fri, 27 Nov 2009 11:56:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0911271155310.4521@intel-tinevez-2-302>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org> <20091125203922.GA18487@coredump.intra.peff.net> <7viqcytjic.fsf@alter.siamese.dyndns.org> <20091125210034.GC18487@coredump.intra.peff.net> <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net> <885649360911251412n3e566c8fu536b361b993f2ac6@mail.gmail.com> <20091125222037.GA2861@coredump.intra.peff.net> <885649360911260956p58c54a54rd887102c9adedcc9@mail.gmail.com> <20091127062013.GA20844@coredump.intra.peff.net>
 <alpine.DEB.1.00.0911271027510.4521@intel-tinevez-2-302> <vpq8wdsqmm4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, James Pickens <jepicken@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Nov 27 11:57:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDyVc-0004vp-VW
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 11:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbZK0K4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 05:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbZK0K4x
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 05:56:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:59799 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750871AbZK0K4x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 05:56:53 -0500
Received: (qmail invoked by alias); 27 Nov 2009 10:56:58 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 27 Nov 2009 11:56:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HovpcIYZHan/t/Hvm7N4U1Jb7BSXSSb3n7mrMQc
	cSrkuFTrPx2GYg
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <vpq8wdsqmm4.fsf@bauges.imag.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133892>

Hi,

On Fri, 27 Nov 2009, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Guess what.  I have a similar problem, only it is that my "git status" 
> > output is _always_ too long, so I always have to page it.
> >
> > Once upon a time, Junio applied a patch that implied -p with status.  
> > I was overjoyed.  He reverted that patch later.  Yes, exactly.
> 
> In this particular example, a config variable was added (pager.status = 
> true). But one big difference is that while pager.status = true can be 
> /annoying/ for some users, it can never really harm (since the pager 
> will automatically disable itself in the cases where you'd really don't 
> want it).

It changes behavior.  And worse: it changes behavior _in a different 
manner_ in different repositories.  I have too many of them to remember 
what I set where.

So it is harmful in a very real sense.

> > So I end up doing "git config --global ps '-p status'" on every new 
> > account (I usually even forget to curse!), and I really cannot see why you 
> > do not do the equivalent "git config fullgrep grep --full-tree" in your 
> > repositories (or even the global thing).
> 
> (I guess you meant alias.fullgrep)

You guessed right, and likewise alias.ps.

Ciao,
Dscho
