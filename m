From: Junio C Hamano <junkio@cox.net>
Subject: Re: deprecating more
Date: Fri, 16 Sep 2005 19:29:35 -0700
Message-ID: <7vr7boe8a8.fsf@assigned-by-dhcp.cox.net>
References: <7vd5n8fqso.fsf@assigned-by-dhcp.cox.net>
	<7vzmqceayd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509161856260.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 04:30:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGSSS-0005xz-U9
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 04:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVIQC3i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 22:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVIQC3i
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 22:29:38 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46510 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750823AbVIQC3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 22:29:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050917022937.GUAP6784.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 22:29:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509161856260.26803@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 16 Sep 2005 18:59:24 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8751>

Linus Torvalds <torvalds@osdl.org> writes:

> It's obviously much less powerful than "git-whatchanged", or just about 
> any combination of git-rev-list + git-diff-tree.
>
> So drop it.

I'm happy to hear an argument to drop it, but I would like to
make sure that you do realize that git-whatchanged is not a
convenient way to truly "export" for later recreation of
identical repository, due to its indentation and truncation
behaviour.  Not that *I* think that matters.

What do you think about the other commands I mentioned?
