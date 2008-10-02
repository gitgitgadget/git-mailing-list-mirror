From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Solaris: Use OLD_ICONV to avoid compile warnings
Date: Wed, 1 Oct 2008 21:08:17 -0400
Message-ID: <20081002010816.GA27415@coredump.intra.peff.net>
References: <1222906127-16900-1-git-send-email-sn_@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Soria Parra <dsp@php.net>
To: David Soria Parra <sn_@gmx.net>
X-From: git-owner@vger.kernel.org Thu Oct 02 03:09:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlCh9-0004aT-8A
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 03:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbYJBBIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 21:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbYJBBIU
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 21:08:20 -0400
Received: from peff.net ([208.65.91.99]:4098 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbYJBBIU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 21:08:20 -0400
Received: (qmail 22966 invoked by uid 111); 2 Oct 2008 01:08:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 01 Oct 2008 21:08:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Oct 2008 21:08:17 -0400
Content-Disposition: inline
In-Reply-To: <1222906127-16900-1-git-send-email-sn_@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97288>

On Thu, Oct 02, 2008 at 02:08:47AM +0200, David Soria Parra wrote:

> Solaris systems use the old styled iconv(3) call and therefore
> the OLD_ICONV variable should be set. Otherwise we get annoying compile
> warnings.

Acked-by: Jeff King <peff@peff.net>

I set OLD_ICONV on my Solaris build.

Do you also unset NEEDS_LIBICONV (and which version of Solaris are you
running)?  Our Makefile sets it to "yes" for Solaris 8, but my build box
requires that it be unset. I'm not sure if my setup is somehow
deficient, or if it is only other versions that need it.

-Peff
