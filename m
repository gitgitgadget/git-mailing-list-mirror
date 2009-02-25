From: Jeff King <peff@peff.net>
Subject: Re: git push
Date: Wed, 25 Feb 2009 04:02:31 -0500
Message-ID: <20090225090230.GA15919@coredump.intra.peff.net>
References: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com> <7vskm3c84t.fsf@gitster.siamese.dyndns.org> <43d8ce650902242309nef12bd9j9088170b18cc8d4e@mail.gmail.com> <7v4oyjc64z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 10:04:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFgp-00014d-3A
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 10:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757472AbZBYJCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 04:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757379AbZBYJCl
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 04:02:41 -0500
Received: from peff.net ([208.65.91.99]:41894 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757106AbZBYJCk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 04:02:40 -0500
Received: (qmail 24830 invoked by uid 107); 25 Feb 2009 09:03:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Feb 2009 04:03:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Feb 2009 04:02:31 -0500
Content-Disposition: inline
In-Reply-To: <7v4oyjc64z.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111415>

On Tue, Feb 24, 2009 at 11:44:44PM -0800, Junio C Hamano wrote:

> > Presumably the obvious is that it might be confusing to existing
> > users?  Perhaps, but it doesn't cause any damage.  It's moving to a
> > 'safer' default.
> 
> No, it is not merely confusing but is outright dangerous to people who
> expect the "matching refs" behaviour.  It is not safer at all.

I think this is a very good reason not to change the default "push"
behavior.

> And this is not about punishing.  It is about getting into a different
> mindset.  Unlike CVS/SVN, committing and publishing can be made into
> different phases with git, and not pushing too early allows you produce a
> lot better results.  "I want to push only this branch" is often (not
> always, but "often" stands with strong correlation) a sign that other
> things are not ready, and by definition you couldn't have thought through
> interactions between what you _think_ is ready (i.e. the current branch)
> and the other ones that are not ready.  In other words, it is about
> encouraging people to think things through before publishing.

But I don't buy this at all. It is totally dependent on workflow and how
you use branches. That is, the "readiness" of two branches may be
totally unrelated. One may be a short-term branch for today's work, and
the other may be a long-running branch that you have made a WIP commit
on. You may even have that WIP commit sitting there for days.

When you think about "is my current branch ready to push?" there is no
reason for you to think of that other long-running branch that you
haven't seen for days.

-Peff
