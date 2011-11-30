From: Jeff King <peff@peff.net>
Subject: Re: Uniform branch coloring
Date: Wed, 30 Nov 2011 01:55:40 -0500
Message-ID: <20111130065540.GD5317@sigill.intra.peff.net>
References: <CA+TMmK=476h1YyVcegWia2F+1bhOQyNLf-150qF1bnU8Wu3qJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nicolas Dudebout <nicolas.dudebout@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 07:55:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVe56-00076v-6U
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 07:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab1K3Gzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 01:55:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56002
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820Ab1K3Gzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 01:55:43 -0500
Received: (qmail 7812 invoked by uid 107); 30 Nov 2011 07:02:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Nov 2011 02:02:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2011 01:55:40 -0500
Content-Disposition: inline
In-Reply-To: <CA+TMmK=476h1YyVcegWia2F+1bhOQyNLf-150qF1bnU8Wu3qJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186109>

On Thu, Nov 17, 2011 at 02:08:38PM -0500, Nicolas Dudebout wrote:

> I was looking at the coloring of git branches in the output of
> different commands and had an idea.
> It seems to me that the color coding for branches should be uniform throughout.

That sounds like a reasonable goal. At the very least all of the spots
should be configurable, so you can make it uniform if you want to.

And then having unset config fallback to a "master" switch (e.g., if
color.branch.current is unset, use color.default.branch or whatever).
Which I think is close to what you write below.

> I have identified ways to address some of these problems:
> [...]

These all looked like reasonable goals to me. You will have to do a
little refactoring, I'm sure.

> What are your thoughts on that?

Go for it. Your ideas sound sane. You might hit some ugly complexities
in the implementation, but you won't know until you dig in and try. And
patches are much easier to review (and apply!) than ideas. :)

-Peff
