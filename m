From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix approxidate() to understand more extended numbers
Date: Thu, 28 Sep 2006 23:14:50 -0700
Message-ID: <7vd59fp5b9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609281211260.3952@g5.osdl.org>
	<Pine.LNX.4.64.0609281212380.3952@g5.osdl.org>
	<118833cc0609281712u2ce01bc5r8f3e97ae9c9a749a@mail.gmail.com>
	<Pine.LNX.4.64.0609282300190.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 29 08:15:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTBeB-0004gl-B6
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 08:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161182AbWI2GOw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 02:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161271AbWI2GOw
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 02:14:52 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:21751 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1161182AbWI2GOv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 02:14:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929061450.UFW22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Sep 2006 02:14:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U6Em1V00e1kojtg0000000
	Fri, 29 Sep 2006 02:14:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609282300190.3952@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 28 Sep 2006 23:03:11 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28093>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 28 Sep 2006, Morten Welinder wrote:
>>
>> Just don't hack at 12am or 12pm.
>
> I think 12pm is correct, but 12am probably isn't (12am should _subtract_ 
> 12, while 12pm does _not_ add 12).

But you have "if (hour > 0 && hour < 12)" in both am and pm so
assignment to tm would not trigger...

> That said, I have a rice cooker that avoids the problem by saying "0:10 PM" 
> for ten minutes past midday ;)

You eat rice?

> Of course, all sane and civilized countries just use 24-hour format 
> anyway.

You are referring to the US, but neither is Japan sane nor
civilized ;-).
