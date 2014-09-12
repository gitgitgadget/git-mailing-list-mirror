From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: return non-zero status on missing ref tips
Date: Fri, 12 Sep 2014 00:38:44 -0400
Message-ID: <20140912043844.GA5241@peff.net>
References: <1409177412.15185.3.camel@leckie>
 <20140829185325.GC29456@peff.net>
 <xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
 <1409343480.19256.2.camel@leckie>
 <20140829203145.GA510@peff.net>
 <xmqq4mwgjvt6.fsf_-_@gitster.dls.corp.google.com>
 <20140909220709.GA14029@peff.net>
 <20140912033830.GA5507@peff.net>
 <20140912042939.GA5968@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 06:38:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSIdH-0000Ul-Gx
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 06:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbaILEir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 00:38:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:47318 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750915AbaILEir (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 00:38:47 -0400
Received: (qmail 32659 invoked by uid 102); 12 Sep 2014 04:38:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Sep 2014 23:38:47 -0500
Received: (qmail 31710 invoked by uid 107); 12 Sep 2014 04:39:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Sep 2014 00:39:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Sep 2014 00:38:44 -0400
Content-Disposition: inline
In-Reply-To: <20140912042939.GA5968@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256897>

On Fri, Sep 12, 2014 at 12:29:39AM -0400, Jeff King wrote:

> Dropping curate_packed_ref_fn (as below) fixes the test above. And
> miraculously does not even seem to conflict with ref patches in pu. :)

Of course I spoke too soon. The patch I sent is actually based on pu. It
is easy to make the equivalent change in either "master" or "pu" (they
are both just deletions of the same blocks), but the code mutated a
little in between, and there are purely textual conflicts going from one
to the other.

-Peff
