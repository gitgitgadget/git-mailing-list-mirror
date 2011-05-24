From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow built-ins to also use -c var=val via alias
Date: Tue, 24 May 2011 17:57:59 -0400
Message-ID: <20110524215759.GA24298@sigill.intra.peff.net>
References: <7vsjs37qcp.fsf@alter.siamese.dyndns.org>
 <7vmxib7q79.fsf@alter.siamese.dyndns.org>
 <20110524214618.GA17727@sigill.intra.peff.net>
 <20110524215202.GA22243@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 23:58:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOzc8-0004ti-AV
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 23:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757022Ab1EXV6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 17:58:02 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43616
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754245Ab1EXV6B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 17:58:01 -0400
Received: (qmail 22326 invoked by uid 107); 24 May 2011 21:58:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 May 2011 17:58:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 May 2011 17:57:59 -0400
Content-Disposition: inline
In-Reply-To: <20110524215202.GA22243@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174351>

On Tue, May 24, 2011 at 05:52:02PM -0400, Jeff King wrote:

> On Tue, May 24, 2011 at 05:46:18PM -0400, Jeff King wrote:
> 
> > I think the right fix is simply to drop the "don't re-check the
> > environment after the first time" logic. It's not expensive to parse
> > compared to parsing config files, which is when we would do it. We can
> > just drop the existing list and reparse. You can even get rid of the
> > whole list and drop a bunch of code, I think, like:
> 
> Ack, wrong patch. That one doesn't even come close to compiling.
> 
> Try this (still not well tested, though).

Ugh, broken. That will teach me to just paste any random junk into my
MUA. Hopefully you got the gist of what I was trying to say, but let me
come up with a more readable and tested series.

-Peff
