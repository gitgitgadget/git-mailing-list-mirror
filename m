From: Jeff King <peff@peff.net>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Thu, 7 Feb 2008 15:40:29 -0500
Message-ID: <20080207204026.GA2550@sigill.intra.peff.net>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org> <20080207142322.GC18497@mail-vs.djpig.de> <alpine.LFD.1.00.0802071039010.2883@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 21:41:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNDZ9-0003aR-CQ
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 21:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761013AbYBGUkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 15:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761168AbYBGUkl
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 15:40:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3369 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755132AbYBGUkk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 15:40:40 -0500
Received: (qmail 19823 invoked by uid 111); 7 Feb 2008 20:40:37 -0000
Received: from lawn-128-61-28-119.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.28.119)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 07 Feb 2008 15:40:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2008 15:40:29 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802071039010.2883@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72998>

On Thu, Feb 07, 2008 at 10:42:15AM -0800, Linus Torvalds wrote:

> For crazy people who think that regular libraries can change the copyright 
> status of a program (not so), you can always decide to build without 
> OpenSSL and use the included Mozilla-based SHA1 implementation for git.

FWIW, this is not about OpenSSL for SHA1; it is about the underlying
library used by curl to do SSL (gnutls vs openssl). And the problem is
that curl linked against gnutls seems _broken_, so Anand has asked if
Debian can ship a binary git linked against a curl that is linked
against openssl (and the answer is probably "no, Debian people think
that is wrong").

-Peff
