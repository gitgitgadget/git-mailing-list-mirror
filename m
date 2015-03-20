From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 26/27] t/*svn*: fix moderate &&-chain breakage
Date: Fri, 20 Mar 2015 16:02:39 -0400
Message-ID: <20150320200239.GA25506@peff.net>
References: <550C2E7B.3030203@drmicha.warpmail.net>
 <317e6b1e70f3e1c50d62207c53f4d038ad027c9d.1426861743.git.git@drmicha.warpmail.net>
 <xmqqy4mree9x.fsf@gitster.dls.corp.google.com>
 <xmqqh9tfea1v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 21:02:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ382-0007LC-B8
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 21:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbbCTUCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 16:02:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:36142 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750999AbbCTUCl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 16:02:41 -0400
Received: (qmail 753 invoked by uid 102); 20 Mar 2015 20:02:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 15:02:41 -0500
Received: (qmail 28118 invoked by uid 107); 20 Mar 2015 20:02:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 16:02:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 16:02:39 -0400
Content-Disposition: inline
In-Reply-To: <xmqqh9tfea1v.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265961>

On Fri, Mar 20, 2015 at 12:35:56PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Michael J Gruber <git@drmicha.warpmail.net> writes:
> >
> >> All of these cases are moderate since they would most probably not
> >> lead to missed failing tests: Either they would fail otherwise,
> >> or fail a rm in test_when_finished only.
> >>
> >> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> >> ---
> >>  t/t2026-prune-linked-checkouts.sh |  4 ++--
> >>  t/t9158-git-svn-mergeinfo.sh      |  4 ++--
> >>  t/t9161-git-svn-mergeinfo-push.sh | 10 +++++-----
> >>  3 files changed, 9 insertions(+), 9 deletions(-)
> >
> > Ahh, it seems that I should have read everything in my inbox before
> > starting my day X-<.  I already queued an identical patch for 2026
> > on nd/multiple-work-trees, and its new tip is in 'next' now.
> >
> > Which branches are the git-svn ones meant to apply?  Are they meant
> > to fix an existing bug already in master, or are they new ones added
> > by still-in-flight topics?  Can you split if necessary and mark them
> > for individual topios in flight if that is the case, so that we can
> > apply them independently from GIT_TEST_CHAIN_LINT series?
> >
> > Thanks.
> 
> OK, I think I figured it out.  All the git-svn bits in 26 and 27 are
> for 'master', and should be part of Peff's original 25-patch series.
> I'll drop 2026 from your 26/25 and queue it together with your 27/25
> on top off it.

Yeah, that was my impression, too. I don't have svn installed on my
system, so I missed those ones. I don't have CVS either. That might be
worth following up on.

-Peff
