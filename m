From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 1/2] Teach Solaris that _XOPEN_SOURCE=600 really
	menas XPG6
Date: Thu, 28 May 2009 15:50:57 -0400
Message-ID: <20090528195057.GA14360@coredump.intra.peff.net>
References: <1243106697-6424-1-git-send-email-gitster@pobox.com> <1243106697-6424-2-git-send-email-gitster@pobox.com> <WLNdjYtfqcg2bT6yOBtAykIqOBTeSLRUdlB6-sTM2KzTjwOmzN3fLg@cipher.nrlssc.navy.mil> <20090528191940.GG13499@coredump.intra.peff.net> <kZP6fFCtTQSG03irLxGArpacn-5pYEauMj-b0VWwhzPWMGiC_XnsYw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 28 21:51:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9ldE-0004n7-BO
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 21:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757419AbZE1TvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 15:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754624AbZE1TvF
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 15:51:05 -0400
Received: from peff.net ([208.65.91.99]:55317 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753195AbZE1TvE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 15:51:04 -0400
Received: (qmail 22721 invoked by uid 107); 28 May 2009 19:51:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 May 2009 15:51:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2009 15:50:57 -0400
Content-Disposition: inline
In-Reply-To: <kZP6fFCtTQSG03irLxGArpacn-5pYEauMj-b0VWwhzPWMGiC_XnsYw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120219>

On Thu, May 28, 2009 at 02:40:14PM -0500, Brandon Casey wrote:

> It's not the compiler that prevents compilation.  It's the header files.
> 
> You mentioned that on Solaris 8 there was only a single declaration for
> iconv.  There was not a macro check for _XPG6.  I suspect that Solaris 8
> does not support XPG6, so your compilation is just falling back to XPG4.

OK, that makes sense.

> The same thing happens on Solaris 7.  On Solaris 10, if the macros are
> set such that _XPG6 becomes set, then compilation will fail if the
> compiler is not a c99 one.

Right. What I was trying to say is "gcc 3.1.1 is probably c99 enough,
and I am using it already". That is, if you were asking how painful it
would be to require a c99 compiler for Solaris git, I am saying I don't
personally care.

But I don't know what is "normal".

-Peff
