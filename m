From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [NON-TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 21:38:39 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806242137120.9925@racer>
References: <alpine.DEB.1.00.0806241515460.9925@racer> <20080624163810.GA4654@sigill.intra.peff.net> <alpine.DEB.1.00.0806241750030.9925@racer> <alpine.DEB.1.00.0806241808400.9925@racer> <486153DB.3070502@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 24 22:41:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBFKc-0001s1-2Y
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 22:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbYFXUkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 16:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbYFXUkm
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 16:40:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:49336 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752473AbYFXUkl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 16:40:41 -0400
Received: (qmail invoked by alias); 24 Jun 2008 20:40:39 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp033) with SMTP; 24 Jun 2008 22:40:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ru0tlki9ro2hURwjjyH7WMVx62lnhAW/QxiDEMu
	96nI1Fbc8vkwsk
X-X-Sender: gene099@racer
In-Reply-To: <486153DB.3070502@alum.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86141>

Hi,

On Tue, 24 Jun 2008, Michael Haggerty wrote:

> Johannes Schindelin wrote:
> > When you look for a fix instead of a regression, it can be quite hard
> > to twist your brain into choosing the correct bisect command between
> > 'git bisect bad' and 'git bisect good'.
> > 
> > So introduce the commands 'git bisect fixed' and 'git bisect unfixed'.
> 
> It seems to me that your problem is that git-bisect requires the "good" 
> revision to be older than the "bad" one.  If this requirement were 
> removed, would there still be a need for "fixed" vs. "unfixed"?

Nope.

The thing that makes "fixed" and "bad" special is that _one_ commit 
introduced that.

Ciao,
Dscho
