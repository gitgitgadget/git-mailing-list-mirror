From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] Introduce die_errno() that appends
	strerror(errno) to die()
Date: Sat, 6 Jun 2009 18:47:11 -0400
Message-ID: <20090606224711.GC30064@coredump.intra.peff.net>
References: <cover.1244299302.git.trast@student.ethz.ch> <3672f22723a4c14c4a6d67278e9865424c0c68dc.1244299302.git.trast@student.ethz.ch> <200906062236.42858.j6t@kdbg.org> <200906062256.34074.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Alexander Potashev <aspotashev@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jun 07 00:47:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD4fi-0002ls-Dp
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 00:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbZFFWrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 18:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbZFFWrT
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 18:47:19 -0400
Received: from peff.net ([208.65.91.99]:49239 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881AbZFFWrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 18:47:19 -0400
Received: (qmail 12571 invoked by uid 107); 6 Jun 2009 22:47:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 06 Jun 2009 18:47:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Jun 2009 18:47:11 -0400
Content-Disposition: inline
In-Reply-To: <200906062256.34074.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120945>

On Sat, Jun 06, 2009 at 10:56:31PM +0200, Thomas Rast wrote:

> > Cannot vsnprintf potentially modify errno?
> 
> Manpage turns up nothing, so AFAICT, no.

POSIX seems to imply that it can:

  http://www.opengroup.org/onlinepubs/009695399/functions/fprintf.html

though it looks like the conditions are fairly unlikely.

-Peff
