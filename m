From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] Advertise the ability to abort a commit
Date: Thu, 31 Jul 2008 01:50:24 -0400
Message-ID: <20080731055024.GA17652@sigill.intra.peff.net>
References: <20080730051059.GA4497@sigill.intra.peff.net> <1217440391-13259-1-git-send-email-mail@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Thu Jul 31 07:51:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOR4R-0001KW-3z
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 07:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbYGaFu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 01:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbYGaFu0
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 01:50:26 -0400
Received: from peff.net ([208.65.91.99]:1619 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701AbYGaFuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 01:50:25 -0400
Received: (qmail 17315 invoked by uid 111); 31 Jul 2008 05:50:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 31 Jul 2008 01:50:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jul 2008 01:50:24 -0400
Content-Disposition: inline
In-Reply-To: <1217440391-13259-1-git-send-email-mail@cup.kalibalik.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90892>

On Wed, Jul 30, 2008 at 07:53:11PM +0200, Anders Melchiorsen wrote:

> An empty commit message is now treated as a normal situation, not an error.

As others have commented, I think the right way to say this is probably
"it is not reported to the user as an error, but still exits with a
non-zero exit status".

And I think it looks better.

But:

>  			"# Please enter the commit message for your changes.\n"
> +			"# To abort the commit, use an empty commit message.\n"
>  			"# (Comment lines starting with '#' will ");

I still prefer a shortened version of these three lines, as I mentioned
earlier.

-Peff
