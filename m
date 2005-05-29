From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: -p diff output and the 'Index:' line
Date: Sun, 29 May 2005 03:52:38 -0400 (EDT)
Message-ID: <2788.10.10.10.24.1117353158.squirrel@linux1>
References: <20050529071520.GC1036@pasky.ji.cz>
    <7vd5raqy28.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Petr Baudis" <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 09:51:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcIZc-0007rV-Pu
	for gcvg-git@gmane.org; Sun, 29 May 2005 09:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVE2Hwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 03:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVE2Hwp
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 03:52:45 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:15852 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261272AbVE2Hwj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 03:52:39 -0400
Received: from linux1 ([70.50.38.176]) by simmts12-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050529075238.EXQM1005.simmts12-srv.bellnexxia.net@linux1>;
          Sun, 29 May 2005 03:52:38 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4T7qbnb001224;
	Sun, 29 May 2005 03:52:37 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 29 May 2005 03:52:38 -0400 (EDT)
In-Reply-To: <7vd5raqy28.fsf@assigned-by-dhcp.cox.net>
To: "Junio C Hamano" <junkio@cox.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 29, 2005 3:41 am, Junio C Hamano said:
>>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
>
> PB>   What do you think? Would you hate it to show up in the diffs, or are
> PB> you ok with it?
>
> I cannot tell if you are asking about cg-diff or changing the
> built-in diff-* output.  The Subject: line suggests you are
> talking about the latter, but if that is the case I have to
> admit that I am not that sympathetic to Index: nor separator.
>
> Like Linus, I do "/^diff --git .*" in my less sessions, which
> gives a very nice highlighted separator line without wasting a
> single line on the terminal.  If any of the readers on the list
> didn't know about this trick (especially the trailing .* part),
> please try it.  I'm certain everybody would love it.

It's good to know you can wrap this into a shell script too, which saves
you having to type the search string in "less" each time... something
like:

git-diff-tree "$@" | git-diff-helper | less -p "^diff --git .*"

Sean


