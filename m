From: Junio C Hamano <junkio@cox.net>
Subject: [OT] if (4 < number_of_children) you're in trouble
Date: Sat, 28 May 2005 00:55:44 -0700
Message-ID: <7vfyw7yebj.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org>
	<7vekbwru6x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241814220.2307@ppc970.osdl.org>
	<7v3bscqdlr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 09:54:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbw8p-0004JX-6C
	for gcvg-git@gmane.org; Sat, 28 May 2005 09:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVE1Hz4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 03:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVE1Hzz
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 03:55:55 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:31888 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261858AbVE1Hzp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 03:55:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050528075545.MRNT26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 May 2005 03:55:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v3bscqdlr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 24 May 2005 18:49:20 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I received this from my mentor tonight.  Although I said I am
not going to discuss this issue anymore, with his permission, I
would like to share where the "visual order" came from with the
list.

From: Paul Eggert <eggert@CS.UCLA.EDU>
Subject: Re: FYI: comparison order in boolean expressions
To: Junio C Hamano <junkio@cox.net>
Date: Sat, 28 May 2005 00:28:31 -0700

> http://marc.theaimsgroup.com/?l=git&m=111698274620068&w=2

Thanks!  That made my day.

You can forward the following to that mailing list if you like:


I learned the "textual order should reflect actual order" convention
from D. Val Schorre, one of the best programmers I've ever worked
with.  Val was credited by Donald E. Knuth as the first person to
seriously advocate goto-less programming.  In 1974 Knuth wrote:

  When I met Schorre in 1963, he told me of his radical ideas, and I
  didn't believe they would work....  In 1964 I challenged him to
  write a program for the eight-queens problem without using go to
  statements, and he responded with a program using recursive
  procedures and Boolean variables, very much like the program later
  published independently by Wirth.

  I was still not convinced....

Knuth's reaction to Schorre's ideas on avoiding gotos sounds a bit
like Linus's reaction to Schorre's ideas on comparison order, no?

Anyway, here's the reference, if you'd like to find out how Knuth's
story ends:

  Donald E. Knuth
  Structured Programming with go to Statements
  ACM Computing Surveys 6, 4 (December 1974), 261-301.
  http://portal.acm.org/citation.cfm?id=356640


PS.  The idea that textual form should reflect the underlying reality
goes all the way back to Gottfried Leibniz's alphabet of human thought
<http://en.wikipedia.org/wiki/Alphabet_of_human_thought>.  Leibniz was
a brilliant designer of notations -- one of the best the world has
ever seen -- and it is amusing to speculate what he would have done
with programming had he been born some time in the past few decades.
(Personally I suspect that Leibniz would have liked "1 < x".)





