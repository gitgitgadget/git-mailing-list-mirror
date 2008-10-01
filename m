From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Wed, 1 Oct 2008 11:18:01 -0400
Message-ID: <20081001151800.GA4962@coredump.intra.peff.net>
References: <7vzlmkpltb.fsf@gitster.siamese.dyndns.org> <20080921104238.GA9217@sigill.intra.peff.net> <A36A4B61-D223-4821-9969-FA76EAECD1EC@ai.rug.nl> <20080929224430.GA11545@sigill.intra.peff.net> <48E1C39F.4070906@op5.se> <836C204F-F5AF-4887-99C9-04E70FEEB998@wincent.com> <20080930070938.GA14757@sigill.intra.peff.net> <48E1F87D.2010906@op5.se> <20081001031400.GA24513@coredump.intra.peff.net> <48E3312E.4090601@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Wincent Colaiuta <win@wincent.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Oct 01 17:19:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl3Tw-0006h9-4W
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 17:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbYJAPSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 11:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753168AbYJAPSF
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 11:18:05 -0400
Received: from peff.net ([208.65.91.99]:2842 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752984AbYJAPSE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 11:18:04 -0400
Received: (qmail 19261 invoked by uid 111); 1 Oct 2008 15:18:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 01 Oct 2008 11:18:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Oct 2008 11:18:01 -0400
Content-Disposition: inline
In-Reply-To: <48E3312E.4090601@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97234>

On Wed, Oct 01, 2008 at 10:13:34AM +0200, Andreas Ericsson wrote:

> Me too, but I thought it up after I sent out the first patch. The nicest
> part is that the info that's always present will always end up in the
> same place, while my patch moves the branch-name around depending on
> the length of the subject line.
>
> Let's agree here and now that the subject should be last and that "commit "
> should be dropped, at least for the normal cases.

Yes, I agree that those are the most important aspects, and the rest of
it is just minor formatting details.

> A valid concern, certainly. We needn't use colons for the branch-name
> though, but could instead use some other delimiter, like this:
> [<branch>] Created <hash>: "subject line..."
> although I do believe we're close to nitpicking this issue to death
> now. It's not *that* important after all.

Heh. Yes, I feel a little silly discussing this so much. But it probably
is _the_ most frequently seen informational message in git. So not only
does it affect new users' perception of git, but I have to see it every
day. ;)

> I don't quite like the fact that you're removing the "detached" thingie.
> I have coworkers that have been bitten by committing on detached head,
> so I'd like to have some mention of it. I'll rework it to take that
> into account. Otherwise, this looks good. Less code is always a good
> thing, imo.

I thought the all-caps "HEAD" instead of the branch name would make it
stand out. But given that it isn't the common case, I don't think it is
the end of the world to spend a little more screen real estate
mentioning it.

I am ready to bikeshed the next patch you produce. ;)

-Peff
