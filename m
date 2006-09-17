From: Jon Loeliger <jdl@jdl.com>
Subject: Re: Setting up Password protected repositories?
Date: Sun, 17 Sep 2006 11:22:03 -0500
Message-ID: <E1GOzP9-0001Fn-G8@jdl.com>
References: <E1GOktx-0005JY-ER@jdl.com> <7virjn8eua.fsf@assigned-by-dhcp.cox.net> <E1GOm3h-0005jq-5u@jdl.com>  <20060917022013.GA7512@spearce.org>
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 18:22:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOzPb-0006fS-8T
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 18:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWIQQWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 12:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWIQQWK
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 12:22:10 -0400
Received: from colo.jdl.com ([66.118.10.122]:29387 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S964993AbWIQQWJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 12:22:09 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1GOzP9-0001Fn-G8; Sun, 17 Sep 2006 11:22:04 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: Your message of "Sat, 16 Sep 2006 22:20:14 EDT."
             <20060917022013.GA7512@spearce.org> 
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27196>

So, like, the other day Shawn Pearce mumbled:
> > > 
> > > Or am I missing something deeper?

Hmmm... Maybe _I_ am!...

> > I want git-daemon to serve up the repository.
> > I just want to have it served to people who can
> > supply a password or have an ssh key in place.
> 
> Don't use git-daemon.

Say that again?  It sounded like you said "Don't use git-daemon."

> Instead create UNIX accounts for the people who need access and if
> you don't want them to actually be able to login set their shell
> to be `git-sh`.  This is a special shell-like thing that only lets
> the user push or fetch to any repository they have access to.

Yeah, I think I'm getting it now.  Don't use git-daemon, and
instead set up UNIX accounts with git-sh as their shell.  That
will let them push and fetch from a repository they can access.

> The URL is a 'git+ssh' style URL and they will use SSH to connect.

Ahhh...  Straight ssh to git-sh, no git daemon or HTTP in the mix.

> Access is controlled by standard UNIX user/group read/write access
> and ACLs if your OS/filesystem support them.  You can also control
> pushing with an update hook.

OK.  I seem to recall a recipe down this line somwhere...  Is there
a current "Best Practices" write up somewhere with these details
outlined in it?

So slowly we are clued...

Thanks,
jdl
