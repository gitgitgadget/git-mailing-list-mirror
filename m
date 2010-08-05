From: Jeff King <peff@peff.net>
Subject: Re: jk/tag-contains: stalled
Date: Thu, 5 Aug 2010 13:36:36 -0400
Message-ID: <20100805173635.GA15760@sigill>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
 <20100805001629.GC2901@thunk.org>
 <7vsk2tdnv5.fsf@alter.siamese.dyndns.org>
 <7vhbj9dm6h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ted Ts'o <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 19:36:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh4N5-0008Q3-TZ
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 19:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750Ab0HERgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 13:36:42 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54146 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388Ab0HERgl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 13:36:41 -0400
Received: (qmail 29611 invoked by uid 111); 5 Aug 2010 17:36:39 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.116)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 05 Aug 2010 17:36:39 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Aug 2010 13:36:36 -0400
Content-Disposition: inline
In-Reply-To: <7vhbj9dm6h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152695>

On Thu, Aug 05, 2010 at 10:05:58AM -0700, Junio C Hamano wrote:

> >>> * jk/tag-contains (2010-07-05) 4 commits
> >>>  - Why is "git tag --contains" so slow?
> >>>  - default core.clockskew variable to one day
> >>>  - limit "contains" traversals based on commit timestamp
> >>>  - tag: speed up --contains calculation
> [...]
> > I agree in principle; the log messages need to be cleaned up first
> > at the least, though.
> 
> To reduce the risk of double-work, I need to clarify.
> 
> I meant to say that I can find enough material, especially what Peff
> wrote, in the discussion that followed in the thread to do the clean-up
> myself.  No need to resend by anybody unless there are material
> differences from what have been discussed so far that need to be
> incorporated in the final series.

The only bad log message should be the final one, which should be
dropped anyway. I would recommend just merging the first two for now,
and Ted can tweak his core.clockskew manually.

-Peff
