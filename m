From: Jeff King <peff@peff.net>
Subject: Re: [Bug] for-each-ref: %(object) and %(type) unimplemented
Date: Wed, 25 Jun 2008 12:14:33 -0400
Message-ID: <20080625161433.GA6612@sigill.intra.peff.net>
References: <48625DAD.5040404@gmail.com> <20080625160814.GA3321@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 18:15:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBXf1-00043U-Pf
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 18:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127AbYFYQOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 12:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbYFYQOg
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 12:14:36 -0400
Received: from peff.net ([208.65.91.99]:4810 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752765AbYFYQOg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 12:14:36 -0400
Received: (qmail 15421 invoked by uid 111); 25 Jun 2008 16:14:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 25 Jun 2008 12:14:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2008 12:14:33 -0400
Content-Disposition: inline
In-Reply-To: <20080625160814.GA3321@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86295>

On Wed, Jun 25, 2008 at 12:08:15PM -0400, Jeff King wrote:

> Since you seem to be testing for-each-ref, maybe it would make sense to
> put together a test script that exercises each of the atoms?

Hmm. Actually, there is a test in t6300 that runs with each atom name.
Unfortunately, it doesn't bother actually checking the output for
sanity, so the fact that these atoms returned the empty string was
missed.

-Peff
