From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: skip RFC2047 quoting for ASCII subjects
Date: Thu, 25 Oct 2012 07:21:06 -0400
Message-ID: <20121025112106.GA25088@sigill.intra.peff.net>
References: <1351065815-22416-1-git-send-email-krzysiek@podlesie.net>
 <20121024084636.GA23500@sigill.intra.peff.net>
 <20121024171036.GA18880@shrek.podlesie.net>
 <20121024192530.GA26477@sigill.intra.peff.net>
 <20121024210826.GA23562@shrek.podlesie.net>
 <20121025090149.GC8390@sigill.intra.peff.net>
 <20121025100854.GN8390@sigill.intra.peff.net>
 <20121025111919.GA25272@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 13:21:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRLV5-0003nR-FS
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 13:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933950Ab2JYLVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 07:21:10 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56163 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757231Ab2JYLVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 07:21:09 -0400
Received: (qmail 8803 invoked by uid 107); 25 Oct 2012 11:21:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 07:21:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 07:21:06 -0400
Content-Disposition: inline
In-Reply-To: <20121025111919.GA25272@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208392>

On Thu, Oct 25, 2012 at 01:19:19PM +0200, Krzysztof Mazur wrote:

> On Thu, Oct 25, 2012 at 06:08:54AM -0400, Jeff King wrote:
> > 
> > Ah, never mind. I missed your earlier "use compose-encoding for
> > Subject". I've queued it and all of the follow-ons onto the
> > km/send-email-compose-encoding topic.
> > 
> 
> thanks, what about the problem with whitespaces in "quote_subject" patch?

I fixed the whitespace problems, and just applying your patches in
sequence on top of send-email-compose-encoding actually looks sensible
(after looking at it, I came to the same conclusion as you that the two
patches should be kept separate). I'll push out the results of tonight's
work in a few minutes, if you want to eyeball what's in pu.

-Peff
