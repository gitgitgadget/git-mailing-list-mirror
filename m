From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7300: mark test with SANITY
Date: Tue, 3 May 2016 17:35:56 -0400
Message-ID: <20160503213556.GA25133@sigill.intra.peff.net>
References: <1462301672-20866-1-git-send-email-sbeller@google.com>
 <20160503190417.GD30530@sigill.intra.peff.net>
 <xmqqmvo7lz5f.fsf@gitster.mtv.corp.google.com>
 <20160503211528.GA32737@sigill.intra.peff.net>
 <xmqqk2jalu03.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Roberto Tyley <roberto.tyley@gmail.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	janx@linux.com, Lars Schneider <larsxschneider@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 23:36:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axhzA-00086Y-CM
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 23:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547AbcECVgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 17:36:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:33452 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756430AbcECVf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 17:35:59 -0400
Received: (qmail 29372 invoked by uid 102); 3 May 2016 21:35:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 17:35:58 -0400
Received: (qmail 2327 invoked by uid 107); 3 May 2016 21:36:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 17:36:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 May 2016 17:35:56 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2jalu03.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293462>

On Tue, May 03, 2016 at 02:19:24PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Maybe. I admit to not really using the Travis tests myself, as they are
> > way too slow and cumbersome to debug compared to just running "make
> > test".  The primary value to me of centralized CI is:
> >
> >   1. _If_ people are looking at PRs on GitHub, the test status is shown
> >      right there in the PR, without a reviewer having to wonder whether
> >      the submitter ran "make test". But since I don't ever look at PRs
> >      for Git, that's not helpful.
> 
> What I was hoping was that bots like SubmitGit could look at that
> status.

Yeah, I think that would be pretty trivial to do. It's already
interacting with GitHub's API, and I think there's a simple call to
query the test status (so it wouldn't even require SubmitGit talking to
Travis directly).

I don't think that really solves the problem overall, though. SubmitGit
is still a minority of patch submissions (and I wouldn't expect that to
change, but maybe I'm just a curmudgeon).

-Peff
