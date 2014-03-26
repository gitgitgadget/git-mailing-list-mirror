From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/6] reuse deltas found by bitmaps
Date: Wed, 26 Mar 2014 18:36:16 -0400
Message-ID: <20140326223616.GA19811@sigill.intra.peff.net>
References: <20140326072215.GA31739@sigill.intra.peff.net>
 <xmqq7g7gkgp6.fsf@gitster.dls.corp.google.com>
 <20140326181300.GA7087@sigill.intra.peff.net>
 <xmqqvbv0h9rm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ben Maurer <bmaurer@fb.com>,
	Siddharth Agarwal <sid0@fb.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 23:36:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSwQs-0006f8-OP
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 23:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601AbaCZWgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 18:36:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:48075 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756597AbaCZWgS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 18:36:18 -0400
Received: (qmail 30267 invoked by uid 102); 26 Mar 2014 22:36:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 17:36:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 18:36:16 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbv0h9rm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245250>

On Wed, Mar 26, 2014 at 03:31:41PM -0700, Junio C Hamano wrote:

> > I think we could still add the objects from the tip of the client's HAVE
> > list.
> 
> That should make the result at least per to the non-bitmap case,
> right?

That's my expectation.
> 
> >   2. Measure the "reused deltas become preferred bases" approach. I
> >      expect the resulting size to be slightly better than what I have
> >      now, but not as good as v1.9.0's size (but taking less CPU time).
> 
> Do you mean "the bases for reused deltas become preferred bases, so
> that we can deltify more objects off of them"?

Exactly.

I'll update more when I have results for some of these. :)

-Peff
