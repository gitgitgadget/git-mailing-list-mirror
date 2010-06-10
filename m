From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/README: document --root option
Date: Thu, 10 Jun 2010 17:48:07 -0400
Message-ID: <20100610214807.GA24555@coredump.intra.peff.net>
References: <c5efa5c15498fe562af98b9b16165127bc1690c2.1276193888.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 10 23:48:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMpbn-0000uq-BA
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 23:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434Ab0FJVsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 17:48:13 -0400
Received: from peff.net ([208.65.91.99]:34148 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753391Ab0FJVsN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 17:48:13 -0400
Received: (qmail 14146 invoked by uid 107); 10 Jun 2010 21:48:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 10 Jun 2010 17:48:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jun 2010 17:48:07 -0400
Content-Disposition: inline
In-Reply-To: <c5efa5c15498fe562af98b9b16165127bc1690c2.1276193888.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148917>

On Thu, Jun 10, 2010 at 08:24:46PM +0200, Thomas Rast wrote:

> We've had this option since f423ef5 (tests: allow user to specify
> trash directory location, 2009-08-09).  Make it easier to look up :-)

Acked-by: Jeff King <peff@peff.net>

> +--root=<directory>::
> +	Use <directory> as a trash directory to store all temporary
> +	data during testing, instead of the t/ directory itself.
> +	Using this option with a RAM-based filesystem (such as tmpfs)
> +	can massively speed up the test suite.

Minor nit: <directory> is not the trash directory, but rather the root
of all trash directories. I think anybody with half a clue will
understand what it means, though.

-Peff
