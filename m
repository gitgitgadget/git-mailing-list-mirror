From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] refactor userdiff textconv code
Date: Fri, 24 Oct 2008 10:08:22 -0400
Message-ID: <20081024140822.GA11612@coredump.intra.peff.net>
References: <20081024024631.GA20365@coredump.intra.peff.net> <20081024025330.GC2831@coredump.intra.peff.net> <4901762A.3090003@viscovery.net> <20081024135132.GA11568@coredump.intra.peff.net> <4901D557.90106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 24 16:10:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtNME-0000bf-Kp
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 16:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbYJXOI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 10:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbYJXOI0
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 10:08:26 -0400
Received: from peff.net ([208.65.91.99]:2750 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbYJXOIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 10:08:25 -0400
Received: (qmail 19333 invoked by uid 111); 24 Oct 2008 14:08:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 24 Oct 2008 10:08:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Oct 2008 10:08:22 -0400
Content-Disposition: inline
In-Reply-To: <4901D557.90106@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99040>

On Fri, Oct 24, 2008 at 04:01:59PM +0200, Johannes Sixt wrote:

> Your reasoning makes sense, of course. (I thought that forgoing textconv
> in these cases would have a simpler implementation; but it can't be a lot
> simpler than yours.)

Yeah, I think preventing it entirely for this case would be much more
complex, since you would have to realize much sooner that a textconv was
going to happen.

> > +test_expect_failure 'textconv does not act on symlinks' '
> Can we trust your solution if you still have 'test_expect_failure' here? ;-)

Heh. It helps if I commit before format-patch. ;) Fortunately, this was
the only change I missed out on sending.

-Peff
