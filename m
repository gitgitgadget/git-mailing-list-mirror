From: Jeff King <peff@peff.net>
Subject: Re: Why a _full_ diff? (was: [PATCH] Char: serial167, cleanup (fwd))
Date: Mon, 12 Feb 2007 04:38:13 -0500
Message-ID: <20070212093813.GA15779@coredump.intra.peff.net>
References: <Pine.LNX.4.62.0702120934120.10436@chinchilla.sonytel.be> <20070212092028.GB12605@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 10:38:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGXdb-0004tD-6V
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 10:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbXBLJiQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 04:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbXBLJiQ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 04:38:16 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1608 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964829AbXBLJiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 04:38:16 -0500
Received: (qmail 3359 invoked from network); 12 Feb 2007 04:38:20 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 12 Feb 2007 04:38:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Feb 2007 04:38:13 -0500
Content-Disposition: inline
In-Reply-To: <20070212092028.GB12605@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39388>

On Mon, Feb 12, 2007 at 04:20:30AM -0500, Jeff King wrote:

> > | diff --git a/drivers/char/serial167.c b/drivers/char/serial167.c
> > | dissimilarity index 67%
> > | index af50d32..5fd314a 100644

OK, I see now. This is triggered by using 'git show -B', which breaks
the diff apart into a big rewriting chunk. Unfortunately, I don't know
enough about how -B works to say whether this makes sense or not.

-Peff
