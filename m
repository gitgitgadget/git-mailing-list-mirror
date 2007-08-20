From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document what the stage numbers in the :$n:path syntax
	mean.
Date: Mon, 20 Aug 2007 02:44:01 -0400
Message-ID: <20070820064401.GB31201@coredump.intra.peff.net>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net> <20070814231422.GA10662@pe.Belkin> <7vps1paceh.fsf@assigned-by-dhcp.cox.net> <46C90C46.1030000@midwinter.com> <20070820055221.GA22993@coredump.intra.peff.net> <20070820060522.GA27913@spearce.org> <7vveba90qs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Steven Grimm <koreth@midwinter.com>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 08:44:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN0zq-0005Tp-Fr
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 08:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXHTGoJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 02:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbXHTGoI
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 02:44:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4105 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080AbXHTGoH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 02:44:07 -0400
Received: (qmail 17585 invoked by uid 111); 20 Aug 2007 06:44:14 -0000
X-Spam-Status: No, hits=-1.4 required=15.0
	tests=ALL_TRUSTED
X-Spam-Check-By: peff.net
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Aug 2007 02:44:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Aug 2007 02:44:01 -0400
Content-Disposition: inline
In-Reply-To: <7vveba90qs.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56180>

On Sun, Aug 19, 2007 at 11:30:19PM -0700, Junio C Hamano wrote:

> I am not _opposed_ to :ours:$path syntax, but I suspect there is
> something else that is wrong if you need to use :$n:$path syntax
> that often.

That's the problem: I don't use it that often, so when I do, the numbers
seem nonsensical.

> I have never been in a situation I had to say :base:$path,
> unless I am debugging the merge driver.  So it is between :ours:$path
> and :theirs:$path.

I used to need it to look at the 3-way merge, but git-mergetool now does
a nice job of hiding these details from me.

Thinking about it more, I really _haven't_ used the stages at all since
git-mergetool came around. This thread just reminded me of all the prior
times when I had had trouble with it.

So Junio, please consider my patch retracted. What _would_ be useful is
GITHEAD_* support for git-mergetool, which has been on my 'todo' list
for some time. I'll see if I can work up a patch for that.

-Peff
