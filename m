From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 17:50:38 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806241750030.9925@racer>
References: <alpine.DEB.1.00.0806241515460.9925@racer> <20080624163810.GA4654@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 24 18:53:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBBly-0003LR-3x
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 18:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbYFXQwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 12:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753081AbYFXQwl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 12:52:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:55516 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751615AbYFXQwl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 12:52:41 -0400
Received: (qmail invoked by alias); 24 Jun 2008 16:52:39 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp006) with SMTP; 24 Jun 2008 18:52:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XTGcVYidXZHhrqlVRiNs0Qvz+LYWdCZsVrW77vz
	I62W+ntH8fWDcO
X-X-Sender: gene099@racer
In-Reply-To: <20080624163810.GA4654@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86084>

Hi,

On Tue, 24 Jun 2008, Jeff King wrote:

> On Tue, Jun 24, 2008 at 03:17:18PM +0100, Johannes Schindelin wrote:
> 
> > When you look for a fix instead of a regression, it can be quite hard
> > to twist your brain into choosing the correct bisect command between
> > 'git bisect bad' and 'git bisect good'.
> > 
> > So introduce the commands 'git bisect fixed' and 'git bisect unfixed'.
> 
> Thanks. This just bit me the other day, and I thought of the same
> solution. I think it might be worth a "non-toy" patch.

Okay, that's 3 people who I take the courage from to turn this into a 
proper patch.

Ciao,
Dscho
