From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 6/6] tests: Add tests for automatic use of pager
Date: Mon, 15 Feb 2010 00:37:47 -0500
Message-ID: <20100215053747.GA4897@coredump.intra.peff.net>
References: <462027ff1002131314k62069160h63760fc8316aa43b@mail.gmail.com>
 <20100213235156.GA9054@coredump.intra.peff.net>
 <20100214115430.GA1849@progeny.tock>
 <20100214121300.GF3499@progeny.tock>
 <20100215051016.GF3336@coredump.intra.peff.net>
 <20100215053521.GA22121@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Celis <sebastian@sebastiancelis.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:37:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgteW-0003yk-6r
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 06:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029Ab0BOFhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 00:37:43 -0500
Received: from peff.net ([208.65.91.99]:43892 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920Ab0BOFhn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 00:37:43 -0500
Received: (qmail 14778 invoked by uid 107); 15 Feb 2010 05:37:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 15 Feb 2010 00:37:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2010 00:37:47 -0500
Content-Disposition: inline
In-Reply-To: <20100215053521.GA22121@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139983>

On Sun, Feb 14, 2010 at 11:35:21PM -0600, Jonathan Nieder wrote:

> How about this?  It seems a little simpler, though it might be less
> reliable.
> [...]
> +if eval "exec 8>/dev/tty" 2>/dev/null && test -t 8

Right, it still breaks if we don't have a tty at all. Which is perhaps
not the "99% of runs" I mentioned before, but I think is not all that
uncommon (e.g., cron jobs).

-Peff
