From: Jeff King <peff@peff.net>
Subject: Re: fetch and pull
Date: Tue, 17 Mar 2009 20:37:53 -0400
Message-ID: <20090318003752.GA25454@coredump.intra.peff.net>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AEF9A@EXCHANGE.trad.tradestation.com> <76718490903161303h45e47a8co83159e32ae749352@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E70A2AF023@EXCHANGE.trad.tradestation.com> <76718490903161514ubbdc948o1a0251212fe65fea@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E70A2AF0A9@EXCHANGE.trad.tradestation.com> <76718490903161709v6d8d09f6k17d2fe1a5e56fb03@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E70A2AF22F@EXCHANGE.trad.tradestation.com> <76718490903170921r36843c11y5aac537d53384298@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E70A3FC0A5@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 01:39:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljjoj-0006fR-LJ
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 01:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbZCRAiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 20:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbZCRAiC
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 20:38:02 -0400
Received: from peff.net ([208.65.91.99]:60913 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685AbZCRAiB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 20:38:01 -0400
Received: (qmail 9043 invoked by uid 107); 18 Mar 2009 00:38:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Mar 2009 20:38:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2009 20:37:53 -0400
Content-Disposition: inline
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A3FC0A5@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113541>

On Tue, Mar 17, 2009 at 12:44:31PM -0400, John Dlugosz wrote:

> > > You checkout master before updating it?
> > 
> > You cannot merge/rebase a branch unless it is checked out.
> > 
> Sure you can.
> 	git rebase upstream topic

This literally does a "checkout" behind the scenes, so it is still
manipulating your working tree. It is basically the equivalent of:

  git checkout topic && git rebase upstream

The actual rebasing happens on a detached HEAD, but you will find at the
end of such a rebase that you are now on the branch "topic".

-Peff
