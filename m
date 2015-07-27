From: Jeff King <peff@peff.net>
Subject: Re: "git am" and then "git am -3" regression?
Date: Mon, 27 Jul 2015 04:32:44 -0400
Message-ID: <20150727083244.GA334@peff.net>
References: <xmqqr3nxmopp.fsf@gitster.dls.corp.google.com>
 <20150724180921.GA17730@peff.net>
 <CACRoPnR=DSETucY78Xo0RNxHKkqDnTCYFvHsSzWAG7X7z3_DKQ@mail.gmail.com>
 <20150726052100.GA31790@peff.net>
 <vpqmvyiauns.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 27 10:32:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJdq8-0000tS-1x
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 10:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbbG0Icr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 04:32:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:35125 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752091AbbG0Icr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 04:32:47 -0400
Received: (qmail 25844 invoked by uid 102); 27 Jul 2015 08:32:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jul 2015 03:32:47 -0500
Received: (qmail 4717 invoked by uid 107); 27 Jul 2015 08:32:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jul 2015 04:32:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jul 2015 04:32:44 -0400
Content-Disposition: inline
In-Reply-To: <vpqmvyiauns.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274664>

On Mon, Jul 27, 2015 at 10:09:43AM +0200, Matthieu Moy wrote:

> > Yeah, having to worry about two implementations of "git am" is a real
> > pain. If we are close on merging the builtin version, it makes sense to
> > me to hold off on the am.threeway feature until that is merged. Trying
> > to fix the ordering of the script that is going away isn't a good use of
> > anybody's time.
> 
> So, the best option seems to be:
> 
> 1) Revert d96a275 (git-am: add am.threeWay config variable, 2015-06-04)
> 
> 2) Include the C port of d96a275 together with tests and docs verbatim
>    from d96a275 into Paul's series.
> 
> Actually, doing 1) is probably a good idea anyway, there's no reason to
> hold the release for such minor feature.

I think step 1 is done already for v2.5.0, in 15dc5b5.

We _could_ fix it in the script version for the upcoming cycle, but if
we are merging builtin-am during this cycle, I do not see the point.

-Peff
