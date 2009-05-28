From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] Makefile: use /usr/ucb/install on SunOS platforms
	rather than ginstall
Date: Thu, 28 May 2009 14:57:36 -0400
Message-ID: <20090528185736.GD13499@coredump.intra.peff.net>
References: <8D9Pn2N3FZLQcyxrPABrG-rVdsP-X00e6c8oj-YzYQzWI-MvSy5AAzVjbQS0XsK76Ax9XKaLBbU@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 28 20:58:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9ko1-0006eY-2N
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 20:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756861AbZE1S5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 14:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755310AbZE1S5n
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 14:57:43 -0400
Received: from peff.net ([208.65.91.99]:44208 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754658AbZE1S5n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 14:57:43 -0400
Received: (qmail 22354 invoked by uid 107); 28 May 2009 18:57:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 May 2009 14:57:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2009 14:57:36 -0400
Content-Disposition: inline
In-Reply-To: <8D9Pn2N3FZLQcyxrPABrG-rVdsP-X00e6c8oj-YzYQzWI-MvSy5AAzVjbQS0XsK76Ax9XKaLBbU@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120210>

On Wed, May 27, 2009 at 09:17:05PM -0500, Brandon Casey wrote:

> We can avoid a GNU dependency by using /usr/ucb/install.
> [...]
> This works for me on Solaris 7 and 10.  Any reason not to use it instead
> of ginstall?

Certainly it works on Solaris 8; I've been setting it manually to
/usr/ucb/install (though I admit my auto-test script doesn't actually do
the install, I do occasionally run the install manually). I think it is
a sane default.

-Peff
