From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] tests: use "git xyzzy" form
Date: Wed, 3 Sep 2008 16:59:45 -0400
Message-ID: <20080903205945.GA32413@coredump.intra.peff.net>
References: <20080903175925.6117@nanako3.lavabit.com> <48BE6D1F.1060603@op5.se> <7v8wu9athn.fsf@gitster.siamese.dyndns.org> <7vwsht9cw5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 23:00:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KazTC-0007qA-Fa
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 23:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbYICU7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 16:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753673AbYICU7s
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 16:59:48 -0400
Received: from peff.net ([208.65.91.99]:4751 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753631AbYICU7r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 16:59:47 -0400
Received: (qmail 32746 invoked by uid 111); 3 Sep 2008 20:59:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Sep 2008 16:59:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Sep 2008 16:59:45 -0400
Content-Disposition: inline
In-Reply-To: <7vwsht9cw5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94853>

On Wed, Sep 03, 2008 at 01:45:46PM -0700, Junio C Hamano wrote:

> Doing this _carefully_ (otherwise the result would be useless) must have
> been quite a lot of effort, and what was posted seems to have been done
> quite carefully.

Yes, thank you Nanako. After complaining about it to Junio, I expected I
would have to be the one to do it. But procrastination pays off once
again...

> The cross-checking I did with "grep" in this message does *not* catch if
> you converted something that shouldn't have been converted (e.g. changing
> the pathname ".git/rebase-merge/git-rebase-todo" to "git rebase-todo"
> would have been a disaster).  It needs real eyeballing of the patches
> themselves to catch such an error, and we would need help from people.

When I did this the last time, I recall that most of the errors of that
sort tended to make the test fail loudly. So that is a point in our
favor. However, I agree that eyeballing is a good strategy here.

I just checked 1/4, which looks fine. Made much easier by the use of
--color-words (even easier with -U0, but sometimes the context is
helpful for seeing that it is correct).

In 2/4, we change some instances of git-upload-pack, which you otherwise
mentioned in your "should be left". It's in t5530 and t5602. Otherwise
looks fine.

-Peff
