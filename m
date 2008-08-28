From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 17:32:23 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808281731490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net>
 <7vr68b8q9p.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808261717480.1624@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	users@kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 17:29:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYjQ1-00036S-WA
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 17:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYH1P1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 11:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752754AbYH1P1N
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 11:27:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:41374 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752421AbYH1P1N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 11:27:13 -0400
Received: (qmail invoked by alias); 28 Aug 2008 15:27:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp052) with SMTP; 28 Aug 2008 17:27:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18baE5pOp0bZI+LadgeNhw9KsZ1OipMLBPqwcCR5q
	6X8f8Tcg0Yc2ZZ
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.LFD.1.10.0808261717480.1624@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94071>

Hi,

On Tue, 26 Aug 2008, Nicolas Pitre wrote:

> On Tue, 26 Aug 2008, Junio C Hamano wrote:
> 
> > Read the subject line again, and notice that we are not talking about
> > /usr/bin vs /usr/libexec/git-core; the request-for-discussion was about
> > removing "git-add" and friends from /usr/libexec/git-core/, so that we do
> > not have to even have these many hardlinks there.  Except for Linus (and
> > obviously myself who started the thread), I saw nobody expressed any
> > opinion on it.
> 
> Don't deprecate git-foo and leave them in $gitexecdir as things are now.
> That's the best compromise IMHO.
> 
> Those who want git-foo can have it via several and easy means.  Those 
> who want 'git foo' have it by default which IMHO is pretty sane (the 
> other way around is less easy so 'git foo' being the default is the most 
> sensible alternative).
> 
> Platforms where filesystem links are not available simply don't have to 
> support the git-foo form, period.  I doubt users of such platforms will 
> care much.
> 
> All the rest is only bikeshedding.

Not wanting to be part of a _silent_ majority, I fully agree, loudly.

Ciao,
Dscho
