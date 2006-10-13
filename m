From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Thu, 12 Oct 2006 18:45:56 -0700
Message-ID: <7vmz81dm3v.fsf@assigned-by-dhcp.cox.net>
References: <7vzmc1jcz0.fsf@assigned-by-dhcp.cox.net>
	<20061013010402.99837.qmail@web31814.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 04:05:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYC7c-00072j-JG
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 03:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWJMBp6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 21:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWJMBp6
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 21:45:58 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:21147 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751453AbWJMBp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 21:45:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061013014557.JNIJ12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Oct 2006 21:45:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Zdll1V01M1kojtg0000000
	Thu, 12 Oct 2006 21:45:46 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20061013010402.99837.qmail@web31814.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Thu, 12 Oct 2006 18:04:02 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28827>

Luben Tuikov <ltuikov@yahoo.com> writes:

> That is, you start a group, only when the previous commit differs
> from this commit.
>
> It would be prudent to print a <num lines> iff a group is started.

Yes.  I think the current code does that.

>> we add "ciff" to pick more than one paths from the same commit.
>> In such a case, most likely we are better off not to repeat
>> header fields from author...committer-tz and summary but we
>> would need filename.  The expectation to the Porcelains is:
>> 
>>    Read one line, which begins with commit object name and two
>>    or three numbers; if it has three numbers, it is the
>>    beginning of a group.
>
> And if it doesn't have three numbers?

It can still have header if we wanted to say some more details
about the line.  What's the problem?
