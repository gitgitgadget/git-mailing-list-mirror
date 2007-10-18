From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5516: test update of local refs on push
Date: Thu, 18 Oct 2007 02:21:36 -0400
Message-ID: <20071018062136.GB11938@coredump.intra.peff.net>
References: <20071018045358.GB14735@spearce.org> <20071018061746.GA29531@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Perry Wagle <wagle@cs.indiana.edu>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 08:21:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiOlS-0002zu-FQ
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 08:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbXJRGVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 02:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754328AbXJRGVj
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 02:21:39 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3026 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753401AbXJRGVj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 02:21:39 -0400
Received: (qmail 562 invoked by uid 111); 18 Oct 2007 06:21:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 02:21:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 02:21:36 -0400
Content-Disposition: inline
In-Reply-To: <20071018061746.GA29531@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61492>

On Thu, Oct 18, 2007 at 02:17:46AM -0400, Jeff King wrote:

> The first test (updating local refs) should succeed, but the
> second one (not updating on error) currently fails.

Oops, this should of course be labeled as 1/2.

For the fix, I didn't need anything from 'next', after all, and 2/2 also
works fine there (it was almost literally a code move).

-Peff
