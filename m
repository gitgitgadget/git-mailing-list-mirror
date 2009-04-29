From: Jeff King <peff@peff.net>
Subject: Re: Cross-Platform Version Control (was: Eric Sink's blog - notes
	on git, dscms and a "whole product" approach)
Date: Wed, 29 Apr 2009 03:21:05 -0400
Message-ID: <20090429072105.GD22593@coredump.intra.peff.net>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3r5zdnhqu.fsf@localhost.localdomain> <46a038f90904282355g43bf0cv909905f6028f054f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 09:21:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz46x-0007ip-8p
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 09:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbZD2HVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 03:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752219AbZD2HVJ
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 03:21:09 -0400
Received: from peff.net ([208.65.91.99]:60960 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbZD2HVI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 03:21:08 -0400
Received: (qmail 3251 invoked by uid 107); 29 Apr 2009 07:21:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 29 Apr 2009 03:21:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2009 03:21:05 -0400
Content-Disposition: inline
In-Reply-To: <46a038f90904282355g43bf0cv909905f6028f054f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117859>

On Wed, Apr 29, 2009 at 08:55:29AM +0200, Martin Langhoff wrote:

> So from Eric's perspective, it is worthwhile to work on all those
> issues, and get the right for the end user -- support things we don't
> like, offer foolproof catches and warnings that prevent the user from
> shooting their lovely toes off to mars, etc.

I read a few of his blog postings. He kept complaining about the
features of git that I like the most. :)

So one thing I took away from it is that there probably isn't _one_
interface that works for everybody. I can see his arguments about how
"add -p" can be dangerous, and how history rewriting can be dangerous.
So for some users, blocking those features makes sense.

But for other users (myself included), those are critical features that
make me _way_ more productive. And I manage the risk that comes from
using them as part of my workflow, and it isn't a problem in practice.

While part of me is happy that cogito is now dead (not because I didn't
think it was good, but because having two sets of tools just seemed to
create maintenance and staleness headaches), I do sometimes wonder if we
would be better off with several "from scratch" git interfaces based
around the plumbing (or even a C library). And I don't just mean simple
wrappers around git commands, but whole new interfaces which make
decisions like "no history rewriting at all", and try to provide a safer
interface based on that.

Of course, _I_ wouldn't want to use such an interface. But in theory I
could seamlessly interoperate with people who did.

-Peff
