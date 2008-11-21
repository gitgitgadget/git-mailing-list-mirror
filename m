From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: provide hook to send lines more than
	998 symbols
Date: Fri, 21 Nov 2008 06:58:13 -0500
Message-ID: <20081121115813.GB3747@sigill.intra.peff.net>
References: <1227261564-13268-1-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 12:59:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Ufc-0003JL-L3
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 12:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbYKUL6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 06:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbYKUL6R
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 06:58:17 -0500
Received: from peff.net ([208.65.91.99]:4878 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663AbYKUL6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 06:58:16 -0500
Received: (qmail 28648 invoked by uid 111); 21 Nov 2008 11:58:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 21 Nov 2008 06:58:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Nov 2008 06:58:13 -0500
Content-Disposition: inline
In-Reply-To: <1227261564-13268-1-git-send-email-andy.shevchenko@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101513>

On Fri, Nov 21, 2008 at 11:59:24AM +0200, Andy Shevchenko wrote:

> By default git-send-email does not accept patch which is contain lines longer
> than 998 symbols. Sometime it's inconvenient, i.e. you have a long list in one
> variable in shell script. So, define environment variable
> GIT_SEND_EMAIL_LONGLINE to something to avoid that restriction.

This already exists as "git send-email --no-validate", which
unfortunately doesn't seem to be documented. Care to send in a
documentation patch instead?

-Peff
