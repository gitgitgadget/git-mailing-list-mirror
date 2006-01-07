From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-mv.perl: use stderr for error output and cleanup
Date: Fri, 06 Jan 2006 16:46:25 -0800
Message-ID: <7v4q4grhjy.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601050349s6bec1a36jc410fd315fbbc4c@mail.gmail.com>
	<7vek3lq8wu.fsf@assigned-by-dhcp.cox.net>
	<86wthd7ypx.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0601061525100.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 01:46:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev2E3-0004cM-Kr
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 01:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965381AbWAGAq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 19:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965383AbWAGAq3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 19:46:29 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:49640 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S965381AbWAGAq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 19:46:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107004430.TMUT26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 Jan 2006 19:44:30 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601061525100.3169@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 6 Jan 2006 15:28:53 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14233>

Linus Torvalds <torvalds@osdl.org> writes:

>> After all, that's spelled "f o r", but pronounced "foreach". :)
>
> It is official: perl people are crazy.

I sometimes pronounce "foreach" when I see "ef oh ar" in Perl
programs, but I do not do that aloud around other people.

My point was that things like this:

>>   print H "$_\0" for @deletedfiles;

is perfectly fine among Perl people (and I would probably even
encourage rewriting git-*.perl scripts in more Perlish style if
the project were about an SCM primarily targetted for Perl
people --- it is not), but look obfuscated without merit to
people who do not talk Perl.
