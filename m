From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 01:28:08 -0700
Message-ID: <7vac4460dj.fsf@assigned-by-dhcp.cox.net>
References: <20061009205551.GO20017@pasky.or.cz>
	<20061010062126.46664.qmail@web31810.mail.mud.yahoo.com>
	<20061010070531.GB2413@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 10:29:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXCyS-0004KI-9O
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 10:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWJJI2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 04:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWJJI2K
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 04:28:10 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:25533 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S965100AbWJJI2J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 04:28:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010082809.XEGZ16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 04:28:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YYUB1V0071kojtg0000000
	Tue, 10 Oct 2006 04:28:12 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20061010070531.GB2413@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 10 Oct 2006 03:05:31 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28617>

Jeff King <peff@peff.net> writes:

> On Mon, Oct 09, 2006 at 11:21:26PM -0700, Luben Tuikov wrote:
>
>> Anyone can come up with any "statistic" to convince anyone of
>> anything.  It's the American way! (to financial success)
>
> Petr introduced quantitative evidence and an analysis. You can argue
> that his numbers or his analysis are incorrect, but berating statistics
> as a whole is not a compelling argument.

Although I tend to agree with Pasky, I think Luben has a point
in that the click count he quoted does not have enough samples
and also tainted by known skews (both Gitzilla and I have
admitted that we hit blames unnecessarily not because we wanted
to see the blamed project but because we wanted to see how the
blame on his site shows things) to draw any meaningful
conclusion.

But that is as far as I would go agreeing with Luben on this
thread.  If we did not have anything else that obviously are
clickable it might be natural to expect people to click on
otherwise unhighlighted filenames to grab the blob data.  But
the current layout that shows filenames in plain and a few
obviously clickable links on the same line draws eyes and mouse
away from the filename and to the links on the right hand side,
even for somebody like me, who intellectually knows (because I
merged it) that the filenames in trees ought to be clickable.
