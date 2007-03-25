From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 25 Mar 2007 15:20:40 -0700
Message-ID: <7v648p2cef.fsf@assigned-by-dhcp.cox.net>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
	<7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
	<7v7itx5mep.fsf@assigned-by-dhcp.cox.net>
	<7vps7dle8j.fsf@assigned-by-dhcp.cox.net>
	<7vk5x54snc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703251156530.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 26 00:20:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVb4u-0006Y9-Uj
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 00:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbXCYWUm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 18:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbXCYWUm
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 18:20:42 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57393 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbXCYWUl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 18:20:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070325222041.VFRA321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 25 Mar 2007 18:20:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id fALg1W00d1kojtg0000000; Sun, 25 Mar 2007 18:20:41 -0400
In-Reply-To: <Pine.LNX.4.63.0703251156530.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 25 Mar 2007 11:59:01 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43085>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 25 Mar 2007, Junio C Hamano wrote:
>
>> * jc/fpl (Tue Mar 13 01:57:22 2007 -0700) 1 commit
>>  + git-log --first-parent: show only the first parent log
>> 
>> This makes viewing topic-heavy style of project history pleasant, at 
>> least in my opinion.  With a bit of cheering up, I'd merge it to 
>> 'master', as it has been cooking in 'next' without causing problems, and 
>> is of low-impact kind.  But it can wait until 1.5.1 is done.
>
> *lol* I just tried it on 'next'...
>
> But I agree that it is ready to be merged, and that it is useful.

Hmph.  I am having hard time to decide what to make out of that
"*lol*".  That branch is exactly where this is useful, as it is
a pure integration branch that never gets its own commits (there
is one exception "Revert" that is directly on it, but that is an
exception. And making an exception stand out is also a good
thing). I do not see there is anything to laugh out loudly
about.

On the other hand, running "git log -F master" gives a mixed
picture, as non-merge commits on 'master' are supposed to be
obvious patches that do not need cooking period in 'next', but
without the "pee in the snow merges for fast-forwarding case" we
do not use, commits on a topic that was born and cooked fully
while 'master' was quiescent would also appear on the output,
making it a less useful to tell which ones are "obviously
correct" ones and which ones were cooked in their own topics.
