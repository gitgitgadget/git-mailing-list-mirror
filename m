From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why a _full_ diff? (was: [PATCH] Char: serial167, cleanup (fwd))
Date: Mon, 12 Feb 2007 13:00:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702121257590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.62.0702120934120.10436@chinchilla.sonytel.be>
 <20070212092028.GB12605@coredump.intra.peff.net> <20070212093813.GA15779@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 13:01:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGZrf-0000vD-Cq
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 13:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbXBLMA4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 07:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbXBLMA4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 07:00:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:55835 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964878AbXBLMAz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 07:00:55 -0500
Received: (qmail invoked by alias); 12 Feb 2007 12:00:54 -0000
X-Provags-ID: V01U2FsdGVkX19MLYlHzUtMec23uuJbtCUGQbkMRUXUsaZpVeJVtt
	cc9w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070212093813.GA15779@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39398>

Hi,

On Mon, 12 Feb 2007, Jeff King wrote:

> On Mon, Feb 12, 2007 at 04:20:30AM -0500, Jeff King wrote:
> 
> > > | diff --git a/drivers/char/serial167.c b/drivers/char/serial167.c
> > > | dissimilarity index 67%
> > > | index af50d32..5fd314a 100644
> 
> OK, I see now. This is triggered by using 'git show -B', which breaks
> the diff apart into a big rewriting chunk. Unfortunately, I don't know
> enough about how -B works to say whether this makes sense or not.

AFAICT you can provide a minimum score with -B, just as with -M, i.e. if 
the diff score is larger than this value, it is interpreted as a complete 
rewrite.

Hth,
Dscho
