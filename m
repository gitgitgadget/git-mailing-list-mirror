From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make Git accept absolute path names for files within
 the work tree
Date: Tue, 4 Dec 2007 02:17:40 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712040216220.27959@racer.site>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com>
 <20071203024916.GA11003@coredump.intra.peff.net> <200712030755.37038.robin.rosenberg@dewire.com>
 <200712032153.31322.robin.rosenberg.lists@dewire.com>
 <20071204014326.GA21358@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <gitster@pobox.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 04 03:18:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzNMz-0003eD-ML
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 03:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbXLDCSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 21:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbXLDCSH
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 21:18:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:54900 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751239AbXLDCSG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 21:18:06 -0500
Received: (qmail invoked by alias); 04 Dec 2007 02:18:04 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp038) with SMTP; 04 Dec 2007 03:18:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18YIdBYa2sYkRMnmDBQZNdEwulY8UfWe8vFBR7t7C
	zzRrUvltqdYF1m
X-X-Sender: gene099@racer.site
In-Reply-To: <20071204014326.GA21358@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66994>

Hi,

On Mon, 3 Dec 2007, Jeff King wrote:

> On Mon, Dec 03, 2007 at 09:53:30PM +0100, Robin Rosenberg wrote:
> 
> > code did not pass). Like Linus, this code does not resolve symlinks,
> > but I forgot to state that it is by design. It solves my problem and
> 
> By design meaning "I didn't feel like implemening it because I do not
> personally care" or "I have some reason not to resolve symlinks"?

IMHO those symlinks would be a nice thing in some corner cases, but 
penalise the common case.  So I tend to believe the latter.  (See also 
Linus' message why he talks about his preference for the die() code path.)

Ciao,
Dscho
