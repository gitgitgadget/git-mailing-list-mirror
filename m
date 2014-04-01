From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/22] api-lockfile: expand the documentation
Date: Tue, 1 Apr 2014 16:19:06 -0400
Message-ID: <20140401201906.GF21715@sigill.intra.peff.net>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
 <1396367910-7299-10-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 22:19:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV59S-00022j-6g
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 22:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbaDAUTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 16:19:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:52057 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751874AbaDAUTI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 16:19:08 -0400
Received: (qmail 22210 invoked by uid 102); 1 Apr 2014 20:19:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 15:19:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 16:19:06 -0400
Content-Disposition: inline
In-Reply-To: <1396367910-7299-10-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245653>

On Tue, Apr 01, 2014 at 05:58:17PM +0200, Michael Haggerty wrote:

> +unable_to_lock_error::
> +
> +	Emit an error describing that there was an error locking the
> +	specified path.  The err parameter should be the errno of the
> +	problem that caused the failure.
> +
> +unable_to_lock_index_die::
> +
> +	Like `unable_to_lock_error()`, but also `die()`.

Should this last one lost the "index" in its name? I think it is
vestigial at this point.

-Peff
