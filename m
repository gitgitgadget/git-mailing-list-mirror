From: Junio C Hamano <junkio@cox.net>
Subject: Re: strange behavior when pulling updates / get uptodate with git.git
Date: Sat, 08 Apr 2006 13:55:28 -0700
Message-ID: <7vmzeveqin.fsf@assigned-by-dhcp.cox.net>
References: <4438158C.1080208@iaglans.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 08 22:55:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSKT3-00035y-A1
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 22:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWDHUza (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 16:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWDHUza
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 16:55:30 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:10921 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751428AbWDHUz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Apr 2006 16:55:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060408205529.SMSG17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Apr 2006 16:55:29 -0400
To: Nicolas Vilz 'niv' <niv@iaglans.de>
In-Reply-To: <4438158C.1080208@iaglans.de> (Nicolas Vilz's message of "Sat, 08
	Apr 2006 21:57:00 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18529>

Nicolas Vilz 'niv' <niv@iaglans.de> writes:

> URL: git://git.kernel.org/pub/scm/git/git.git
> Pull: refs/heads/master:refs/heads/origin
> Pull: refs/heads/todo:refs/heads/todo
> Pull: refs/heads/maint:refs/heads/maint
> Pull: refs/heads/pu:refs/heads/pu
> Pull: refs/heads/man:refs/heads/man
> Pull: refs/heads/next:refs/heads/next
> Pull: refs/heads/html:refs/heads/html
>
> so i suppose, if i try to pull origin, and i am in master, i should be
> able to pull these remote heads each in the correct local head...
>
> But I obviously don't.

Most likely it is aborted by the "pu" branch not
fast-forwarding.

	Pull: +refs/heads/pu:refs/heads/pu

or dropping "pu" altogether if you are not interested in it,
would help.  My repositories (the ones I fetch/pull from for
testing) have only these:

        URL: git://git.kernel.org/pub/scm/git/git.git
        Pull: refs/heads/master:refs/heads/origin
        Pull: refs/heads/next:refs/heads/next
        Pull: +refs/heads/pu:refs/heads/pu
        Pull: refs/heads/maint:refs/heads/maint
