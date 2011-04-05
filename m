From: Jeff King <peff@peff.net>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Tue, 5 Apr 2011 13:07:30 -0400
Message-ID: <20110405170729.GC9965@sigill.intra.peff.net>
References: <201103260141.20798.robert.david.public@gmail.com>
 <20110328142121.GB14763@sigill.intra.peff.net>
 <201103301739.12691.trast@student.ethz.ch>
 <201104040943.10030.robert.david.public@gmail.com>
 <7vwrj999dv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robert David <robert.david.public@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 19:07:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q79j8-0005pK-Ps
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 19:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488Ab1DERHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 13:07:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41166
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996Ab1DERHd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 13:07:33 -0400
Received: (qmail 25827 invoked by uid 107); 5 Apr 2011 17:08:19 -0000
Received: from 205.158.58.41.ptr.us.xo.net (HELO sigill.intra.peff.net) (205.158.58.41)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Apr 2011 13:08:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Apr 2011 13:07:30 -0400
Content-Disposition: inline
In-Reply-To: <7vwrj999dv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170891>

On Mon, Apr 04, 2011 at 11:09:00AM -0700, Junio C Hamano wrote:

> Robert David <robert.david.public@gmail.com> writes:
> 
> > 1) Pre-coding time
> > 2) 1-3 week
> > 3) 4-5 week
> > 4) 6-7 week
> > 5) 8-11 week
> > Extend the C code to the state it should be.
> > Adopt other git commands to work with the new interface correctly.
> > Test extensively.
> > Update documentation where needed.
> >
> > 6) 12 week
> > Write more documentation, to document what was done and how.
> > Correct bugs and test.
> 
> I am afraid to say that the above schedule is too ambitious and does not
> leave any time for reviews and re-rolls.  Please keep in mind that
> historically patch series by more experienced contributors of substantial
> size (comparable or even smaller scale than the topic you are proposing)
> all typically took three or four review-reroll cycles, if not less, and we
> don't automatically get extra review bandwidth just because GSoC is going
> on.

I agree. I think it's important to take review-reroll cycles into
account. Not just in terms of allocating time, but also considering the
latency, and keeping the student's pipeline full of work while waiting
on review.

To that end, I think it's useful to break the problem up as much as
possible, and feed chunks to the list as quickly as possible. Even if
you end up with something like:

  Week 2: send refactoring of functionality X
  Week 3: build new functionality Y on top of X

Obviously "Y" is going to depend somewhat on the refactoring of "X". But
you can say in the RFC/PATCH for Y that X is still ongoing, and to
review with that in mind. And that keeps the student doing something
during week 3 while reviews for X flow in.

In the past, students haven't been very engaged with the list community,
and I think that has hurt us. The code gets dumped as a whole at the
end, and review is a lot harder, and GSoC is over, so the student ends
up busy with going back to school. And the student never really learns
the "normal" way that contributors interact with the community, which
makes them less likely to become long-time contributors.

So I'd really like to see this year's projects breaking contributions
into smaller, reviewable bits and submitting over the course of the
whole summer.

> I am starting to suspect that it might make sense to say "as far as GSoC
> participation is concerned, we would call a topic "merged upstream" when
> it hits 'next', even if it is not ready for 'master' at the end of the
> term".

Yeah, I think that is reasonable. Stuff that makes it into "next" is
usually of good quality, but just needs time to shake out bugs. Every
once in a while we find that something in next turns out be utter crap,
but usually it is obvious before it even gets merged there. Hopefully a
student will be available to fix minor bugs as the topic cooks in next,
but if not, it is probably something the mentor can do.

-Peff
