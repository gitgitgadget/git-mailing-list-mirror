From: Petr Baudis <pasky@suse.cz>
Subject: Re: lost again on syntax change - local repository?
Date: Mon, 28 Nov 2005 11:48:31 +0100
Message-ID: <20051128104831.GN22159@pasky.or.cz>
References: <861x118r9t.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 11:50:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EggYu-0008KC-Qk
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 11:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVK1KsW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 05:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVK1KsW
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 05:48:22 -0500
Received: from w241.dkm.cz ([62.24.88.241]:12515 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751117AbVK1KsV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 05:48:21 -0500
Received: (qmail 22427 invoked by uid 2001); 28 Nov 2005 11:48:31 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <861x118r9t.fsf@blue.stonehenge.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12869>

Dear diary, on Mon, Nov 28, 2005 at 03:01:18AM CET, I got a letter
where "Randal L. Schwartz" <merlyn@stonehenge.com> said that...
>     localhost:..Git/Play/local.git % cg-branch-add origin "$(cd ..; pwd)/remote.git#master"

BTW, it should be fine to just say ../remote.git#master.

>     localhost:..Git/Play/local.git % cg-branch-ls
>     origin  /Users/merlyn/Projects/Git/Play/remote.git#master
>     localhost:..Git/Play/local.git % 
> 
> At this point, I'm where I was before.  And this next step worked,
> although I had to say "origin":
> 
>     localhost:..Git/Play/local.git % cg-push
>     WARNING: I guessed the host:path syntax was used and fell back to the git+ssh protocol.
>     WARNING: The host:path syntax is evil because it is implicit. Please just use a URI.
>     ssh: \033]2;[zsh] localhost: No address associated with nodename
>     fatal: unexpected EOF

I did the exact same sequence of commands and everything works just fine
for me with both the latest master and the latest v0.16. What Cogito
version do you use? Are you sure the origin location is just the local
path at the time of cg-push?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
