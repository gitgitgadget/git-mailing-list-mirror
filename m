From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 09 Jan 2007 13:20:27 -0800
Message-ID: <7virffkick.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<87ps9xgkjo.wl%cworth@cworth.org>
	<7virfprquo.fsf@assigned-by-dhcp.cox.net>
	<87odphgfzz.wl%cworth@cworth.org>
	<7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
	<20070108131735.GA2647@coredump.intra.peff.net>
	<7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
	<20070109142130.GA10633@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 22:20:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4OOW-0001NI-5M
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 22:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbXAIVU3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 16:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbXAIVU3
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 16:20:29 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:38674 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932227AbXAIVU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 16:20:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109212028.QNDR2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 16:20:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 99Kd1W00D1kojtg0000000; Tue, 09 Jan 2007 16:19:38 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <20070109142130.GA10633@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 9 Jan 2007 09:21:31 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36402>

Jeff King <peff@peff.net> writes:

> For example, with what's in next now, I can do this:
>
>   git checkout v1.4.0
>   hack hack hack
>   git commit -m -a 'some changes which will never be seen again'
>   git checkout v1.2.0
>
> I thought the _point_ of the safety valve was not to lose those changes.

Fair enough.

We could always do the check upon "git checkout" from a detached
HEAD state, whether it takes you back on some existing branch or
leaves your HEAD still detached.
