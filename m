From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] transport-helper: check if remote helper is alive
Date: Mon, 8 Apr 2013 14:49:33 -0400
Message-ID: <20130408184933.GA7337@sigill.intra.peff.net>
References: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
 <1365320706-13539-3-git-send-email-felipe.contreras@gmail.com>
 <20130408005155.GA24030@sigill.intra.peff.net>
 <CAMP44s0PYARrCQxyBOiGzCAKTXqGp5yrKyfVwLjE1CyuxVSU2A@mail.gmail.com>
 <20130408023351.GA32558@sigill.intra.peff.net>
 <CAMP44s1cphJ5wojt2OeZjWJVOi5AMQJR2jN_BCkQw0B0BxpUfA@mail.gmail.com>
 <7vtxngyl30.fsf@alter.siamese.dyndns.org>
 <CAMP44s2PJGJQBM86CGsA5BOn1RLi4mqNsq+d0oyY0jA=XHQGDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 20:49:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPH8e-0007Qx-5y
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 20:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935635Ab3DHStj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 14:49:39 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34109 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935627Ab3DHSth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 14:49:37 -0400
Received: (qmail 13909 invoked by uid 107); 8 Apr 2013 18:51:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Apr 2013 14:51:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2013 14:49:33 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2PJGJQBM86CGsA5BOn1RLi4mqNsq+d0oyY0jA=XHQGDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220491>

On Mon, Apr 08, 2013 at 01:31:43PM -0500, Felipe Contreras wrote:

> > Reviewers have limited time allocated for each individual topic.  To
> > an original patch with say 3 problems, the review may only point out
> > issues in 2 and suggest a concrete improvement for only 1 and that
> > is sufficient to suggest a reroll.  That is not being unhelpful by
> > deliberately withholding 1 and half reviews in the initial round.
> 
> I'm not talking about the time it took to come up with the criticism
> below, I'm talking about the comment regarding the commit message. If
> the commit message did indeed provide *zero* explanation, that's
> certainly something that should be immediately visible, no? It could
> have been mentioned six months ago.

I do not recall this series at all from six months ago. I reviewed a
series (with no version markers, nor any mention of the previous round)
posted on April 1st, and assumed it was a new series. I raised the same
issues there that I did in v3, though in less detail (because I had not
yet looked into it as thoroughly).

I searched the archive after reading this mail and found the original
series. Yes, it existed. I didn't review it. I guess I had something
more important to do that day.

But is all of this even important? If there are technical issues with
this series, does it matter when we find out about them? They still
deserve to be fixed, no?  Yes, it is nice if things get reviewed
promptly, but the limited bandwidth and attention of reviewers is a fact
of life.

-Peff
