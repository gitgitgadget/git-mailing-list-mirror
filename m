From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3.1 3/5] Introduce new pretty formats %g[sdD] for
 reflog information
Date: Sun, 18 Oct 2009 03:18:29 -0400
Message-ID: <20091018071829.GA7748@coredump.intra.peff.net>
References: <8a5b3a586d437f02e2a75edd2786636b605522a7.1255701207.git.trast@student.ethz.ch>
 <e0ab6923eb4057bcbc8e97980dad5e4a37e53067.1255790816.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Oct 18 09:18:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzQ2K-0002st-8L
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 09:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbZJRHS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 03:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbZJRHS3
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 03:18:29 -0400
Received: from peff.net ([208.65.91.99]:38582 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbZJRHS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 03:18:28 -0400
Received: (qmail 2472 invoked by uid 107); 18 Oct 2009 07:22:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 18 Oct 2009 03:22:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Oct 2009 03:18:29 -0400
Content-Disposition: inline
In-Reply-To: <e0ab6923eb4057bcbc8e97980dad5e4a37e53067.1255790816.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130585>

On Sat, Oct 17, 2009 at 04:48:11PM +0200, Thomas Rast wrote:

> > +NOTE: Some placeholders may depend on other options given to the
> > +revision traversal engine. For example, the `%g*` reflog options will
> > +insert an empty string unless we are traversing reflog entries (e.g., by
> > +`git log -g`). The `%d` placeholder will use the "short" decoration
> > +format if `--decorate` was not already provided on the command line.
> 
> Sure.  I figured it was obvious enough, but since you already went to
> the lengths of documenting the exact behaviour of %d, I squashed it
> and adjusted the acknowledgement in the commit message accordingly.

If the consensus (or Junio's decision when applying) is that we don't
need it, I don't mind if my suggestion is scrapped (or reworded).

-Peff
