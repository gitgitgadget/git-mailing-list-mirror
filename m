From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor annoyance with git push
Date: Sun, 10 Feb 2008 12:22:27 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101221310.11591@racer.site>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <7vtzkihkx5.fsf@gitster.siamese.dyndns.org> <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com> <7vwspd5z1d.fsf@gitster.siamese.dyndns.org>
 <20080210101353.GA26568@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 10 13:23:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOBD3-0000H5-5Q
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 13:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbYBJMW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 07:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753660AbYBJMW1
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 07:22:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:41799 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752599AbYBJMW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 07:22:26 -0500
Received: (qmail invoked by alias); 10 Feb 2008 12:22:24 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp018) with SMTP; 10 Feb 2008 13:22:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fgZdIX17fRRH1UvpI3Hza9vTXvP70eRPBxyUplx
	aNw+nBXnbTP6xV
X-X-Sender: gene099@racer.site
In-Reply-To: <20080210101353.GA26568@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73344>

Hi,

On Sun, 10 Feb 2008, Jeff King wrote:

> On Sat, Feb 09, 2008 at 06:24:30PM -0800, Junio C Hamano wrote:
> 
> > > Still, the big fat ![rejected] do seem over the top when I know it 
> > > really means "stale".
> >
> > If "stale" can be proven cheaply, I think it would be a very good 
> > change to introduce [rejected] vs [stale].
> 
> I think there is still one problem with that: you are not splitting the
> cases into "rejected" and "stale".

FWIW I think it is perfectly reasonable to say "stale" when you _know_ 
that it's stale, and "rejected" when you don't know the reason.

Ciao,
Dscho
