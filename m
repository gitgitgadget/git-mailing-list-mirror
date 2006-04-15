From: Petr Baudis <pasky@suse.cz>
Subject: Re: Help please :-)
Date: Sat, 15 Apr 2006 21:10:39 +0200
Message-ID: <20060415191039.GC27689@pasky.or.cz>
References: <4d8e3fd30604150908m565e8aaat8ef9846a85c4036e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 15 21:10:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUqA5-00034d-A3
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 21:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWDOTKR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 15:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWDOTKR
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 15:10:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:8937 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751145AbWDOTKP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Apr 2006 15:10:15 -0400
Received: (qmail 21584 invoked by uid 2001); 15 Apr 2006 21:10:39 +0200
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Content-Disposition: inline
In-Reply-To: <4d8e3fd30604150908m565e8aaat8ef9846a85c4036e@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18759>

  Hello,

Dear diary, on Sat, Apr 15, 2006 at 06:08:01PM CEST, I got a letter
where Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> said that...
> I'm used to keep updated my linux tree with cg-status,
> I did that this morning but now I see the following:
> paolo@Italia:~/linux-2.6$ cg-status
> Heads:
>    >master      2c5362007bc0a46461a9d94958cdd53bb027004c
>   R origin      2c5362007bc0a46461a9d94958cdd53bb027004c
> 
> ? arch/i386/kernel/smpboot.c.rej
> ? drivers/md/dm-stripe.c.rej
> ? drivers/net/chelsio/sge.c.rej
> ? drivers/net/e100.c.rej
> ? drivers/net/e1000/e1000_main.c.rej
> ? fs/9p/vfs_dir.c.rej
> ? fs/nfsctl.c.rej
> ? kernel/fork.c.rej
> ? kernel/posix-timers.c.rej
> ? kernel/timer.c.rej
> ? mm/memory.c.rej
> ? mm/mempolicy.c.rej
> ? mm/swap.c.rej
> ? net/ieee80211/ieee80211_crypt_ccmp.c.rej
> ? net/ieee80211/ieee80211_rx.c.rej
> ? scripts/kconfig/lkc_defs.h
> ? scripts/mod/modpost.c.rej
> paolo@Italia:~/linux-2.6$ cg-diff
> 
> I'm a bit lost, the tree is correctly updated, no error message but
> why I see all these .rej?

  you apparently had local changes in your working tree, did cg-update
and then the local changes conflicted with the new changes in Linus'
tree. cg-update should have told you further details.

> And how can I fix this problem?
> git reset and cg-reset don't help...

  cg-clean can remove files not recognized by git.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
