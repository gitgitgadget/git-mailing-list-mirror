From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/40] Add target architecture MinGW.
Date: Fri, 29 Feb 2008 21:54:24 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802292154110.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <200802282140.30654.johannes.sixt@telecom.at> <alpine.LSU.1.00.0802290105150.22527@racer.site> <200802292203.56899.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Feb 29 22:56:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVDCl-0002zo-SB
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 22:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761569AbYB2VzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 16:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761562AbYB2VzF
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 16:55:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:43447 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761554AbYB2VzD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 16:55:03 -0500
Received: (qmail invoked by alias); 29 Feb 2008 21:55:01 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp023) with SMTP; 29 Feb 2008 22:55:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+PKkcODcGPwjxw3j5Rkq6qAx4fXFGooR/1Y/pqx7
	hBgtkV6eS/kEEe
X-X-Sender: gene099@racer.site
In-Reply-To: <200802292203.56899.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75574>

Hi,

On Fri, 29 Feb 2008, Johannes Sixt wrote:

> On Friday 29 February 2008 02:07, Johannes Schindelin wrote:
> > On Thu, 28 Feb 2008, Johannes Sixt wrote:
> > > I thought about this, but I decided against it:  git-compat-util.h is
> > > the place to look for compatibility functions. A file compat/mingw.h
> > > only introduces an extra indirection and only *hides* stuff instead of
> > > making it obvious.
> >
> > Well, the thing is, there are quite a few definitions and declarations
> > that are _only_ _ever_ interesting if you are on MinGW32.
> >
> > So maybe it is a good idea to hide it to all the other users.
> 
> You get compat/mingw.h, but you don't get a zillion NO_<insert feature here>. 
> The two are pretty much exclusive anyway. Deal?

Deal.

Ciao,
Dscho

