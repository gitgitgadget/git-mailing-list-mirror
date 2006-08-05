From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sat, 05 Aug 2006 04:42:29 -0700
Message-ID: <7v64h7e7dm.fsf@assigned-by-dhcp.cox.net>
References: <20060805031418.GA11102@coredump.intra.peff.net>
	<20060805105953.GA5410@moooo.ath.cx>
	<7vejvve8ci.fsf@assigned-by-dhcp.cox.net>
	<20060805112851.GA20807@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 05 13:42:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9KY6-0006YA-NB
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 13:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbWHELmb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 07:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161242AbWHELmb
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 07:42:31 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:41702 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1161200AbWHELmb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 07:42:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060805114230.XTV1537.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 5 Aug 2006 07:42:30 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <20060805112851.GA20807@moooo.ath.cx> (Matthias Lederhofer's
	message of "Sat, 5 Aug 2006 13:28:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24914>

Matthias Lederhofer <matled@gmx.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Matthias Lederhofer <matled@gmx.net> writes:
>> >> Color support is controlled by status.color and status.color.*. There is no
>> >> command line option, and the status.color variable is a simple boolean (no
>> >> checking for tty output).
>> > Is there any way to do isatty() from shell scripts?
>> 
>> Yes.
> How? :)

Arrrrrrrgh!  The message I wanted to send you went to Jeff.

Your Mail-Followup-To: fooled me.  Please do not do this.

$ git grep -B1 'standard input' -- '*.sh'
git-commit.sh-		test -t 0 &&
git-commit.sh:		echo >&2 "(reading log message from standard input)"

> Is there any reason not checking isatty()?

Not that I can think of, but do people really run "git status"?

I think Jeff's follow-up "vim colorizer" makes a lot more sense
than colorizing "git status" output -- it gives reminder during
the last chance the user has to notice such problems, which is
while composing the commit log message.
