From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add test-tr: poor-man tr
Date: Wed, 11 Jun 2008 18:54:48 -0400
Message-ID: <20080611225448.GC19474@sigill.intra.peff.net>
References: <20080611182501.GA3344@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>,
	Alex Riesen <raa@limbo.localdomain>
X-From: git-owner@vger.kernel.org Thu Jun 12 00:56:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6ZEX-0005Po-5l
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 00:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758527AbYFKWyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 18:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758456AbYFKWyv
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 18:54:51 -0400
Received: from peff.net ([208.65.91.99]:1381 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427AbYFKWyu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 18:54:50 -0400
Received: (qmail 14197 invoked by uid 111); 11 Jun 2008 22:54:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 11 Jun 2008 18:54:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jun 2008 18:54:48 -0400
Content-Disposition: inline
In-Reply-To: <20080611182501.GA3344@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84677>

On Wed, Jun 11, 2008 at 08:25:01PM +0200, Alex Riesen wrote:

> It offers a limited set of POSIX tr, in particular: no character class
> support and no [n*m] operators. Only 8bit. C-escapes supported, and
> character ranges. Deletion and squeezing should work, but -s does not
> match the GNU tr from coreutils (which, in turn, does not match POSIX).
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
> 
> Rebased on top of current master. I still think it makes the test
> suite more portable.

Having wrestled with Solaris tr, I can understand where you are coming
from. However, does this _actually_ increase the portability of the test
suite? That is, are there failing tests that this fixes, and if so, for
which platforms (getting a successful run of the test suite on Solaris
is still on my long-term todo, but I thought I had fixed all of the tr
issues)?

Or is your rationale "this will prevent people from screwing up the test
scripts accidentally in the future"?

I am not opposed to the latter, but I think it makes sense to state it
clearly in the commit message.

-Peff
