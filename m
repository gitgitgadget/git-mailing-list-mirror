From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-pack: don't consider branch lagging behind as
	errors.
Date: Sat, 28 Jun 2008 00:34:40 -0400
Message-ID: <20080628043440.GD9451@sigill.intra.peff.net>
References: <1213872715-11182-1-git-send-email-madcoder@debian.org> <20080619133747.GA31209@sigill.intra.peff.net> <20080619135159.GA19560@artemis.madism.org> <20080619151110.GA31654@sigill.intra.peff.net> <20080626075036.GA25770@sigill.intra.peff.net> <7vfxr0sj61.fsf@gitster.siamese.dyndns.org> <20080628043338.GC9451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 06:35:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCS9y-0002Fw-Tp
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 06:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbYF1Een (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 00:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbYF1Een
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 00:34:43 -0400
Received: from peff.net ([208.65.91.99]:2432 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796AbYF1Eem (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 00:34:42 -0400
Received: (qmail 8559 invoked by uid 111); 28 Jun 2008 04:34:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 28 Jun 2008 00:34:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jun 2008 00:34:40 -0400
Content-Disposition: inline
In-Reply-To: <20080628043338.GC9451@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86703>

On Sat, Jun 28, 2008 at 12:33:38AM -0400, Jeff King wrote:

> I think (1) should be implemented not as "this src ref and this dst ref
> do not match" but rather "this pair is up to date". And given that, I
> think that is basically the same as my proposal, except that the
> "push.rewindIsUpToDate" config variable would only be respected for a
> "matching refs" push. Which does feel a little inconsistent, as I noted
> in my previous mail, but I think it DWYM.

Where of course if we take "Y" in DWYM to be Pierre, he has already said
that's what he meant. :)

-Peff
