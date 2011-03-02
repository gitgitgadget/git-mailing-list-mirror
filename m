From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git blame-tree
Date: Wed, 2 Mar 2011 12:40:56 -0500
Message-ID: <20110302174056.GB18957@sigill.intra.peff.net>
References: <20110302164031.GA18233@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 18:41:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Puq2q-0004Mc-2o
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 18:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869Ab1CBRk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 12:40:58 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43357 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755359Ab1CBRk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 12:40:58 -0500
Received: (qmail 19081 invoked by uid 111); 2 Mar 2011 17:40:57 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 02 Mar 2011 17:40:57 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2011 12:40:56 -0500
Content-Disposition: inline
In-Reply-To: <20110302164031.GA18233@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168327>

On Wed, Mar 02, 2011 at 11:40:32AM -0500, Jeff King wrote:

> It's sometimes useful to get a list of files in a tree along with the
> last commit that touched them. This is the default tree view shown on
> github.com...

A note on the motivation for this patch.

Some of you may already know this, but I started working full-time for
GitHub in January, working specifically on git. Most of it is just doing
the same general git work I've been doing; obviously GitHub has a vested
interest in git being awesome, and this gives me time to make it more
so.

I'm also working on changes that are going to be useful to large service
providers like GitHub more than other people. My plan is to open-source
those changes by putting them in a form that's useful to other git users
and submitting them as patches to the list.  This is the first example,
but I have one or two more so far (GitHub actually runs a surprisingly
stock git).

I wanted to mention it here because:

  1. GitHub is paying money for git development, which I think is cool
     and they deserve some credit. Having more git time, I'm hoping to
     tackle some of the long-standing issues that I have queued up
     (e.g., I'll probably be working on multi-file follow and better
     support for large binary files in the near future).

  2. I want to be very open about the background behind my patches. I
     think the list more-or-less operates on a per-patch meritocracy,
     so in theory the patches should stand on their own or not. But as a
     long-time contributor, I think it's best to be honest about the
     fact that my motivations aren't _just_ scratching my own itch
     anymore.

     I have more or less full autonomy with respect to how I spend my
     time, so there will still be a lot of itch-scratching. And if
     something is junk or not useful to non-GitHub users, I won't waste
     your time with it. So I think in general there won't be any change
     in the usefulness of my patches. But being open about it lets you
     choose how many grains of salt to take my patches with. :)

-Peff
