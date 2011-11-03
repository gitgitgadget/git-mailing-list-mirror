From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: print progress
Date: Thu, 3 Nov 2011 16:29:54 -0400
Message-ID: <20111103202954.GC19483@sigill.intra.peff.net>
References: <20111103033325.GA10230@sigill.intra.peff.net>
 <1320310234-11243-1-git-send-email-pclouds@gmail.com>
 <20111103193826.GB19483@sigill.intra.peff.net>
 <7vd3d9f0u8.fsf@alter.siamese.dyndns.org>
 <20111103195147.GA21318@sigill.intra.peff.net>
 <7v8vnxeyrp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 21:30:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM3vI-0002FH-DH
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 21:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab1KCU36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 16:29:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33019
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab1KCU36 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 16:29:58 -0400
Received: (qmail 27907 invoked by uid 107); 3 Nov 2011 20:35:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 03 Nov 2011 16:35:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2011 16:29:54 -0400
Content-Disposition: inline
In-Reply-To: <7v8vnxeyrp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184746>

On Thu, Nov 03, 2011 at 01:28:42PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Hmm, once you do this kind of thing I would expect two (or more) progress
> >> bars to be shown, something like:
> >> 
> >> 	$ git fsck --progress
> >> 	checking packs: 3 of 7 (42% done)
> >>      checking objects in pack: 12405 of 332340 (4% done)
> >
> > I don't think we can do multiple lines portably, though, because the
> > progress code just uses "\r" to return to the beginning of the line.
> 
> It was meant to be a tongue-in-cheek comment. I personally hate those
> "Installing n of N packages / Installation of package n p% done" progress
> meters when we know the weight of each of these N packages varies.

OK, I missed your sarcasm. You're too understated. ;)

So you would agree that we are better summing the objects for all packs
and showing one big progress bar?

-Peff
