From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] bisect: refactor sha1_array into a generic sha1 list
Date: Mon, 23 May 2011 17:53:48 -0400
Message-ID: <20110523215348.GA9706@sigill.intra.peff.net>
References: <20110519213231.GA29702@sigill.intra.peff.net>
 <20110519213433.GB29793@sigill.intra.peff.net>
 <BANLkTikYih5hOU=_Q9N_b8VZ_KJeb8zePg@mail.gmail.com>
 <20110520074714.GC3663@sigill.intra.peff.net>
 <7vy6212t23.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 23:53:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOd4X-00061S-3E
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 23:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450Ab1EWVxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 17:53:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46956
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932177Ab1EWVxv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 17:53:51 -0400
Received: (qmail 24152 invoked by uid 107); 23 May 2011 21:55:54 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 17:55:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 17:53:48 -0400
Content-Disposition: inline
In-Reply-To: <7vy6212t23.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174282>

On Fri, May 20, 2011 at 10:14:12AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, they probably should both be unsigned, and the sorted flag should
> > be a bit-field (not that it saves any space here, but it makes its purpose
> > more clear).
> >
> > Junio, do you mind squashing this into patch 2/3?
> 
> I actually do ;-) If you grep for ALLOC_GROW and look at the structures
> they touch, nr/alloc pairs that are integers are the majority in our
> codebase, and I do not see much bikeshedding value in adding more unsigned
> ones to the mix.

OK, no complaint from me on that.

-Peff
