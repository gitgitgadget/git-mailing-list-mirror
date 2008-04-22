From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 14:03:43 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804221357420.4460@eeepc-johanness>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <alpine.DEB.1.00.0804221250010.4460@eeepc-johanness>
 <20080422125618.GA27577@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Galbraith <efault@gmx.de>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 22 15:06:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoIC0-0005dV-IH
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 15:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759189AbYDVNDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 09:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759147AbYDVNDT
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 09:03:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:50591 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754740AbYDVNDS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 09:03:18 -0400
Received: (qmail invoked by alias); 22 Apr 2008 13:03:16 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp023) with SMTP; 22 Apr 2008 15:03:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+f1jAEA7CfLqvC6hNrgoBLSbM3ffBOE2do4IiUJv
	zX8y0CtKiHdY3S
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080422125618.GA27577@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80114>

Hi,

On Tue, 22 Apr 2008, Jeff King wrote:

> Dscho wrote:
> 
> > It was a concious decision, but maybe it was wrong.
> > 
> > My rationale was this: if I mirror another person's repository, I want 
> > all the history.  And I do want to keep it, even if the other person 
> > decides to clean the original repository out.
> >
> > (In this case, the reflogs would not help, since I do not have a HEAD 
> > reflog for all the deleted branches, and deleting the refs deletes 
> > their reflogs, too.)
> 
> Hmm, there is an inconsistency here, though, since we set it up one way 
> on clone and another way on "remote add". Though if clone does finally 
> become "init + remote add + checkout" that will resolve itself.
> 
> Still, I think I prefer the old "+" behavior. We don't actually
> _delete_ branches, we just allow non-fast-forward updates. The reflogs
> will still be there.

Oh, that's right: only "git remote prune" will delete stale refs only.

But my other point about possibly interfering with local branches still 
holds true.

Ciao,
Dscho
