From: Jeff King <peff@peff.net>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Mon, 24 Nov 2014 17:22:44 -0500
Message-ID: <20141124222243.GA9055@peff.net>
References: <6997784.RuzRO1AFsK@al>
 <1628833.9HksdDrMW8@al>
 <xmqqtx1ouug8.fsf@gitster.dls.corp.google.com>
 <27811375.1kgEM3BV3q@al>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Peter Wu <peter@lekensteyn.nl>
X-From: git-owner@vger.kernel.org Mon Nov 24 23:22:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt21x-0008AP-Qb
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 23:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbaKXWWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 17:22:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:44391 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750860AbaKXWWp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 17:22:45 -0500
Received: (qmail 13218 invoked by uid 102); 24 Nov 2014 22:22:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 16:22:45 -0600
Received: (qmail 22764 invoked by uid 107); 24 Nov 2014 22:22:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Nov 2014 17:22:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Nov 2014 17:22:44 -0500
Content-Disposition: inline
In-Reply-To: <27811375.1kgEM3BV3q@al>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260159>

On Mon, Nov 24, 2014 at 11:16:03PM +0100, Peter Wu wrote:

> > A new option "--fetch" introducing a different behaviour is
> > perfectly fine; existing users who are not using it will not be
> > harmed by sudden behaviour change.
> 
> As stated before, I took care to avoid backwards incompatibilities. The
> command will still work as expected by the users who are aware of this
> particular behavior.

Right. My original complaint was only that "--fetch" is not as
orthogonal to "--push" (and an optionless set-url) as it could be. I
think the alternatives for going forward are basically:

  1. Name it something besides --fetch (but that's rather clunky).

  2. Migrate to new behavior, which is what is being discussed here.
     Probably needs a transition period?

  3. Live with it. Probably address the weirdness in the documentation.

  4. Do nothing, drop the patch.

I think I'd be OK with (3), with an appropriate documentation update.

-Peff
