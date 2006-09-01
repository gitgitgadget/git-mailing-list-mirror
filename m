From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rev-list(1): group options; reformat; document more options
Date: Thu, 31 Aug 2006 17:06:54 -0700
Message-ID: <7vsljc78m9.fsf@assigned-by-dhcp.cox.net>
References: <20060831223715.GC482@diku.dk>
	<Pine.LNX.4.64.0608311557470.27779@g5.osdl.org>
	<20060831230811.GE482@diku.dk>
	<Pine.LNX.4.64.0608311611440.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>,
	Git Mailing List <git@vger.kernel.org>,
	Timo Hirvonen <tihirvon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 01 02:06:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIwXg-00051l-Tt
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 02:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWIAAFt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 20:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbWIAAFt
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 20:05:49 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:50116 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932496AbWIAAFs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 20:05:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060901000547.GGDC6711.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Thu, 31 Aug 2006 20:05:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Go5n1V00c1kojtg0000000
	Thu, 31 Aug 2006 20:05:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608311611440.27779@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 31 Aug 2006 16:15:39 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26290>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 1 Sep 2006, Jonas Fonseca wrote:
>> Linus Torvalds <torvalds@osdl.org> wrote Thu, Aug 31, 2006:
>> > 
>> > Umm? You should get a "usage" error, no?
>> 
>> Yes, ok, they do not seem to make sense for git-rev-list, however if you
>> pass either to git-log, the output seems to make room for a diff, adding
>> one extra newline, but without appending any diff.
>
> Ahh. I think that a "-r" without any other request for patches (or 
> "--name-status" or similar) should probably imply "--raw". At least that 
> was how it historically worked..
>
> Anyway, _if_ it ever worked (and I think it did, but I'm way too lazy to 
> bother checking), this may have been broken by the extensive diff option 
> cleanups by Timo in June. Timo? Junio?

I think it did too.  I am kind of surprised that nobody noticed
and t4013 test (which was done specifically to catch potential
behaviour change by Timo's patch) did not check for this
particular case.
