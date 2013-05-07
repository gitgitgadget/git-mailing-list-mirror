From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] fix packed-refs races
Date: Tue, 7 May 2013 10:19:42 -0400
Message-ID: <20130507141942.GA3658@sigill.intra.peff.net>
References: <20130503083847.GA16542@sigill.intra.peff.net>
 <20130507023610.GA22053@sigill.intra.peff.net>
 <7vobcnmgwg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 16:20:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZikW-0002KQ-0L
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 16:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174Ab3EGOTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 10:19:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:48255 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731Ab3EGOTp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 10:19:45 -0400
Received: (qmail 14156 invoked by uid 102); 7 May 2013 14:20:05 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 May 2013 09:20:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2013 10:19:42 -0400
Content-Disposition: inline
In-Reply-To: <7vobcnmgwg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223570>

On Mon, May 06, 2013 at 11:40:47PM -0700, Junio C Hamano wrote:

> I queued this, and will push the result out on the side of 'pu'
> closer to 'next'. Could you double check the conflict resolution?

I eyeballed the "--cc" output, as well as the resulting file, and it
looks fine to me.

> I haven't got around to the peel-ref-cleanup yet.

I'd leave that for now; the current code does have a bug, but it's not
triggerable through any of the current callers, so we can afford to take
our time. I'll try to work up a patch that just goes on top of Michael's
series.

-Peff
