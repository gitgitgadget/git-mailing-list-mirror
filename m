From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bash completion: remove deprecated --prune from git-gc
Date: Sun, 14 Dec 2008 12:17:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812141216120.2014@eeepc-johanness>
References: <200812132008.08543.markus.heidelberg@web.de> <alpine.DEB.1.00.0812141137350.2014@eeepc-johanness> <20081214111213.GA6499@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Markus Heidelberg <markus.heidelberg@web.de>, gitster@pobox.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 14 12:17:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBoy7-0003jH-IY
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 12:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320AbYLNLPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 06:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754421AbYLNLPm
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 06:15:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:45982 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754320AbYLNLPl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 06:15:41 -0500
Received: (qmail invoked by alias); 14 Dec 2008 11:15:38 -0000
Received: from ini-firewall.unizh.ch (EHLO eeepc-johanness) [130.60.5.218]
  by mail.gmx.net (mp049) with SMTP; 14 Dec 2008 12:15:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+obSEIAUyoveOmqcf0qNVWlb6A23Iih0kQ0XilJF
	NAUuSxuhksXzgD
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20081214111213.GA6499@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103067>

Hi,

On Sun, 14 Dec 2008, Jeff King wrote:

> On Sun, Dec 14, 2008 at 11:38:17AM +0100, Johannes Schindelin wrote:
> 
> > > -		__gitcomp "--prune --aggressive"
> > > +		__gitcomp "--aggressive"
> > git gc --prune is deprecated?  That's news to me.
> 
> Check out 9e7d501 (builtin-gc.c: deprecate --prune, it now really has no
> effect, 2008-05-09).
> 
> Which annoyingly has no discussion about _why_ it no longer has an
> effect. But I suspect it has something to do with 25ee973 (gc: call
> "prune --expire 2.weeks.ago" by default, 2008-03-12) by you.

Oops.

But I thought that git gc --prune does expire _all_ dangling loose 
objects _now_, not with --expire 2.weeks.ago.

Ciao,
Dscho
