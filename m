From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-cherry: add color to the output
Date: Sun, 4 May 2008 23:27:18 -0400
Message-ID: <20080505032718.GA15498@sigill.intra.peff.net>
References: <1209751304-25304-1-git-send-email-richard.quirk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Richard Quirk <richard.quirk@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 05:28:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsrNG-0004bT-TL
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 05:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbYEED1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 23:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbYEED1T
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 23:27:19 -0400
Received: from peff.net ([208.65.91.99]:4597 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbYEED1T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 23:27:19 -0400
Received: (qmail 23544 invoked by uid 111); 5 May 2008 03:27:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 04 May 2008 23:27:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 May 2008 23:27:18 -0400
Content-Disposition: inline
In-Reply-To: <1209751304-25304-1-git-send-email-richard.quirk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81218>

On Fri, May 02, 2008 at 08:01:44PM +0200, Richard Quirk wrote:

> If color.diff is set then patches not yet cherry-picked are marked green
> and already picked ones are marked red. This makes it easier to tell at a
> glance which changes have not been cherry-picked.

I don't actually use git-cherry, so I can't say whether this is useful
or not. But I wonder if it should follow the trend of other color
options and get its own color.cherry variable, but also be controlled by
the master color.ui.

-Peff
