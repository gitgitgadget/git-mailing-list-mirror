From: Jeff King <peff@peff.net>
Subject: Re: git-subtree Ready #2
Date: Mon, 27 Feb 2012 16:21:57 -0500
Message-ID: <20120227212157.GA19779@sigill.intra.peff.net>
References: <87ty2ro1zf.fsf@smith.obbligato.org>
 <20120220205346.GA6335@sigill.intra.peff.net>
 <7vd399jdwc.fsf@alter.siamese.dyndns.org>
 <CAHqTa-2s1xbAfNvjD7cXBe2TBMs1985nag1NOYVfE+dATvfEWA@mail.gmail.com>
 <7vobsox84l.fsf@alter.siamese.dyndns.org>
 <CAHqTa-1fbi5W7R2fLu3bp7Yuv_ZB9nxhgjHkLGuU8-V4016+JA@mail.gmail.com>
 <87hayfv75y.fsf@smith.obbligato.org>
 <7vy5rrfft2.fsf@alter.siamese.dyndns.org>
 <87ty2ft0tm.fsf@smith.obbligato.org>
 <7vobsk56md.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "David A. Greene" <greened@obbligato.org>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 22:22:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S281a-0007a6-8j
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 22:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab2B0VWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 16:22:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59046
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755339Ab2B0VV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 16:21:59 -0500
Received: (qmail 32382 invoked by uid 107); 27 Feb 2012 21:22:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Feb 2012 16:22:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2012 16:21:57 -0500
Content-Disposition: inline
In-Reply-To: <7vobsk56md.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191674>

On Mon, Feb 27, 2012 at 01:06:02PM -0800, Junio C Hamano wrote:

> >>> I'm happy to do either (rebase or filter-branch).  Just let me know.
> >>
> >> I would understand Avery's "should we filter-branch/rebase, or is it OK
> >> as-is?", but I do not understand what you mean by "either rebase or
> >> filter-branch is fine".
> >
> > Sorry, got mixed up there.  I'm not that familiar with filter-branch.
> > Now I understand you do both.  :)
> >
> > So have we decided to keep the history?
> 
> I think the discussion so far was:
> 
>  - Peff suggested to keep the history with a true merge;
> 
>  - I said the history before the final commit in Avery's tree did not look
>    so useful for future archaeology; and then
> 
>  - Avery corrected me that there are contributions by other people and the
>    credits will be lost if we discarded the history;
> 
> and everybody (including me) now favors to have the history.
> 
> So the answer to your question is yes, but I do not think we heard opinion
> from anybody regarding the question by Avery yet.  I personally do not see
> how it would help us if the old history is rewritten at this point.

Yeah, I don't see much point in rewriting. If parts of the history suck,
then so be it.  It's probably not that big to store. And while it's
sometimes easier to fix bad commit messages when they are recent and in
your memory (rather than trying to remember later what you meant to
say), I think it is already too late for that. Any archaeology you do
now to make good commit messages could probably just as easily be done
if and when somebody actually needs the commit message later (emphasis
on the "if" -- it's likely that nobody will care about most of the
commit messages later at all).

-Peff
