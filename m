From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 01/25] api-lockfile: expand the documentation
Date: Mon, 7 Apr 2014 14:46:27 -0400
Message-ID: <20140407184627.GA19342@sigill.intra.peff.net>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
 <1396827247-28465-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 07 20:46:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXEZ3-000593-3i
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 20:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbaDGSqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 14:46:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:55592 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753190AbaDGSqa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 14:46:30 -0400
Received: (qmail 11080 invoked by uid 102); 7 Apr 2014 18:46:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Apr 2014 13:46:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Apr 2014 14:46:27 -0400
Content-Disposition: inline
In-Reply-To: <1396827247-28465-2-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245887>

On Mon, Apr 07, 2014 at 01:33:43AM +0200, Michael Haggerty wrote:

> +unable_to_lock_error::
> +
> +	Emit an error describing that there was an error locking the
> +	specified path.  The err parameter should be the errno of the
> +	problem that caused the failure.
> +
> +unable_to_lock_die::
> +
> +	Like `unable_to_lock_error()`, but also `die()`.

The die() function is still called unable_to_lock_index_die() at this
point in the series.  Presumably you change it later. I don't know if it
is worth caring about the order or not; it's a doc change, so it's not
like it breaks bisectability.

-Peff
