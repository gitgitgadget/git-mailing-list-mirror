From: Jeff King <peff@github.com>
Subject: Re: Histogram diff, libgit2 enhancement, libgit2 => git merge (GSOC)
Date: Sun, 20 Mar 2011 19:44:20 -0400
Message-ID: <20110320234420.GA1919@sigill.intra.peff.net>
References: <op.vsm1yszq2m56ex@localhost.localdomain>
 <AANLkTi=Fu5v-5E2dSAA74f0juUQNjNjus5XFWqMb9v9k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pavel Raiskup <xraisk00@gmail.com>, git@vger.kernel.org
To: Vicent Marti <vicent@github.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 00:51:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1SPV-0005sU-Uq
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 00:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab1CTXvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 19:51:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45235
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832Ab1CTXvo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 19:51:44 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Mar 2011 19:51:44 EDT
Received: (qmail 4959 invoked by uid 107); 20 Mar 2011 23:44:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 20 Mar 2011 19:44:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Mar 2011 19:44:20 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=Fu5v-5E2dSAA74f0juUQNjNjus5XFWqMb9v9k@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169536>

On Sun, Mar 20, 2011 at 11:01:25PM +0200, Vicent Marti wrote:

> b) Write a minimal Git client using libgit2. Peff keeps bringing this
> up and I think it's a bangin' good idea. Write something small and
> 100% self contained in a C executable that runs everywhere with 0
> dependencies -- don't aim for full feature completion, just the basic
> stuff to interoperate with a Git repository. Clone, checkout, branch,
> commit, push, pull, log. I would totally use that shit on my Windows
> boxes. And since it'll be externally compatible with the original Git
> client, we can reuse the Git unit tests to test libgit2. HA. Awesome!

Yeah, I would be happy to mentor or co-mentor with Vicent on a project
like that. Not only might it be useful to actually _use_, but my secret
motive is that I'd like to start testing libgit2 using some of the
regular git tests, both for interoperability and for performance.

-Peff
