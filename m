From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] config: add include directive
Date: Fri, 27 Jan 2012 00:55:15 -0500
Message-ID: <20120127055515.GC23633@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126073752.GA30474@sigill.intra.peff.net>
 <7vipjy2nbi.fsf@alter.siamese.dyndns.org>
 <20120126225140.GB12855@sigill.intra.peff.net>
 <7vk44d1zww.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 06:55:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqemS-0005xE-7n
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 06:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab2A0FzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 00:55:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46327
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589Ab2A0FzT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 00:55:19 -0500
Received: (qmail 2328 invoked by uid 107); 27 Jan 2012 06:02:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Jan 2012 01:02:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2012 00:55:15 -0500
Content-Disposition: inline
In-Reply-To: <7vk44d1zww.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189196>

On Thu, Jan 26, 2012 at 09:23:59PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > And then because of 1a and 2a, most programs should Just Work without
> > any changes, but because of 1b and 2b, any special uses will have to
> > decide manually whether they would want to allow includes.
> >
> > Does that make sense?
> 
> In short, the "git config" interface defaults to "--no-includes" when
> reading from an explicit file with "-f" and "--includes" otherwise, which
> sounds like a 100% sensible default to me.

Yes, exactly. Thank you for explaining it in about 1/10 the words I
needed to use. :)

I'll put that behavior in the re-roll.

> > How about:
> >
> >   The included file is processed immediately, before any other
> >   directives from the surrounding file.
> >
> > What I wanted to make clear there is the ordering, which sometimes
> > matters.
> 
> Hmm, I think the original is probably easier to read.

OK, then I'll leave it unless somebody else wants to come up with
something brilliant.

-Peff
