From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] merge & sequencer: turn "Conflicts:" hint into a comment
Date: Tue, 28 Oct 2014 18:21:08 -0400
Message-ID: <20141028222108.GB20722@peff.net>
References: <xmqq1tpxgw6t.fsf@gitster.dls.corp.google.com>
 <xmqqvbn9f9ig.fsf@gitster.dls.corp.google.com>
 <xmqqr3xxf9ey.fsf_-_@gitster.dls.corp.google.com>
 <20141026185909.GC18144@peff.net>
 <xmqqegttfmg0.fsf@gitster.dls.corp.google.com>
 <xmqqsii9qleh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 23:21:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjF8o-0000il-OT
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 23:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249AbaJ1WVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 18:21:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:34727 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754912AbaJ1WVK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 18:21:10 -0400
Received: (qmail 9922 invoked by uid 102); 28 Oct 2014 22:21:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Oct 2014 17:21:10 -0500
Received: (qmail 28033 invoked by uid 107); 28 Oct 2014 22:21:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Oct 2014 18:21:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Oct 2014 18:21:08 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsii9qleh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 27, 2014 at 01:59:18PM -0700, Junio C Hamano wrote:

> > I do not think it is too hard to teach strbuf_commented_addf() about
> > the leading HT, but that would be a separate topic; if squashing the
> > SP-HT to HT is worth doing for this codepath, doing it at that helper
> > would benefit all callers.
> 
> -- >8 --
> Subject: [PATCH] strbuf_add_lines(): avoid SP-HT sequence
> [...]

Thanks for doing this. I agree that this is the right place to put the
magic, and the patch looks obviously correct. I also double-checked it
with the "# Conflicts" patches and it addresses the problem I saw.

-Peff
