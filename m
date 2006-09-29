From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix approxidate() to understand more extended numbers
Date: Fri, 29 Sep 2006 00:09:11 -0700
Message-ID: <7vslibno88.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609281211260.3952@g5.osdl.org>
	<Pine.LNX.4.64.0609281212380.3952@g5.osdl.org>
	<118833cc0609281712u2ce01bc5r8f3e97ae9c9a749a@mail.gmail.com>
	<Pine.LNX.4.64.0609282300190.3952@g5.osdl.org>
	<7vd59fp5b9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609282330440.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 09:09:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTCUp-0007U9-76
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 09:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161461AbWI2HJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 03:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161460AbWI2HJO
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 03:09:14 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:20364 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1161461AbWI2HJN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 03:09:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929070912.DPGV26416.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Sep 2006 03:09:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U7981V00N1kojtg0000000
	Fri, 29 Sep 2006 03:09:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609282330440.3952@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 28 Sep 2006 23:42:19 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28098>

Linus Torvalds <torvalds@osdl.org> writes:

>> > I think 12pm is correct, but 12am probably isn't (12am should _subtract_ 
>> > 12, while 12pm does _not_ add 12).
>> 
>> But you have "if (hour > 0 && hour < 12)" in both am and pm so
>> assignment to tm would not trigger...
>
> That's not the point.
>
> If you write
>
> 	12:30 am
>
> you really _should_ subtract 12, leaving you with 0:30. We don't. So we 
> end up with a 24-hour time of 12:30, which is obviously _pm_, and wrong.
>
> And "12 am" or "12 pm" doesn't work at all.

Ah, that's what you meant.  My brain a bit too tired from the
day job tonight X-<.

>> > That said, I have a rice cooker that avoids the problem by saying "0:10 PM" 
>> > for ten minutes past midday ;)
>> 
>> You eat rice?
>
> Ok, is it just me, or is that just a very odd question?

Having rice cooker implied eating the stuff regularly and I just
did not expect that from a north european.  Just showing my
ignorance -- I've never been to Europe.
