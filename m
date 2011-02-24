From: Jeff King <peff@peff.net>
Subject: Re: Why doesn't git commit -a track new files
Date: Thu, 24 Feb 2011 10:49:08 -0500
Message-ID: <20110224154908.GA29309@sigill.intra.peff.net>
References: <20110224112246.3f811ac2@glyph>
 <4D6672F7.4020101@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marco <netuse@lavabit.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 16:49:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsdRL-00077o-PP
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 16:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237Ab1BXPtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 10:49:11 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53950 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754972Ab1BXPtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 10:49:09 -0500
Received: (qmail 24451 invoked by uid 111); 24 Feb 2011 15:49:08 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 15:49:08 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 10:49:08 -0500
Content-Disposition: inline
In-Reply-To: <4D6672F7.4020101@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167824>

On Thu, Feb 24, 2011 at 04:02:15PM +0100, Michael J Gruber wrote:

> "commit -A" does not exist, so that "git add -A && git commit" is your
> only way.
>
> [...]
>
> Also, "-A" supports a very "un-gitty" way of using git. This makes it
> unlikely that someone cares to implement it... (By "un-gitty" I don't
> mean a matter of personal taste, but a matter of fruitful habits.)

Actually, I would find "git commit -A" useful. Not as part of my normal
project workflow, but would be a great shorthand for one-off debuggings
(e.g., "echo content >>file && git commit -A -m msg", which Just Works
whether it is the first or a later commit).

But as you mentioned, it is sadly not as trivial as just adding a new
way to call "git add". So I think nobody has simply cared enough to
implement it to date.

-Peff
