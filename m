From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] add strcpy_user_path() and use it in init-db.c and git.c
Date: Sat, 24 Dec 2005 13:19:25 -0800
Message-ID: <20051224211925.GH3963@mail.yhbt.net>
References: <20051224122016.GD3963@mail.yhbt.net> <7virtes6zd.fsf@assigned-by-dhcp.cox.net> <20051224195033.GE3963@mail.yhbt.net> <7vu0cyqk5d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 24 22:19:32 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqGnY-00045N-VF
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 22:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVLXVT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 16:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVLXVT0
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 16:19:26 -0500
Received: from hand.yhbt.net ([66.150.188.102]:46979 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1750717AbVLXVT0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2005 16:19:26 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 877AE7DC005; Sat, 24 Dec 2005 13:19:25 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0cyqk5d.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14037>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > My home directories have different names on different machines I'm
> > on, and I want to avoid having to recompile git for each one.
> > I don't have root access to some of them, so installing globally in /usr
> > or /usr/local isn't an option, either.
> 
> Then you probably need to use GIT_EXEC_PATH environment
> variable.

That works with git.c but not init-db.  But then again I don't use
git-init-db that often.  I'll just write a shell script wrapper for the
latter if I do.

No need for this patch anymore :)

-- 
Eric Wong
