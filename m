From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-reset: allow --soft in a bare repo
Date: Sat, 14 Jul 2007 21:02:15 -0400
Message-ID: <20070715010215.GA20676@sigill.intra.peff.net>
References: <20070714044916.GA24911@coredump.intra.peff.net> <7vir8nmujo.fsf@assigned-by-dhcp.cox.net> <20070714052405.GA26107@coredump.intra.peff.net> <7v7ip3jsf8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 03:02:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9sVF-0003Se-8v
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 03:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758711AbXGOBCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 21:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758772AbXGOBCW
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 21:02:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1539 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758430AbXGOBCV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 21:02:21 -0400
Received: (qmail 2888 invoked from network); 15 Jul 2007 01:02:46 -0000
Received: from unknown (HELO sigill.intra.peff.net) (10.0.0.7)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 15 Jul 2007 01:02:46 -0000
Received: (qmail 20688 invoked by uid 1000); 15 Jul 2007 01:02:15 -0000
Content-Disposition: inline
In-Reply-To: <7v7ip3jsf8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52519>

On Sat, Jul 14, 2007 at 01:33:31AM -0700, Junio C Hamano wrote:

> > since git-branch is usually used for _making_ a branch, whereas
> "branch -f" is very often used to "reset the branch tip".  My
> git day typically begins with "branch -f pu next".

I think we just have a different perspective of what is "usual" here.

> Actually, after thinking about this a bit more, I have become
> somewhat reluctant, as this might confuse new users by giving
> them a wrong mental model of what "reset" is about.

OK, as I said on irc, I don't think this is a huge issue in the first
place, and your argument about encouraging a particular workflow for
git-reset makes some sense (even if that hasn't been my approach to
git-reset in the past).

-Peff
