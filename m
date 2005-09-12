From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add "git grep" helper
Date: Mon, 12 Sep 2005 14:45:26 -0700
Message-ID: <7vbr2y7yfd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509121203210.4098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 23:46:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEw7I-0002VY-5b
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 23:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVILVp3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 17:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVILVp3
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 17:45:29 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:28570 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932159AbVILVp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 17:45:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912214525.KEFM17436.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 17:45:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509121203210.4098@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 12 Sep 2005 12:06:10 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8440>

Linus Torvalds <torvalds@osdl.org> writes:

> Very convenient shorthand for
>
> 	git-ls-files [file-patterns] | xargs grep <pattern>
>
> which I tend to do all the time.

Great minds think alike.  I stopped using 'grep-find' in Emacs
and use "git-ls-fiels -z | xargs -0 grep" instead these days.
Thanks for the patch; applied.

I do not much care about other grep flags but I think you forgot
to special case '-e', so what is in the "master" branch has one
extra commit on top of it for that (it does not seem to have
percolated down yet).
