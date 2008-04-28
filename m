From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use
	whitespace.
Date: Mon, 28 Apr 2008 05:41:19 -0400
Message-ID: <20080428094119.GA20499@sigill.intra.peff.net>
References: <20080427151610.GB57955@Hermes.local> <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness> <B287EA35-6C5D-4A5A-BEF1-C55A70D913ED@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:42:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqPs9-0003BD-7p
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 11:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882AbYD1JlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 05:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758583AbYD1JlV
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 05:41:21 -0400
Received: from peff.net ([208.65.91.99]:2399 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753744AbYD1JlV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 05:41:21 -0400
Received: (qmail 5440 invoked by uid 111); 28 Apr 2008 09:41:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 28 Apr 2008 05:41:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2008 05:41:19 -0400
Content-Disposition: inline
In-Reply-To: <B287EA35-6C5D-4A5A-BEF1-C55A70D913ED@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80518>

On Sun, Apr 27, 2008 at 11:32:24AM -0400, Brian Gernhardt wrote:

> Eh, not everyone's perfect.  I would have used `rev` instead of `tac` and 
> still been wrong for Solaris.  But it seems that the `wc -l` whitespace 
> issue seems to hit nearly everyone at some point, so I thought it would be 
> a good candidate for CodingStyle.
>
> Personally, I'd love to have the time to review all the patches to catch 
> these issues while still on the list instead of waiting until they hit 
> next and I tried to compile it.  But I don't always notice, have time, or 
> care myself.

BTW, how did you discover this bug? Through normal use, or was there a
failing test?

If a failing test, then I wonder if we could get a few people to set up
automated tests on alternate platforms. IIRC, Junio makes sure that
master always passes test on his Linux box and KO (Debian and Redhat, I
think?). Other platforms could "git pull && make test" daily. I could
probably do Solaris (once I get the tests to complete pass at all!) and
FreeBSD 6.

-Peff
