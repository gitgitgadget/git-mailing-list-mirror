From: Jeff King <peff@peff.net>
Subject: Re: git-cvsexportcommit fails for huge commits
Date: Thu, 13 Dec 2007 04:01:49 -0500
Message-ID: <20071213090148.GA4496@coredump.intra.peff.net>
References: <20071211200418.GA13815@mkl-desktop> <20071212083154.GB7676@coredump.intra.peff.net> <46a038f90712121158n674a9044t75ef99473314457c@mail.gmail.com> <20071213041737.GA23624@coredump.intra.peff.net> <20071213083931.GA6441@mkl-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: Markus Klinik <markus.klinik@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 13 10:02:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2jxS-0004bB-0V
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 10:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbXLMJBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 04:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbXLMJBy
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 04:01:54 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4081 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbXLMJBx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 04:01:53 -0500
Received: (qmail 8128 invoked by uid 111); 13 Dec 2007 09:01:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Dec 2007 04:01:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Dec 2007 04:01:49 -0500
Content-Disposition: inline
In-Reply-To: <20071213083931.GA6441@mkl-desktop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68132>

On Thu, Dec 13, 2007 at 09:39:31AM +0100, Markus Klinik wrote:

> > it would be nice to get feedback from Markus on what platform he is
> > using and what is a reasonable value), or just using a tempfile with
> > xargs, which should figure out the correct value.
> 
> My platform is an ubuntu 7.04.

In that case, I think a very large value like 100K is fine. Then the code
won't activate unless it is really required.

It still feels a bit hack-ish and wrong, but I'm not sure what would be
better.

-Peff
