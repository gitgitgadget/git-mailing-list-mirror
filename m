From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] apply.c: a fix and an enhancement
Date: Fri, 22 Jul 2005 15:55:41 -0700
Message-ID: <7vfyu6jvrm.fsf@assigned-by-dhcp.cox.net>
References: <7vzmsewzik.fsf@assigned-by-dhcp.cox.net>
	<20050722181800.GU20369@mythryan2.michonline.com>
	<7vsly6vd2b.fsf@assigned-by-dhcp.cox.net> <42E1571B.8070108@gmail.com>
	<Pine.LNX.4.58.0507221340450.6074@g5.osdl.org>
	<7vhdempmgg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507221447420.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 00:56:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw6Qw-0000Tq-Gj
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 00:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVGVWzq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 18:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVGVWzq
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 18:55:46 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:5871 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261410AbVGVWzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 18:55:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050722225540.XDVA22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 18:55:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507221447420.6074@g5.osdl.org> (Linus Torvalds's message of "Fri, 22 Jul 2005 14:53:41 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> I'd _really_ prefer to not have any preferences or other metadata files
> under version control within that same project.

Don't you think that would be a per-project decision?  Is it
acceptable if I make sure that .gitinfo/* is _optional_ and
things do not break for projects that do not use it?

I hope you are not vetoing the ongoing discussion in another
thread from including the per-project configuration.

Some people want to run their project differently, and one thing
I see often done is to have pre-commit hooks that always run
test suites [*1*].  I do not think it is an unreasonable thing for
Porcelains to support, and what I am trying to get at is if two
Porcelains decide to support it, they do it in a compatible way.

> And personal preferences are just that - personal. I do _not_ want to have 
> the kernel project history have things like "editor preferences" etc in 
> the revision history - you might want to revision them, but that would be 
> totally independent of the history of the project itself.

I agree.  The .gitinfo/fake-parents may be a good thing in that
sense to have project-wide, and as long as the kernel person
(that is you) do not add .gitinfo/commit-template you would be
happy, wouldn't you?


[Footnote]

*1* Personally sometimes I feel myself that is silly, but that
is _other_ people's project, not my own.  I think letting them
follow their own workflow to slow themselves is better than
outright forbidding it and telling them not to do it.
