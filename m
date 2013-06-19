From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/12] Fix some reference-related races
Date: Wed, 19 Jun 2013 14:56:45 -0400
Message-ID: <20130619185645.GB23647@sigill.intra.peff.net>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 19 20:56:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpNYr-0004dE-GO
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 20:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757418Ab3FSS4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 14:56:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:49206 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756847Ab3FSS4s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 14:56:48 -0400
Received: (qmail 30037 invoked by uid 102); 19 Jun 2013 18:57:46 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Jun 2013 13:57:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2013 14:56:45 -0400
Content-Disposition: inline
In-Reply-To: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228412>

On Wed, Jun 19, 2013 at 09:51:21AM +0200, Michael Haggerty wrote:

> Re-roll of mh/ref-races.  Thanks to Peff, Junio, and Ramsay for
> reviewing v1.

Thanks. I just read through them again. Everything looks good to me.

Patches 10 and 11 are missing my signoff, but obviously:

  Signed-off-by: Jeff King <peff@peff.net>

> The last patch is still optional--it avoids a little bit of work when
> rewriting the packed-refs file, but relies on the stat-based freshness
> check not giving a false negative.

I don't have a real problem with it, but given the cygwin confusions
that Ramsay mentioned, maybe it is better to hold back on it for now? It
sounds like the cygwin problems go the other way (false positives
instead of false negatives).

-Peff
