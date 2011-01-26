From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: sanitize more git environment variables
Date: Wed, 26 Jan 2011 15:34:44 -0500
Message-ID: <20110126203444.GB27478@sigill.intra.peff.net>
References: <20110126203331.GA27478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 21:34:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiC4o-0005Yc-Ax
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 21:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200Ab1AZUep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 15:34:45 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51872 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752882Ab1AZUep (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 15:34:45 -0500
Received: (qmail 8488 invoked by uid 111); 26 Jan 2011 20:34:44 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 26 Jan 2011 20:34:44 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jan 2011 15:34:44 -0500
Content-Disposition: inline
In-Reply-To: <20110126203331.GA27478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165538>

On Wed, Jan 26, 2011 at 03:33:32PM -0500, Jeff King wrote:

> These variables should generally not be set in one's
> environment, but they do get set by rebase, which means
> doing an interactive rebase like:
> 
>   pick abcd1234 foo
>   exec make test
> 
> will cause false negatives in the test suite.

Or I guess false positives, depending on your definition of positive and
negative. I.e., tests will fail when they shouldn't. :)

-Peff
