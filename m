From: Jeff King <peff@peff.net>
Subject: Re: Push from an SSH Terminal
Date: Fri, 3 Feb 2012 17:13:24 -0500
Message-ID: <20120203221324.GA8048@sigill.intra.peff.net>
References: <CAG94OYxX5foffvaFLQv7=wXguGC2TLgccdDFrC+ERzv_gXZ=ug@mail.gmail.com>
 <21607.38.96.167.131.1328286083.squirrel@mail.lo-cal.org>
 <CAG94OYxbOYCjd5qNBh8EF2gyezHWMqX1-R2MYgk8gkFYcrMjuQ@mail.gmail.com>
 <34592.38.96.167.131.1328289027.squirrel@mail.lo-cal.org>
 <20120203213654.GD1890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Feanil Patel <feanil@gmail.com>, git@vger.kernel.org
To: Neal Groothuis <ngroot@lo-cal.org>
X-From: git-owner@vger.kernel.org Fri Feb 03 23:13:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtRNr-0006eW-GA
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 23:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756704Ab2BCWN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 17:13:27 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56051
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595Ab2BCWN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 17:13:26 -0500
Received: (qmail 2826 invoked by uid 107); 3 Feb 2012 22:20:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Feb 2012 17:20:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2012 17:13:24 -0500
Content-Disposition: inline
In-Reply-To: <20120203213654.GD1890@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189814>

On Fri, Feb 03, 2012 at 04:36:54PM -0500, Jeff King wrote:

> > Check to see if the GIT_ASKPASS and/or SSH_ASKPASS environment variables
> > are set, and if the core.askpass config variable is set.  If any of these
> > are set, unset them.  Git should fall back to a simple password prompt.
> 
> Hmm, yeah that is likely the problem. I was thinking git would fall back
> to asking on the terminal, but it does not. We probably should.

We should probably do this:

  [1/2]: prompt: clean up strbuf usage
  [2/2]: prompt: fall back to terminal if askpass fails

-Peff
