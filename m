From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Revert "rev-parse: remove restrictions on some
 options"
Date: Mon, 29 Feb 2016 16:29:43 -0500
Message-ID: <20160229212943.GA25342@sigill.intra.peff.net>
References: <20160226232507.GA9404@sigill.intra.peff.net>
 <20160226232957.GB9552@sigill.intra.peff.net>
 <20160226233449.GA9622@sigill.intra.peff.net>
 <20160229110156.GA29697@sigill.intra.peff.net>
 <xmqqy4a3cti1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 22:29:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaVO2-0006N4-U8
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 22:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbcB2V3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 16:29:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:51754 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750993AbcB2V3q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 16:29:46 -0500
Received: (qmail 9371 invoked by uid 102); 29 Feb 2016 21:29:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 16:29:45 -0500
Received: (qmail 31257 invoked by uid 107); 29 Feb 2016 21:29:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 16:29:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 16:29:43 -0500
Content-Disposition: inline
In-Reply-To: <xmqqy4a3cti1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287906>

On Mon, Feb 29, 2016 at 09:32:22AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > IOW, I think my 2/2 should be replaced with this:
> 
> This looks sensible.
> 
> Don't we still want the documentation updates from the previous 2/2?

I don't think so. They were primarily about moving those option blocks
to the "these options must come first..." section, which is no longer
true.

It also added "you don't have to be in a git repository for these" to
that section, but I think that is less important. We could add that
individually to each option, I guess.

-Peff
