From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] send-email: validate patches before sending
	anything
Date: Fri, 18 Jan 2008 14:12:01 -0500
Message-ID: <20080118191201.GB21044@coredump.intra.peff.net>
References: <20080118141638.GA14928@coredump.intra.peff.net> <20080118141948.GB19783@coredump.intra.peff.net> <76718490801180939v12112b5btd71dfb1fb5be5897@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Adam Piatyszek <ediap@users.sourceforge.net>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian+git@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 20:12:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFwdn-00047b-KR
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 20:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762364AbYARTMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 14:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761446AbYARTMF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 14:12:05 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2661 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757317AbYARTMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 14:12:03 -0500
Received: (qmail 20134 invoked by uid 111); 18 Jan 2008 19:12:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 18 Jan 2008 14:12:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Jan 2008 14:12:01 -0500
Content-Disposition: inline
In-Reply-To: <76718490801180939v12112b5btd71dfb1fb5be5897@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71053>

On Fri, Jan 18, 2008 at 12:39:45PM -0500, Jay Soffian wrote:

> > +                       return "patch contains line longer than 998 characters";
> How about offering the line number. e.g.:
> 
> return "patch line number $. is longer than 998 characters";

I think that is sensible (Junio, if you apply pre-1.5.4, can you mark it
up?  Otherwise I will put it in the post-1.5.4 resend).

> > +test_expect_success 'no patch was sent' '
> 
> Shouldn't that be "no patches were sent" to match the perl output?

It's purely an informational message for the test script output, so it
doesn't matter.

-Peff
