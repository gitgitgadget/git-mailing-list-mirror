From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Help please :-)
Date: Sat, 15 Apr 2006 18:08:01 +0200
Message-ID: <4d8e3fd30604150908m565e8aaat8ef9846a85c4036e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Apr 15 18:08:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUnJg-0005YP-FE
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 18:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWDOQID (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 12:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbWDOQID
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 12:08:03 -0400
Received: from pproxy.gmail.com ([64.233.166.177]:9189 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030283AbWDOQIC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 12:08:02 -0400
Received: by pproxy.gmail.com with SMTP id i49so312967pye
        for <git@vger.kernel.org>; Sat, 15 Apr 2006 09:08:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Rle71BG7RSZi3rUK14kI8UnVRXnRL9mg4jnL7zTEbvJAbzXKXLX7RcFLLUZzJfyrMvcyQB50NIu41DEvQkkXyXbInJ85DVwaQHOX6EVnCJHkYHGv5ToecNKRxZqqYVNEZ9I4KXE4/K0+y8sh8y3Sek0oWoi429AYBycWqR89CcE=
Received: by 10.35.84.16 with SMTP id m16mr1914984pyl;
        Sat, 15 Apr 2006 09:08:01 -0700 (PDT)
Received: by 10.35.121.5 with HTTP; Sat, 15 Apr 2006 09:08:01 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18751>

Hi all,
I'm used to keep updated my linux tree with cg-status,
I did that this morning but now I see the following:
paolo@Italia:~/linux-2.6$ cg-status
Heads:
   >master      2c5362007bc0a46461a9d94958cdd53bb027004c
  R origin      2c5362007bc0a46461a9d94958cdd53bb027004c

? arch/i386/kernel/smpboot.c.rej
? drivers/md/dm-stripe.c.rej
? drivers/net/chelsio/sge.c.rej
? drivers/net/e100.c.rej
? drivers/net/e1000/e1000_main.c.rej
? fs/9p/vfs_dir.c.rej
? fs/nfsctl.c.rej
? kernel/fork.c.rej
? kernel/posix-timers.c.rej
? kernel/timer.c.rej
? mm/memory.c.rej
? mm/mempolicy.c.rej
? mm/swap.c.rej
? net/ieee80211/ieee80211_crypt_ccmp.c.rej
? net/ieee80211/ieee80211_rx.c.rej
? scripts/kconfig/lkc_defs.h
? scripts/mod/modpost.c.rej
paolo@Italia:~/linux-2.6$ cg-diff

I'm a bit lost, the tree is correctly updated, no error message but
why I see all these .rej?
And how can I fix this problem?
git reset and cg-reset don't help...

Thanks!


--
Paolo
http://paolociarrocchi.googlepages.com
