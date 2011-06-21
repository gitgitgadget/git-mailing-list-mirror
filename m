From: Jeff King <peff@peff.net>
Subject: Re: git checkout running very slowly (>12s)
Date: Mon, 20 Jun 2011 20:44:52 -0400
Message-ID: <20110621004452.GA3064@sigill.intra.peff.net>
References: <loom.20110615T213016-856@post.gmane.org>
 <4DF9363F.6080009@op5.se>
 <loom.20110616T010709-333@post.gmane.org>
 <loom.20110620T221426-685@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andrew Cameron <andrew@worksmartlabs.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 02:45:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYp5Q-0002BP-DR
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 02:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756362Ab1FUAoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 20:44:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41293
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756231Ab1FUAoy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 20:44:54 -0400
Received: (qmail 29868 invoked by uid 107); 21 Jun 2011 00:45:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jun 2011 20:45:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2011 20:44:52 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110620T221426-685@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176117>

On Mon, Jun 20, 2011 at 08:26:37PM +0000, Andrew Cameron wrote:

> In other words, it appears that an efficient lstat implementation was not the 
> key factor in this problem.  The root cause remains a mystery, but in my case, 
> the solution was to upgrade Git.

If you can reliably trigger the problem by switching versions and you
are still curious and want to spend a little more time on it, you may be
able to bisect the fix to solve the mystery.

Keep in mind that you are bisecting a fix, not a regression, so your
meanings of "good" and "bad" will be opposite of what you expect. I.e.,
"bad" commits will have the fix, and "good" commits will not (I know
this is confusing; it's an artifact of the way bisect works).

-Peff
