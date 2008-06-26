From: Jeff King <peff@peff.net>
Subject: Re: [Bug] for-each-ref: %(object) and %(type) unimplemented
Date: Thu, 26 Jun 2008 01:35:51 -0400
Message-ID: <20080626053551.GA20767@sigill.intra.peff.net>
References: <48625DAD.5040404@gmail.com> <20080625160814.GA3321@sigill.intra.peff.net> <20080625161433.GA6612@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lea Wiemann <lewiemann@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 07:36:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBkA6-0001n5-Be
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 07:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbYFZFfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 01:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752898AbYFZFfy
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 01:35:54 -0400
Received: from peff.net ([208.65.91.99]:3837 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752643AbYFZFfy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 01:35:54 -0400
Received: (qmail 24109 invoked by uid 111); 26 Jun 2008 05:35:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 26 Jun 2008 01:35:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jun 2008 01:35:51 -0400
Content-Disposition: inline
In-Reply-To: <20080625161433.GA6612@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86396>

On Wed, Jun 25, 2008 at 12:14:33PM -0400, Jeff King wrote:

> Hmm. Actually, there is a test in t6300 that runs with each atom name.
> Unfortunately, it doesn't bother actually checking the output for
> sanity, so the fact that these atoms returned the empty string was
> missed.

And here is a two patch series cleaning up the test script and fixing
the bug.

-Peff
