From: Jeff King <peff@peff.net>
Subject: Re: Git documentation at kernel.org
Date: Sun, 12 Feb 2012 19:30:24 -0500
Message-ID: <20120213003024.GA25794@sigill.intra.peff.net>
References: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com>
 <20120208213410.GA5768@ecki>
 <7vmx8rtu3e.fsf@alter.siamese.dyndns.org>
 <20120210200401.GB5504@sigill.intra.peff.net>
 <vpqehtz909k.fsf@bauges.imag.fr>
 <20120212222508.GA25619@sigill.intra.peff.net>
 <CAP2yMa+2E6101fe3Z2WTCfuGnq17WT7nDUQr7PVH6_YKRnNifw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, ftpadmin@kernel.org,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 01:30:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwjoN-0002LT-RK
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 01:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068Ab2BMAa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 19:30:27 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34182
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757Ab2BMAa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 19:30:26 -0500
Received: (qmail 26237 invoked by uid 107); 13 Feb 2012 00:37:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 12 Feb 2012 19:37:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Feb 2012 19:30:24 -0500
Content-Disposition: inline
In-Reply-To: <CAP2yMa+2E6101fe3Z2WTCfuGnq17WT7nDUQr7PVH6_YKRnNifw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190596>

On Sun, Feb 12, 2012 at 03:04:59PM -0800, Scott Chacon wrote:

> > Good point. That is probably the best place to host it.
> >
> > As far as historical reasons, perhaps the right answer is to put the
> > documentation where it makes sense to go _now_, and ask kernel.org to
> > issue http redirects for http://kernel.org/pub/software/scm/git/docs.
> 
> I would be happy to set this up.  I'm currently in the process of
> revamping the website and this is one of the things I'm planning on
> doing anyways - not just hosting the generated docs, but also making
> them searchable and whatnot.

That sounds great to me. I'd like to be link-compatible with the old
kernel.org docs section (even if through redirects) so that old links
work (assuming kernel.org gives us a wholesale redirect).  Which means
importing all of the docs for released versions. I don't know if the old
kernel.org doc tree was saved anywhere, but if I understand correctly,
they are identical to what's in the "git-htmldocs" repository (which I
_thought_ Junio wasn't going to keep updating, but it seems pretty up to
date).

> Actually, as long as I'm on this, what do people think about git-scm
> hosting the wiki as well?  As far as I can tell, it was down for
> months and now it's back in some sort of weird read-only state.  If I
> imported everything into a different wiki and hosted it on git-scm
> would that be acceptable?

I'd really love it if the wiki was converted to something that was
git-backed. But I suspect some people might complain about switching off
of mediawiki. IIRC, gollum supports some mediawiki syntax, but I don't
know how much conversion work there would be.

> Also, something that I realized I am not willing to maintain any more
> is the Git Community Book. It was an experiment at reorganizing some
> of the docs, but instead I spent my time on Pro Git, which is CC
> licensed.  Would anyone object to me removing the community book from
> the git-scm site and more tightly integrating the Pro Git content?
> It's more up to date and better content, I feel - I would rather have
> one book to maintain than two.  However, since it is a commercial
> product (albeit a Creative Commons licensed one), I wasn't sure if
> people would have an issue with it.

I can't remember anybody mentioning the Git Community Book here in the
past few years. New users typically come with a "I read this in Pro Git
and I don't understand..." question, and experienced users recommend or
link to Pro Git. So I think the world would be a less confusing place
with just the one source.

-Peff
