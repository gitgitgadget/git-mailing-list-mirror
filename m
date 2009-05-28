From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 1/2] Teach Solaris that _XOPEN_SOURCE=600 really
	menas XPG6
Date: Thu, 28 May 2009 15:19:40 -0400
Message-ID: <20090528191940.GG13499@coredump.intra.peff.net>
References: <1243106697-6424-1-git-send-email-gitster@pobox.com> <1243106697-6424-2-git-send-email-gitster@pobox.com> <WLNdjYtfqcg2bT6yOBtAykIqOBTeSLRUdlB6-sTM2KzTjwOmzN3fLg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 28 21:20:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9l9A-0007L2-BB
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 21:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755852AbZE1TTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 15:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754648AbZE1TTr
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 15:19:47 -0400
Received: from peff.net ([208.65.91.99]:47398 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753757AbZE1TTq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 15:19:46 -0400
Received: (qmail 22470 invoked by uid 107); 28 May 2009 19:19:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 May 2009 15:19:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2009 15:19:40 -0400
Content-Disposition: inline
In-Reply-To: <WLNdjYtfqcg2bT6yOBtAykIqOBTeSLRUdlB6-sTM2KzTjwOmzN3fLg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120213>

On Thu, May 28, 2009 at 11:46:50AM -0500, Brandon Casey wrote:

> So we either require compiling with a c99 compiler (by ensuring that
> _XPG6 is set) or exclude compiling with a c99 compiler on sun (by
> ensuring that _XPG6 is not set).  Actually, this would only affect Solaris
> versions which support XPG6.  Solaris 11 and 10 do.  I don't know about
> Solaris 9 and 8.  Solaris 7 doesn't.
> 
> Which do we want to do?

FWIW, I didn't even try using sun's cc. I have been doing all of my
builds using gcc 3.1.1 (from around 2002, which is what happens to be
available on the old-ish Solaris install at my university).

-Peff
