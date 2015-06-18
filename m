From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight
 unevenly-sized hunks
Date: Thu, 18 Jun 2015 15:08:42 -0400
Message-ID: <20150618190841.GB12769@peff.net>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx>
 <xmqqwpz1f22b.fsf@gitster.dls.corp.google.com>
 <CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Patrick Palka <patrick@parcs.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jun 18 21:08:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5fBC-0006p5-7X
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 21:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756538AbbFRTIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 15:08:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:48296 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752753AbbFRTIo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 15:08:44 -0400
Received: (qmail 21616 invoked by uid 102); 18 Jun 2015 19:08:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 14:08:44 -0500
Received: (qmail 6531 invoked by uid 107); 18 Jun 2015 19:08:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 15:08:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jun 2015 15:08:42 -0400
Content-Disposition: inline
In-Reply-To: <CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272034>

On Thu, Jun 18, 2015 at 12:28:58PM -0400, Patrick Palka wrote:

> By the way, what would it take to get something like this script into
> git proper?  It is IMHO immensely useful even in its current form, yet
> because it's not baked into the application hardly anybody knows about
> it.

I think if we were going to make it more official, it would make sense
to do it inside the diff code itself (i.e., not as a separate script),
and it might be reasonable at that point to actually do a "real"
character-based diff rather than the hacky prefix/suffix thing (or
possibly even integrate with the color-words patterns to find
syntactically interesting breaks). There is some discussion in the
"Bugs" section of contrib/diff-highlight/README.

-Peff
