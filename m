From: Jeff King <peff@peff.net>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Thu, 7 Feb 2008 17:46:40 -0500
Message-ID: <20080207224640.GB18502@coredump.intra.peff.net>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org> <20080207142322.GC18497@mail-vs.djpig.de> <alpine.LFD.1.00.0802071039010.2883@woody.linux-foundation.org> <20080207204026.GA2550@sigill.intra.peff.net> <alpine.LFD.1.00.0802071256570.2896@woody.linux-foundation.org> <20080207215309.GP30368@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 23:47:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNFWk-0003zX-AB
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 23:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755703AbYBGWqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 17:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759867AbYBGWqq
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 17:46:46 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1735 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755881AbYBGWqp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 17:46:45 -0500
Received: (qmail 21462 invoked by uid 111); 7 Feb 2008 22:46:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 07 Feb 2008 17:46:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2008 17:46:40 -0500
Content-Disposition: inline
In-Reply-To: <20080207215309.GP30368@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73013>

On Fri, Feb 08, 2008 at 12:53:09AM +0300, Dmitry Potapov wrote:

> any derived work) to distribute Git linked against OpenSSL is technically
> illegal unless OpenSSL is the part of the standard OS libraries or Git

FWIW, openssl is in the "important" section in Debian, which makes it a
part of the standard install.

But again, this doesn't matter at all for git itself, but only for
binary distributors who must follow whatever interpretation of the GPL
their distribution decrees.

-Peff
