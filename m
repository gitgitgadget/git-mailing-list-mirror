From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/9] strbuf: add strbuf_tolower function
Date: Fri, 23 May 2014 16:05:34 -0400
Message-ID: <20140523200534.GD19088@sigill.intra.peff.net>
References: <20140521102524.GA30301@sigill.intra.peff.net>
 <20140521102742.GB30464@sigill.intra.peff.net>
 <AD42BA87-3C73-4EB2-AF88-96C4F7E6FA0C@gmail.com>
 <20140522055852.GA16587@sigill.intra.peff.net>
 <xmqq38g1oe2y.fsf@gitster.dls.corp.google.com>
 <20140522184113.GC1167@sigill.intra.peff.net>
 <0E298290-243D-46E5-A177-C6D3553D7153@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 22:05:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnvin-0000im-2b
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 22:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbaEWUFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 16:05:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:58324 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750872AbaEWUFg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 16:05:36 -0400
Received: (qmail 2276 invoked by uid 102); 23 May 2014 20:05:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 May 2014 15:05:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 May 2014 16:05:34 -0400
Content-Disposition: inline
In-Reply-To: <0E298290-243D-46E5-A177-C6D3553D7153@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250022>

On Thu, May 22, 2014 at 03:52:08PM -0700, Kyle J. McKay wrote:

> >Christian brought this up elsewhere, and I agree it's probably better to
> >work over the whole buffer, NULs included. I'm happy to re-roll (or you
> >can just pick up the version of the patch in this thread),
> 
> The only reason I brought up the code difference in the first place was that
> the comment was "This makes config's lowercase() function public" which made
> me expect to see basically the equivalent of replacing a "static" with an
> "extern", but actually the function being made public was a different
> implementation than config's lowercase() function.  So it looks like the
> original PATCH 2/9 version of the code is best, but perhaps the comment can
> be tweaked a bit to not convey the same impression I got.  Maybe something
> like "Replace config's lowercase() function with a public one".

Yeah, sorry if it sounded like I was complaining about your review
elsewhere. I mostly found it amusing that I got two opposite-direction
reviews.

I agree that clarifying the situation in the commit message is best, and
I've done that in the version I just posted.

-Peff
