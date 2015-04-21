From: Jeff King <peff@peff.net>
Subject: Re: Regular Rebase Failure
Date: Tue, 21 Apr 2015 17:15:20 -0400
Message-ID: <20150421211519.GA13230@peff.net>
References: <553685E0.8010304@gmail.com>
 <CAGZ79kadXgsdCLH-YFQ5RhyKbRv9-qmUOQo-9QkKM2=8p17j+g@mail.gmail.com>
 <55369509.2080200@gmail.com>
 <CAGZ79kY0pbC6qH+Refm8Py0PyF2xNMLfSarhA+3-7eaU==RK7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam <adamgsteel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 23:15:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkfW1-0005s6-SV
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 23:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328AbbDUVP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 17:15:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:48283 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756265AbbDUVPX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 17:15:23 -0400
Received: (qmail 4778 invoked by uid 102); 21 Apr 2015 21:15:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Apr 2015 16:15:22 -0500
Received: (qmail 4694 invoked by uid 107); 21 Apr 2015 21:15:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Apr 2015 17:15:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Apr 2015 17:15:20 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kY0pbC6qH+Refm8Py0PyF2xNMLfSarhA+3-7eaU==RK7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267554>

On Tue, Apr 21, 2015 at 11:34:37AM -0700, Stefan Beller wrote:

> [+mailing list]
> 
> On Tue, Apr 21, 2015 at 11:20 AM, Adam <adamgsteel@gmail.com> wrote:
> > I'm using git version 2.3.2 (Apple Git-55).
> 
> We should loop in the maintainers of the Apple Git version, they'd know
> what changed in git about two weeks ago.
> I have no idea who that is though.

You can get some releases from:

  http://www.opensource.apple.com/tarballs/Git/

and at least view the diff against stock git. But they do not seem to
have updated that in some time (the latest release is Apple Git-48,
based off of v1.8.5.2).

It would be nice if they kept that up to date (actually not just nice,
but required by the GPL[1]). It would be nicer still if they actually
published their patches with real commit messages, or better yet
actually engaged with upstream to work on fixes or enhancements.

This isn't strictly relevant to the discussion at hand, but in case any
Apple Git folks do see this, perhaps it will serve as a gentle nudge.

-Peff

[1] By the GPL, they don't strictly need to publish the source; they
    just have to make an offer to provide it on request. But given the
    existence of opensource.apple.com, I think their strategy is to just
    publish everything, and they have simply let updating that site fall
    behind the binaries they are pushing. Or maybe they have switched to
    an alternate site that I don't know about.
