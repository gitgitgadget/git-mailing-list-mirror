From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git repository
Date: Sat, 15 Oct 2005 16:48:06 -0700
Message-ID: <7vr7amjqa1.fsf@assigned-by-dhcp.cox.net>
References: <7vwtkfpbyk.fsf@assigned-by-dhcp.cox.net>
	<46a038f90510142340r2fe24ce6j5d0d96535fbb2517@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 01:48:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQvlU-0006UL-VU
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 01:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVJOXsJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 19:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVJOXsJ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 19:48:09 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:6571 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751251AbVJOXsI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 19:48:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051015234756.HPBD9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Oct 2005 19:47:56 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10151>

Martin Langhoff <martin.langhoff@gmail.com> writes:

>> I'd have this graduate to the "master" branch after some more
>> testing, only if people are interested in it; otherwise I'm
>> thinking about dropping this (I am not particularly interested
>> in this enhancement myself).
>
> Fair enough -- it simplifies (and speeds up) the git-findtags script I
> posted. Actually, it makes it redundant. But if it's not
> elegant/needed/wanted in the C core, git-findtags can deal with it in
> the soft and sloppy sphere of perl scripts.
> Most people don't need this at all, and I guess that's why we managed
> so long without it. But I think it's a basic plumbing service.

Oh, I did not mean that I did not *like* the implementation or
feature.  I just was unsure if that was what you and Pasky would
find useful.

I was trying to add something that would be useful in general,
but if what I did was missing the mark and wasn't something you
two found useful, there was no need to add it.

So, thanks for the feedback and background rationale.  Let's
have it in "master" then.
