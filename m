From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] bash completion: remove deprecated --prune from git-gc
Date: Sun, 14 Dec 2008 06:12:13 -0500
Message-ID: <20081214111213.GA6499@coredump.intra.peff.net>
References: <200812132008.08543.markus.heidelberg@web.de> <alpine.DEB.1.00.0812141137350.2014@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Markus Heidelberg <markus.heidelberg@web.de>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 14 12:13:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBoun-0002x2-Qg
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 12:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbYLNLMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 06:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbYLNLMQ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 06:12:16 -0500
Received: from peff.net ([208.65.91.99]:3785 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbYLNLMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 06:12:16 -0500
Received: (qmail 29035 invoked by uid 111); 14 Dec 2008 11:12:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 14 Dec 2008 06:12:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Dec 2008 06:12:13 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0812141137350.2014@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103066>

On Sun, Dec 14, 2008 at 11:38:17AM +0100, Johannes Schindelin wrote:

> > -		__gitcomp "--prune --aggressive"
> > +		__gitcomp "--aggressive"
> git gc --prune is deprecated?  That's news to me.

Check out 9e7d501 (builtin-gc.c: deprecate --prune, it now really has no
effect, 2008-05-09).

Which annoyingly has no discussion about _why_ it no longer has an
effect. But I suspect it has something to do with 25ee973 (gc: call
"prune --expire 2.weeks.ago" by default, 2008-03-12) by you.

-Peff
