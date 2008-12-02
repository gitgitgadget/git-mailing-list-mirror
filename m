From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4030-diff-textconv: Make octal escape sequence more
	portable
Date: Tue, 2 Dec 2008 07:54:14 -0500
Message-ID: <20081202125413.GA12913@coredump.intra.peff.net>
References: <4934F245.9020908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 13:59:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7UqW-0004xc-48
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 13:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbYLBMyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 07:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbYLBMyR
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 07:54:17 -0500
Received: from peff.net ([208.65.91.99]:2126 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbYLBMyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 07:54:16 -0500
Received: (qmail 11006 invoked by uid 111); 2 Dec 2008 12:54:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Dec 2008 07:54:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2008 07:54:14 -0500
Content-Disposition: inline
In-Reply-To: <4934F245.9020908@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102131>

On Tue, Dec 02, 2008 at 09:31:01AM +0100, Johannes Sixt wrote:

> There are printfs around that do not grok '\1', but need '\01'.
> Discovered on AIX 4.3.x.

Whee. Your fix works fine on my platforms (Solaris + FreeBSD).

> 	I found no other instance of printf backslash-nonzero.

Me either.

-Peff
