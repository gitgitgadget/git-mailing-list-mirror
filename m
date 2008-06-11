From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve sed portability
Date: Wed, 11 Jun 2008 12:39:04 -0400
Message-ID: <20080611163904.GB19172@sigill.intra.peff.net>
References: <1213189759-11565-1-git-send-email-chris.ridd@isode.com> <484FDB5D.7060606@viscovery.net> <484FEF71.2030909@isode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chris Ridd <chris.ridd@isode.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 18:40:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6TN5-0007T8-VR
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 18:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbYFKQjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 12:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbYFKQjH
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 12:39:07 -0400
Received: from peff.net ([208.65.91.99]:3436 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbYFKQjG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 12:39:06 -0400
Received: (qmail 17395 invoked by uid 111); 11 Jun 2008 16:39:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 11 Jun 2008 12:39:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jun 2008 12:39:04 -0400
Content-Disposition: inline
In-Reply-To: <484FEF71.2030909@isode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84621>

On Wed, Jun 11, 2008 at 04:29:53PM +0100, Chris Ridd wrote:

> It is necessary to use double quotes. This:
>
>     printf '%s\n' foobar
>
> prints a literal \, a literal n, and no newline:
>
>     foobar\n
>
> Not desirable :-(

On what platform?

> Of course, using a plain old:
>
>     echo "$1"
>
> should work well too. Why is printf being used here and not echo, anyway?

Because the original didn't have a newline, and "echo -n" isn't
portable?

-Peff
