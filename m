From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] builtin-commit: Add newline when showing which commit
 was created
Date: Sun, 2 Dec 2007 17:18:24 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712021716220.27959@racer.site>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site>
 <Pine.LNX.4.64.0711111736440.4362@racer.site> <20071201222106.GA27102@coredump.intra.peff.net>
 <Pine.LNX.4.64.0712012238510.27959@racer.site> <20071202054030.GA393@coredump.intra.peff.net>
 <Pine.LNX.4.64.0712021212490.27959@racer.site> <20071202165409.GA30998@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 02 18:19:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IysTG-0003JF-Ou
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 18:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbXLBRSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 12:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbXLBRSr
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 12:18:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:33217 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752526AbXLBRSr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 12:18:47 -0500
Received: (qmail invoked by alias); 02 Dec 2007 17:18:45 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp003) with SMTP; 02 Dec 2007 18:18:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XL2g8GMlXN+iiauAko5zYRs/IeZ+i653xh9pFrl
	pgqXumQCbZ8Xk2
X-X-Sender: gene099@racer.site
In-Reply-To: <20071202165409.GA30998@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66799>

Hi,

On Sun, 2 Dec 2007, Jeff King wrote:

> On Sun, Dec 02, 2007 at 12:13:07PM +0000, Johannes Schindelin wrote:
> 
> > > It would be helpful if you could remember the test case, but perhaps
> > > that is not an option at this point.
> > 
> > IIRC it was "git commit -m bla".
> 
> I have made several attempts to reproduce the problem, looked a bit
> through the log-tree code, and checked the results of the t750* series
> of tests; but I have found nothing.

I remember again.  When I did "commit -s -m bla" the  empty line between 
the oneline and the signoff would be missing.  But in the meantime, the 
signoff was dragged into the strbuf and all is well.

ACK.

Ciao,
Dscho
