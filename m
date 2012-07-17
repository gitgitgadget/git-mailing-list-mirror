From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Fix notes handling in rev-list
Date: Mon, 16 Jul 2012 23:51:38 -0400
Message-ID: <20120717035138.GC20945@sigill.intra.peff.net>
References: <20120325005504.GA27651@sigill.intra.peff.net>
 <1342463409-6919-1-git-send-email-jukka.lehtniemi@gmail.com>
 <7vipdn1qb7.fsf@alter.siamese.dyndns.org>
 <20120717031727.GA20945@sigill.intra.peff.net>
 <7v1ukbys0n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 05:51:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqypA-0004gE-UY
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 05:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab2GQDvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 23:51:43 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33871
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476Ab2GQDvm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 23:51:42 -0400
Received: (qmail 3453 invoked by uid 107); 17 Jul 2012 03:51:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jul 2012 23:51:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2012 23:51:38 -0400
Content-Disposition: inline
In-Reply-To: <7v1ukbys0n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201587>

On Mon, Jul 16, 2012 at 08:40:24PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... But whatever we call it, I think it is an
> > improvement.
> 
> I didn't say it makes things worse in any way, did I?

No, you did not. That was my attempt to end the paragraph on a positive
and constructive note. What I meant was "I think you are wrong and it is
a bugfix, but I do not care overly what we call it as long as we do it."
:)

Do note that my "as long as we do it" is about the direction, not the
patch. There are a few issues with the patch itself, and I just posted a
review.

> I was reacting on the Subject: line because that will what I later
> have to work from when reading shortlog, summarizing changes, etc.

That is a fair point. From the release notes perspective, it probably is
a feature (there is a documentation bug, but it happens to be fixed at
the same time).

-Peff
