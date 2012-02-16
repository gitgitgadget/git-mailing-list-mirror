From: Jeff King <peff@peff.net>
Subject: Re: importance of .git extension for bare repos
Date: Wed, 15 Feb 2012 21:30:27 -0500
Message-ID: <20120216023027.GA26518@sigill.intra.peff.net>
References: <jhhkn8$a0t$1@dough.gmane.org>
 <CALUzUxqEirjnCBHt28dwcgTBqC+u0wydNsnVR1rgyGG0-R_M1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 03:30:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxr7D-0006r5-Bu
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 03:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756818Ab2BPCab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 21:30:31 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37398
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756333Ab2BPCaa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 21:30:30 -0500
Received: (qmail 26195 invoked by uid 107); 16 Feb 2012 02:37:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Feb 2012 21:37:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2012 21:30:27 -0500
Content-Disposition: inline
In-Reply-To: <CALUzUxqEirjnCBHt28dwcgTBqC+u0wydNsnVR1rgyGG0-R_M1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190872>

On Thu, Feb 16, 2012 at 09:38:08AM +0800, Tay Ray Chuan wrote:

> I don't believe its significant to git itself, it's just a convention
> for us humans.

That's not entirely true. If you try to access a repository by name
(e.g., "git clone foo", "git fetch foo"), git will look for "foo.git".
This magic lookup works for local repositories, and for remote
repositories served over ssh or by git-daemon. I think it should also
work for smart-http, but I didn't check. It doesn't work for dumb http
(because it would involve making several exploratory http requests).

-Peff
