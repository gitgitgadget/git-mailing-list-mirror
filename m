From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git(1): remove a defunct link to "list of authors"
Date: Wed, 12 Dec 2012 07:24:48 -0500
Message-ID: <20121212122448.GA20057@sigill.intra.peff.net>
References: <7vobi5hhn9.fsf@alter.siamese.dyndns.org>
 <7vk3sthhfy.fsf@alter.siamese.dyndns.org>
 <CACsJy8A7AYpZs7mTc+B-F7BBLPdACim=gHCg8sK1Aci8YSEB4Q@mail.gmail.com>
 <7vboe2ct9p.fsf@alter.siamese.dyndns.org>
 <CACsJy8Dg1a0siDbiHtk4m1RhjLt-XKiS8kOO7qPKjwRczLF9vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 13:25:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TilN7-0001NX-5n
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 13:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650Ab2LLMYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 07:24:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42867 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561Ab2LLMYw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 07:24:52 -0500
Received: (qmail 23799 invoked by uid 107); 12 Dec 2012 12:25:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Dec 2012 07:25:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2012 07:24:48 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8Dg1a0siDbiHtk4m1RhjLt-XKiS8kOO7qPKjwRczLF9vA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211348>

On Mon, Dec 10, 2012 at 07:04:40PM +0700, Nguyen Thai Ngoc Duy wrote:

> > With or without "--no-merges", the big picture you can get out of
> > "git shortlog -s -n --since=1.year" does not change very much, but
> > the headline numbers give a wrong impression.
> 
> These numbers are approximate anyway. Commit counts or the number of
> changed lines do not accurately reflect the effort in many cases. And
> about merges, in this particular case of Git where the maintainer imo
> has done an excellent job as a guard, I'd say it's the credit for
> reviewing, not simply merging.

I agree that commit count is approximate. But counting merges is really
quite a large factor of error (in git.git, it more than doubles Junio's
count, and represents over 20% of the total number of commits).

The GitHub contributors page counts merges _and_ fails to use mailmap.
Yuck. I'm working on fixing that now.

> But not using the link is fine too. We can wait for Jeff's patch to be
> merged.

After the discussion in the PR, I am inclined to think the site (and
possibly the manpage) should just point to some decent contributors
graph (either GitHub, ohloh, or something else; suggestions welcome).
Anything else is just recreating a crappy static version of something
that could be much more dynamic and explorable.

I find the ohloh one a little more informative than the GitHub graph. I
couldn't find any others (Google Code does not seem to have one,
kernel.org and other gitweb sites do not, and I can't think of anywhere
else that hosts a mirror).

-Peff
