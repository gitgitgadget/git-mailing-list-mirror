From: Jeff King <peff@peff.net>
Subject: Re: Presentation Ideas
Date: Fri, 17 Apr 2009 14:41:09 -0400
Message-ID: <20090417184109.GA30489@coredump.intra.peff.net>
References: <450196A1AAAE4B42A00A8B27A59278E70AB285C4@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:43:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lut1b-0000vp-95
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 20:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761106AbZDQSlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 14:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761101AbZDQSlT
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 14:41:19 -0400
Received: from peff.net ([208.65.91.99]:33325 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754352AbZDQSlS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 14:41:18 -0400
Received: (qmail 18695 invoked by uid 107); 17 Apr 2009 18:41:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 17 Apr 2009 14:41:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Apr 2009 14:41:09 -0400
Content-Disposition: inline
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70AB285C4@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116772>

On Fri, Apr 17, 2009 at 11:29:36AM -0400, John Dlugosz wrote:

> I'm going to be giving a presentation on git to other development teams.
> Is there any good material around I can borrow from or use as
> inspiration?

There seem to be two popular ways to present git, and which you prefer
to see seems to be a matter of personal learning style. They are:

  1. top-down; i.e., explaining commands in terms of workflow and
     accomplishing user-oriented tasks, and trying to minimize details
     unnecessary to the task at hand

  2. bottom-up; i.e., explaining the data structures of git first, upon
     which you can explain the behavior of commands, out of which you
     can see how to piece together tasks.

I prefer (2) myself. It's a steeper learning curve, but I think it pays
off when advanced topics in git just make sense (but then, I also think
that normal users should understand sed and awk).

If you are interested in (2), I have often seen this page referenced:

  http://eagain.net/articles/git-for-computer-scientists/

I also did a presentation of git to some CS grad students that was very
bottom-up. The slides are somewhat mediocre, but I would be happy to
share them if you like.

I think I stole a few diagrams from Junio's OLS talk, which has some
nice images (I especially like the symbolic view of the 3-way merge):

  http://members.cox.net/junkio/200607-ols.pdf

-Peff
