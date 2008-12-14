From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] bash completion: remove deprecated --prune from git-gc
Date: Sun, 14 Dec 2008 06:19:39 -0500
Message-ID: <20081214111939.GC6499@coredump.intra.peff.net>
References: <200812132008.08543.markus.heidelberg@web.de> <alpine.DEB.1.00.0812141137350.2014@eeepc-johanness> <20081214111213.GA6499@coredump.intra.peff.net> <alpine.DEB.1.00.0812141216120.2014@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Markus Heidelberg <markus.heidelberg@web.de>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 14 12:20:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBp1v-0004du-BG
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 12:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbYLNLTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 06:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753127AbYLNLTm
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 06:19:42 -0500
Received: from peff.net ([208.65.91.99]:2729 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901AbYLNLTl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 06:19:41 -0500
Received: (qmail 29169 invoked by uid 111); 14 Dec 2008 11:19:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 14 Dec 2008 06:19:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Dec 2008 06:19:39 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0812141216120.2014@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103070>

On Sun, Dec 14, 2008 at 12:17:07PM +0100, Johannes Schindelin wrote:

> > Which annoyingly has no discussion about _why_ it no longer has an
> > effect. But I suspect it has something to do with 25ee973 (gc: call
> > "prune --expire 2.weeks.ago" by default, 2008-03-12) by you.
> 
> Oops.
> 
> But I thought that git gc --prune does expire _all_ dangling loose 
> objects _now_, not with --expire 2.weeks.ago.

Nope, see 25ee973. You explicitly wrote:

      Note that this new behaviour makes "--prune" be a no-op.

That being said, I think that is perhaps a reasonable thing for --prune
to do (and I don't think there is any conflict with the name, because
that is what it _used_ to do before becoming a no-op). But nobody has
actually implemented it.

-Peff
