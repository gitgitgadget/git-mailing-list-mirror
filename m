From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
Date: Fri, 4 May 2012 03:25:56 -0400
Message-ID: <20120504072556.GF21895@sigill.intra.peff.net>
References: <4FA2B508.8000702@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri May 04 09:26:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQCtw-0001fw-2Q
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 09:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175Ab2EDH0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 03:26:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57632
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319Ab2EDHZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 03:25:59 -0400
Received: (qmail 16301 invoked by uid 107); 4 May 2012 07:26:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 May 2012 03:26:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 May 2012 03:25:56 -0400
Content-Disposition: inline
In-Reply-To: <4FA2B508.8000702@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197002>

On Thu, May 03, 2012 at 06:40:40PM +0200, Nelson Benitez Leon wrote:

> After adding the proxy authentication support in http, the semantics
> of HTTP_REAUTH changed more to a retry rather than a re-authentication,
> so we rename it to HTTP_AUTH_RETRY.

The patch looks fine, but a minor nit on the rationale. It has nothing
to do with the proxy auth. It has always been a bad name. It is not "you
should re-authenticate", but rather "I have already re-authenticated,
and therefore you should call me again to retry".

-Peff
