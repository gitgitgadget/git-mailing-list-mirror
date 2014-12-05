From: Jeff King <peff@peff.net>
Subject: Re: Git's configure script --mandir doesn't work
Date: Fri, 5 Dec 2014 04:36:20 -0500
Message-ID: <20141205093619.GE32112@peff.net>
References: <20141204232532.GB14036@SDF.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephen Fisher <sfisher@SDF.ORG>
X-From: git-owner@vger.kernel.org Fri Dec 05 10:36:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwpJM-0003mL-9O
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 10:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbaLEJgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 04:36:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:48850 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751984AbaLEJgW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 04:36:22 -0500
Received: (qmail 20716 invoked by uid 102); 5 Dec 2014 09:36:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Dec 2014 03:36:22 -0600
Received: (qmail 13581 invoked by uid 107); 5 Dec 2014 09:36:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Dec 2014 04:36:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Dec 2014 04:36:20 -0500
Content-Disposition: inline
In-Reply-To: <20141204232532.GB14036@SDF.ORG>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260863>

On Thu, Dec 04, 2014 at 04:25:32PM -0700, Stephen Fisher wrote:

> I'm installing Git 2.2.0 from source distribution on NetBSD 6.1.5 
> (amd64) and when I specify --mandir=/usr/local/man, it still installs 
> man pages in the default /usr/local/share/man directory.  Is there a fix 
> available for this?

It works fine for me here (Debian):

  tar xzf git-2.2.0.tar.gz
  cd git-2.2.0
  ./configure --prefix=/tmp/foo --mandir=/tmp/bar
  make install-man

puts the manpages into /tmp/bar.

Can you elaborate on the commands you're running? After running the
configure script, can you confirm that "mandir" is set appropriately in
config.mak.autogen?

-Peff
