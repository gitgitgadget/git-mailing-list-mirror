From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] detached HEAD -- finishing touches
Date: Thu, 01 Feb 2007 18:38:51 -0800
Message-ID: <7vwt31l1vo.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home>
	<20070131231942.GB31145@coredump.intra.peff.net>
	<Pine.LNX.4.64.0701311907500.3021@xanadu.home>
	<20070201030030.GA1979@coredump.intra.peff.net>
	<7vd54ur26u.fsf@assigned-by-dhcp.cox.net>
	<7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net>
	<20070201215242.GA1775@thunk.org>
	<7v64alnz2q.fsf@assigned-by-dhcp.cox.net>
	<87ejp99wn7.wl%cworth@cworth.org>
	<7virelmjlr.fsf@assigned-by-dhcp.cox.net>
	<87d54t9vs7.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 03:39:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCoKQ-0003sT-9E
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 03:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423080AbXBBCjA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 21:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423081AbXBBCjA
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 21:39:00 -0500
Received: from fed1rmmtai20.cox.net ([68.230.241.39]:63346 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423080AbXBBCi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 21:38:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070202023851.TEJH1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Feb 2007 21:38:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JSes1W00G1kojtg0000000; Thu, 01 Feb 2007 21:38:52 -0500
In-Reply-To: <87d54t9vs7.wl%cworth@cworth.org> (Carl Worth's message of "Thu,
	01 Feb 2007 17:46:00 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38451>

Carl Worth <cworth@cworth.org> writes:

> On Thu, 01 Feb 2007 17:30:40 -0800, Junio C Hamano wrote:
>> I do not think of any offhand, but "did we make commit since we
>> detached HEAD" was not a suggestion I made, so what I can think
>> of does not matter much ;-).
>
> Well, the suggestion I made was to:
>
> 1. Print the name of the commit we are leaving
>
> 2. Refuse to leave if what we are leaving would leave commits
>    dangling, (and print a revision specification for those set of
>    commits).
>
> Do you have a reaction to that?

Not having thought things through, I am very tempted to say that
we can leave things as they are, and when the reflog for HEAD
materializes, just remove the check from the codepath that makes
your HEAD point at an existing branch again.  With the reflog on
HEAD, you do not need to be reminded of which commit you are
leaving so there is no need for 1 above, and you would not lose
your point (either connected or disconnected) so there is no
need for 2 above either.
