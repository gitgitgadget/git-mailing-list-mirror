From: Jeff King <peff@peff.net>
Subject: Re: [tig PATCH] continue updates when pipe read has errno "Success"
Date: Fri, 22 Aug 2008 11:59:14 -0400
Message-ID: <20080822155914.GB5280@coredump.intra.peff.net>
References: <20080821014043.GA14452@coredump.intra.peff.net> <2c6b72b30808220310v1083e860tef9fd6efa57767e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 18:00:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWZ3k-00054y-S5
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 18:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbYHVP7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 11:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbYHVP7R
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 11:59:17 -0400
Received: from peff.net ([208.65.91.99]:2019 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbYHVP7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 11:59:16 -0400
Received: (qmail 20032 invoked by uid 111); 22 Aug 2008 15:59:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 22 Aug 2008 11:59:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Aug 2008 11:59:14 -0400
Content-Disposition: inline
In-Reply-To: <2c6b72b30808220310v1083e860tef9fd6efa57767e3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93315>

On Fri, Aug 22, 2008 at 12:10:35PM +0200, Jonas Fonseca wrote:

> Thanks for the fix/workaround!

Thank you for making tig. ;)

> For a possible "better" fix, I have been working on moving tig to use
> the run-command.[ch] code from git, which means that ferror() will no
> longer be needed. It is still not ready but looks promising.

I think that would be much cleaner, as the semantics of system calls and
signals tend to be better defined.

-Peff
