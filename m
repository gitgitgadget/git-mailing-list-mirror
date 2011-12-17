From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] make "git push -v" actually verbose
Date: Sat, 17 Dec 2011 04:41:42 -0500
Message-ID: <20111217094142.GA10451@sigill.intra.peff.net>
References: <20111217093713.GA2073@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 10:41:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbqm5-0008Cf-ON
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 10:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601Ab1LQJlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 04:41:46 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44745
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495Ab1LQJlp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 04:41:45 -0500
Received: (qmail 11615 invoked by uid 107); 17 Dec 2011 09:48:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 Dec 2011 04:48:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Dec 2011 04:41:42 -0500
Content-Disposition: inline
In-Reply-To: <20111217093713.GA2073@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187362>

On Sat, Dec 17, 2011 at 04:37:15AM -0500, Jeff King wrote:

> Providing a single "-v" to "git push" currently does
> nothing. Giving two flags ("git push -v -v") turns on the
> first level of verbosity.

One minor clarification: it is not technically true that "git push -v"
does nothing. It just does not do the interesting "show a verbose status
table" operation, which is almost certainly what the user wants (and
what happened before the commits I mentioned). It does print "Pushing to
$url", since that happens above the transport layer. But I'm pretty sure
that is not what users of "-v" are interested in. :)

-Peff
