From: Junio C Hamano <junkio@cox.net>
Subject: Re: What is in git.git
Date: Sat, 21 Jan 2006 14:22:48 -0800
Message-ID: <7vu0bxjk5j.fsf@assigned-by-dhcp.cox.net>
References: <7v3bjiuhxb.fsf@assigned-by-dhcp.cox.net>
	<200601211636.02340.lan@ac-sw.com>
	<7vek31mkyg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 23:22:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0R8I-0002ka-13
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 23:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWAUWWu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 17:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWAUWWu
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 17:22:50 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:221 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751207AbWAUWWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 17:22:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121222022.ZJHU17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 17:20:22 -0500
To: Alexander Litvinov <lan@ac-sw.com>
In-Reply-To: <7vek31mkyg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 21 Jan 2006 11:37:11 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15026>

Junio C Hamano <junkio@cox.net> writes:

> Alexander Litvinov <lan@ac-sw.com> writes:
>...
>> subpro and main are separate projects and master is the join
>> of them. If I want to modify subpro I have to checkout subpro
>> branch, edit files. When I have to got to master and bind new
>> version of subpro to it.
>
> I do not see any problem with this....
>...
>> Worse, if I will edit subpro's files bined to master branch
>> changes will go to master branch instead of subpro's history.
>
> Simply untrue.

Sorry, these came out somewhat in a wrong way, so let me
clarify.

What I meant was that there isn't anything coded so far that
makes your worries real issues yet, and I do not intend to code
Porcelainish scripts that are broken in the ways you see as
problems in your message.

The point you raised are valid concerns.  You need to keep them
in mind when you start writing subproject aware version of
git-checkout, git-commit and git-merge commands (among other
things I might have forgotten, but I think these three covers
pretty much everything).  You are welcome to beat me to it,
since I am not planning to do them right away.
