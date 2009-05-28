From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] Makefile: add NEEDS_RESOLV to optionally add
	-lresolv to compile arguments
Date: Thu, 28 May 2009 15:10:51 -0400
Message-ID: <20090528191051.GE13499@coredump.intra.peff.net>
References: <8D9Pn2N3FZLQcyxrPABrG-rVdsP-X00e6c8oj-YzYQzWI-MvSy5AAzVjbQS0XsK76Ax9XKaLBbU@cipher.nrlssc.navy.mil> <8D9Pn2N3FZLQcyxrPABrG3rdrFXFL1OddmlhE77V4q-K8NSzkS8xbqdJw0C0CnqkCcLEUU_UEIs@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 28 21:11:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9l0O-0003Ls-Jz
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 21:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514AbZE1TLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 15:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754820AbZE1TK7
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 15:10:59 -0400
Received: from peff.net ([208.65.91.99]:45271 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754817AbZE1TK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 15:10:58 -0400
Received: (qmail 22414 invoked by uid 107); 28 May 2009 19:11:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 May 2009 15:11:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2009 15:10:51 -0400
Content-Disposition: inline
In-Reply-To: <8D9Pn2N3FZLQcyxrPABrG3rdrFXFL1OddmlhE77V4q-K8NSzkS8xbqdJw0C0CnqkCcLEUU_UEIs@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120211>

On Wed, May 27, 2009 at 09:17:06PM -0500, Brandon Casey wrote:

> This library is required on Solaris since hstrerror resides in libresolv.
> Additionally, on Solaris 7, inet_ntop and inet_pton reside there too.

Patch works for me on Solaris 8, though it is largely a non-issue:
hstrerror is only used at all if NO_IPV6 is set, and I don't set that
for my build.

-Peff
