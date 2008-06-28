From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH, next version] git bisect: introduce 'fixed' and
 'unfixed'
Date: Sat, 28 Jun 2008 14:48:55 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806281446260.9925@racer>
References: <alpine.DEB.1.00.0806241515460.9925@racer> <20080624163810.GA4654@sigill.intra.peff.net> <alpine.DEB.1.00.0806241750030.9925@racer> <alpine.DEB.1.00.0806241808400.9925@racer> <20080624174157.GB9500@sigill.intra.peff.net> <7vej6mbh3w.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806271446180.9925@racer> <7vprq2o4zb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 15:52:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCaqM-0000BD-J5
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 15:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbYF1NvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 09:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbYF1NvB
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 09:51:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:57783 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752202AbYF1NvA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 09:51:00 -0400
Received: (qmail invoked by alias); 28 Jun 2008 13:50:54 -0000
Received: from 87.113.36.200.plusnet.pte-ag1.dyn.plus.net (EHLO racer.local) [87.113.36.200]
  by mail.gmx.net (mp017) with SMTP; 28 Jun 2008 15:50:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19eVW4oNSteCSROhVWGvH0SX17GgmhR3VEaQ+bUjN
	m1yMlE8yAOdmhp
X-X-Sender: gene099@racer
In-Reply-To: <7vprq2o4zb.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86717>

Hi,

On Fri, 27 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When you look for a fix instead of a regression, it can be quite hard 
> > to twist your brain into choosing the correct bisect command between 
> > 'git bisect bad' and 'git bisect good'.
> 
> Hmm, I do not currently see any differene between master and next version
> of bisect.  In what way is this 'next' version?

It has a "BAD" and a "GOOD" variable that are reset to "fixed" and 
"unfixed" if the user said "fixed" or "unfixed".

> Aside from the 'visualize' issue this does not attempt to address,

Yes, I forgot about that issue, mainly because I do not use it myself...

> I wonder if it may be a good idea to detect and warn mixed usage as well 
> (e.g. "You earlier said 'bad' but now you are saying 'fixed' -- are you 
> sure?"), and if so if it can be implemented easily.

Hmm.  I tried to avoid that, as it would mean a larger patch.  But I guess 
you could write .git/BISECT_TERMS or some such.

But that, together with the visualize part, would take more time than I am 
willing to spend on this issue.

Well, I guess I'll leave it then,
Dscho
