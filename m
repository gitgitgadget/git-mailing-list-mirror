From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: Help please :-)
Date: Sun, 16 Apr 2006 11:30:07 +0200
Message-ID: <4d8e3fd30604160230g45a67efh9027a7e292e42f3c@mail.gmail.com>
References: <4d8e3fd30604150908m565e8aaat8ef9846a85c4036e@mail.gmail.com>
	 <20060415191039.GC27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 16 11:30:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FV3aD-0000Cl-Od
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 11:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWDPJaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 05:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWDPJaJ
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 05:30:09 -0400
Received: from pproxy.gmail.com ([64.233.166.179]:29928 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751459AbWDPJaH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Apr 2006 05:30:07 -0400
Received: by pproxy.gmail.com with SMTP id i49so419829pye
        for <git@vger.kernel.org>; Sun, 16 Apr 2006 02:30:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MlV4Qg3MYOGxl04Sr7Z/uZM/VSn3aqFzzqnE/R01vTExux1V6WTcGB4SXbWFmBOmS3PkXGLsQQpVZjMtr2mL7aCr4/AIfP9ZVI0Bbz4hPNvHpQNtltTC6Vc0ZJ4zcDAoLPXaICMd1SSHqLuezNoAB+5Notsj1LvVQ9tWhNDQefw=
Received: by 10.35.82.15 with SMTP id j15mr1896708pyl;
        Sun, 16 Apr 2006 02:30:07 -0700 (PDT)
Received: by 10.35.121.5 with HTTP; Sun, 16 Apr 2006 02:30:07 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060415191039.GC27689@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18776>

On 4/15/06, Petr Baudis <pasky@suse.cz> wrote:
>   Hello,
>
> Dear diary, on Sat, Apr 15, 2006 at 06:08:01PM CEST, I got a letter
> where Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> said that...
> > I'm used to keep updated my linux tree with cg-status,
> > I did that this morning but now I see the following:
> > paolo@Italia:~/linux-2.6$ cg-status
> > Heads:
> >    >master      2c5362007bc0a46461a9d94958cdd53bb027004c
> >   R origin      2c5362007bc0a46461a9d94958cdd53bb027004c
> >
> > ? arch/i386/kernel/smpboot.c.rej
> > ? drivers/md/dm-stripe.c.rej
> > ? drivers/net/chelsio/sge.c.rej
> > ? drivers/net/e100.c.rej
> > ? drivers/net/e1000/e1000_main.c.rej
> > ? fs/9p/vfs_dir.c.rej
> > ? fs/nfsctl.c.rej
> > ? kernel/fork.c.rej
> > ? kernel/posix-timers.c.rej
> > ? kernel/timer.c.rej
> > ? mm/memory.c.rej
> > ? mm/mempolicy.c.rej
> > ? mm/swap.c.rej
> > ? net/ieee80211/ieee80211_crypt_ccmp.c.rej
> > ? net/ieee80211/ieee80211_rx.c.rej
> > ? scripts/kconfig/lkc_defs.h
> > ? scripts/mod/modpost.c.rej
> > paolo@Italia:~/linux-2.6$ cg-diff
> >
> > I'm a bit lost, the tree is correctly updated, no error message but
> > why I see all these .rej?
>
>   you apparently had local changes in your working tree, did cg-update
> and then the local changes conflicted with the new changes in Linus'
> tree. cg-update should have told you further details.

Can this be due an interrupted cg-update?
However, cg-update did not complain.

> > And how can I fix this problem?
> > git reset and cg-reset don't help...
>
>   cg-clean can remove files not recognized by git.

Thanks!

Ciao,
--
Paolo
http://paolociarrocchi.googlepages.com
