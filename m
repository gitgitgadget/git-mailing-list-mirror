From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] prune.c: only print informational message in
 show_only or verbose mode
Date: Tue, 7 Aug 2012 02:03:11 -0400
Message-ID: <20120807060311.GB13222@sigill.intra.peff.net>
References: <CA+sFfMdXc+usFRnCNVoke91_X2qWZARTvPHO=B7Ukxr-j7JB2g@mail.gmail.com>
 <1344315709-15897-1-git-send-email-drafnel@gmail.com>
 <1344315709-15897-2-git-send-email-drafnel@gmail.com>
 <7vtxwfw9rp.fsf@alter.siamese.dyndns.org>
 <7vpq73w9i8.fsf@alter.siamese.dyndns.org>
 <CA+sFfMdVhTwAFLUgrO-mLBh8apG-5X1OJKCN9xgq3-N+1RBrvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 08:03:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sycsy-0001CE-Fp
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 08:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab2HGGDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 02:03:15 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54187 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971Ab2HGGDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 02:03:15 -0400
Received: (qmail 25087 invoked by uid 107); 7 Aug 2012 06:03:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Aug 2012 02:03:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Aug 2012 02:03:11 -0400
Content-Disposition: inline
In-Reply-To: <CA+sFfMdVhTwAFLUgrO-mLBh8apG-5X1OJKCN9xgq3-N+1RBrvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203019>

On Mon, Aug 06, 2012 at 10:44:07PM -0700, Brandon Casey wrote:

> On Mon, Aug 6, 2012 at 10:32 PM, Jeff King <peff@peff.net> wrote:
> >
> > This seems like a band-aid. The real problem is that auto-gc can
> > interfere with the pack protocol, which it should not be allowed to do,
> > no matter what it produces.
> >
> > We could fix that root cause with this patch (on top of your 1/2):
> 
> Anyone else? :)

Sorry to gang up on you. :)

I still think your 2/2 is worth doing independently, though. It is silly
that git-prune will not mention pruned objects without "-v", but will
mention temporary files. They should be in the same category.

-Peff
