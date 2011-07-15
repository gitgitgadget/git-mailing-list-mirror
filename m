From: Jeff King <peff@peff.net>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 16:07:13 -0400
Message-ID: <20110715200713.GA969@sigill.intra.peff.net>
References: <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <20110714190844.GA26918@sigill.intra.peff.net>
 <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net>
 <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net>
 <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
 <20110715074656.GA31301@sigill.intra.peff.net>
 <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
 <20110715194807.GA356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 22:07:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhofS-0005H9-Od
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 22:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884Ab1GOUHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 16:07:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51710
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754454Ab1GOUHP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 16:07:15 -0400
Received: (qmail 26162 invoked by uid 107); 15 Jul 2011 20:07:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jul 2011 16:07:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2011 16:07:13 -0400
Content-Disposition: inline
In-Reply-To: <20110715194807.GA356@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177222>

On Fri, Jul 15, 2011 at 03:48:07PM -0400, Jeff King wrote:

> OK, so let's say we add generation headers to each commit. What happens
> next? Are we going to convert algorithms that use timestamps to use
> commit generations? How are we going to handle performance issues when
> dealing with older parts of history that don't have generations?
> 
> Again, those are serious questions that need answered. I respect that
> you think the lack of a generation header is a design decision that
> should be corrected. As I said before, I'm not 100% sure I agree, but
> nor do I completely disagree (and I think it largely boils down to a
> philosophical distinction, which I think you will agree should take a
> backseat to real, practical concerns). But it's not 2005, and we have a
> ton of history without generation numbers. So adding them now is only
> one piece of the puzzle.
> 
> What's your solution for the rest of it?

I just read some of your later emails to others in the thread. It seems
like your answer is "assume the timestamp-based limiting is good enough
for old history".

I'm OK with that. It obviously falls down in a few specific situations,
but certainly has not been an unbearable problem for the past 5 years.

-Peff
