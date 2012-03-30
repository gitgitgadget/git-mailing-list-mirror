From: Jeff King <peff@peff.net>
Subject: push.default: current vs upstream
Date: Fri, 30 Mar 2012 03:13:58 -0400
Message-ID: <20120330071358.GB30656@sigill.intra.peff.net>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 09:14:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDW2A-0007gv-Ru
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 09:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938Ab2C3HOC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 03:14:02 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40963
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755250Ab2C3HOA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 03:14:00 -0400
Received: (qmail 12007 invoked by uid 107); 30 Mar 2012 07:14:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Mar 2012 03:14:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2012 03:13:58 -0400
Content-Disposition: inline
In-Reply-To: <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194334>

On Thu, Mar 29, 2012 at 06:54:51PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But I would withhold a decision on "upstream" versus "current" until
> > those bugs are ironed out, because what people think of as "upstream"
> > (today's current behavior) may not be exactly what it ends up as.
> > ...
> > Anyway, I didn't exactly want to re-open the upstream versus current
> > debate at this point ...
> 
> Actually I did want to ;-) An announcement "We would be switching but we
> don't know what to" does not make sense.

OK. Then I think we shouldn't switch to upstream, and I'm ready to
debate it. :) I already posted my arguments earlier in the thread[1].
What do you think?

I think we can deal with my first issue (some workflows will cause "git
push" to error out without doing anything) with targeted advice for each
situation.  But I still worry about the "implied merge" concern I
raised, and I think the only way to fix that is to have a new mode that
is almost but not quite "upstream" (like the upstream-current hybrid I
mentioned).

Has somebody volunteered to make the necessary fixes to "push.default =
upstream" in the first place? At the very least we need the fixes you
mentioned in your mail[2] before it can become the default. So maybe
doing those is a good first step (of course we are in release freeze,
and it would be nice to settle this before v1.7.10 ships, so maybe there
is not time).

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/194299

[2] http://article.gmane.org/gmane.comp.version-control.git/194295
