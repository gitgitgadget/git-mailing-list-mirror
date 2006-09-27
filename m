From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Tue, 26 Sep 2006 19:31:47 -0700
Message-ID: <7vhcyukpkc.fsf@assigned-by-dhcp.cox.net>
References: <20060926233321.GA17084@coredump.intra.peff.net>
	<20060927002745. 15344.qmail@web51005.mail.yahoo.com>
	<BAYC1-PASMTP084ACE9B12C54DABFE8EB9AE1 A0@CEZ.ICE>
	<20060926205632.5d487cc9.seanlkml@sympatico.ca> <Pine.LNX.4.63.06
	09261746160.22495@qynat.qvtvafvgr.pbz>
	<7vk63qnlc2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609261823540.22495@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 04:31:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSPDF-0001BS-6f
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 04:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWI0Cbu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 22:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWI0Cbt
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 22:31:49 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:37042 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750813AbWI0Cbs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 22:31:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927023148.OKVK6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 22:31:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TEXk1V00m1kojtg0000000
	Tue, 26 Sep 2006 22:31:45 -0400
To: David Lang <dlang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.63.0609261823540.22495@qynat.qvtvafvgr.pbz> (David
	Lang's message of "Tue, 26 Sep 2006 18:31:59 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27850>

David Lang <dlang@digitalinsight.com> writes:

>>> remember that a pach could be merged to many trees in any order. which
>>> merge date do you want to know about?
>>
>> The date that repository I am looking at with gitweb first had
>> that commit, of course.  What other dates did you have in mind?
>
> if that repository is then merged into another one, what date would
> that second one record for that commit? the date it was pulled there?
>
> in many cases this would seem to be useless or distracting information
> (you already display where in the history the merge took place, do you
> really need to attach that date to all changes that arrive from the
> branch?)

Usually, but not on fast forward.

Only when somebody is interested in the particular question
"when did this commit has become part of this branch" it becomes
relevant.  And do not get me wrong.  I am in principle agreeing
with you that this is an extra information for most of the time
-- I even doubt "when did this commit has become part of this
branch" is all that useful.
