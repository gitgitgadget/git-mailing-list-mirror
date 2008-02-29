From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/40] Windows: Use the Windows style PATH separator
 ';'.
Date: Fri, 29 Feb 2008 01:09:35 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802290108530.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-5-git-send-email-johannes.sixt@telecom.at> <47C67E1A.5030304@gnu.org> <200802282143.19322.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Feb 29 02:10:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUtm3-0000HI-Cl
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 02:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757217AbYB2BKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 20:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756404AbYB2BKN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 20:10:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:50877 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755567AbYB2BKL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 20:10:11 -0500
Received: (qmail invoked by alias); 29 Feb 2008 01:10:09 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp016) with SMTP; 29 Feb 2008 02:10:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19LkEQCxMpL9Fi+0RZKETpG2Ixc3j0eEAweYIrQgX
	MiKppM6zKFSmN4
X-X-Sender: gene099@racer.site
In-Reply-To: <200802282143.19322.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75480>

Hi,

On Thu, 28 Feb 2008, Johannes Sixt wrote:

> On Thursday 28 February 2008 10:25, Paolo Bonzini wrote:
> > > +#ifdef __MINGW32__
> > > +		strbuf_addch(out, ';');
> > > +#else
> > >  		strbuf_addch(out, ':');
> > > +#endif
> >
> > Why not adding a PATH_SEPARATOR #define?
> 
> Because IMO it is obfuscating:
> 
> 1. When you read through the code and see PATH_SEPARATOR, you still have
> to go look how it's defined. Why? Because you always will ask: Is this 
> about ':' vs. ';' or '/' vs. '\\'?
> 
> 2. When you look for where ":" or ";" are treated, you'll end up at the
> #define. Then you need an extra step to search for PATH_SEPARATOR.

IMO these are not good arguments.  If they were, we could not typedef 
size_t and socklen_t, either.

Ciao,
Dscho

