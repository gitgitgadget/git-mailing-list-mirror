From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add an (optional, since expensive) test for >2g
	clones
Date: Thu, 5 Mar 2009 13:50:04 -0500
Message-ID: <20090305185004.GB19244@coredump.intra.peff.net>
References: <cover.1236268730u.git.johannes.schindelin@gmx.de> <96a26f3a883890b3e56c867e8183618784837d4d.1236268730u.git.johannes.schindelin@gmx.de> <20090305164153.GD4213@coredump.intra.peff.net> <alpine.DEB.1.00.0903051754260.6524@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 05 19:51:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfIfT-00082o-Tp
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 19:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbZCESuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 13:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753620AbZCESuL
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 13:50:11 -0500
Received: from peff.net ([208.65.91.99]:40390 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200AbZCESuK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 13:50:10 -0500
Received: (qmail 2311 invoked by uid 107); 5 Mar 2009 18:50:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 05 Mar 2009 13:50:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Mar 2009 13:50:04 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903051754260.6524@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112325>

On Thu, Mar 05, 2009 at 05:58:23PM +0100, Johannes Schindelin wrote:

> > Leftover cruft using genrandom? (I'm guessing you tried random at first
> > to avoid compression, but I think your pack.compression=0 technique is
> > more sensible).
> 
> Actually, I left it in on purpose.  Yes, it happens to work right now, as 
> the packs are built with 0 compression and with 0 deltification.

Fair enough. A comment in the commit message or in the code might have
made that more clear, though...

-Peff
