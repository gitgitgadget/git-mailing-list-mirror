From: Petr Baudis <pasky@suse.cz>
Subject: Re: Linus kernel tree corrupt?
Date: Sun, 10 Jul 2005 17:23:09 +0200
Message-ID: <20050710152309.GE24249@pasky.ji.cz>
References: <9e473391050708085756bd463e@mail.gmail.com> <12c511ca05070810065db87043@mail.gmail.com> <20050709114303.B2175@flint.arm.linux.org.uk> <20050709115530.GC26343@pasky.ji.cz> <42D01174.4050501@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russell King <rmk@arm.linux.org.uk>,
	Tony Luck <tony.luck@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 10 17:23:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrdeQ-0008CS-Nj
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 17:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVGJPXP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 11:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVGJPXP
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 11:23:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:14051 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261956AbVGJPXO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 11:23:14 -0400
Received: (qmail 3912 invoked by uid 2001); 10 Jul 2005 15:23:09 -0000
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <42D01174.4050501@zytor.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jul 09, 2005 at 08:03:32PM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> Petr Baudis wrote:
> >
> >Yes, please do. I deprecated rsync a day before Linus "broke" http-pull.
> >It's un-deprecated again for now in the latest Cogito.
> >
> 
> Presumably for packed repos you want to drop the --ignore-existing 
> --whole-file options I assume?

It _is_ unsafe for individual objects, and your packfile will be corrupt
if you break it in the middle and not have --whole-file turned on, I
assume. It would be ideal if we could make rsync allow resuming download
of the file if interrupted, but not under the final name but in that
hidden file it uses.

> sent 339 bytes  received 1802 bytes  4282.00 bytes/sec
> total size is 410  speedup is 0.19
> Missing object of tag v2.6.11... different source (obsolete tag?)
> Missing object of tag v2.6.11-tree... different source (obsolete tag?)
> Missing object of tag v2.6.12... different source (obsolete tag?)
> Missing object of tag v2.6.12-rc2... different source (obsolete tag?)
> Missing object of tag v2.6.12-rc3... different source (obsolete tag?)
> Missing object of tag v2.6.12-rc4... different source (obsolete tag?)
> Missing object of tag v2.6.12-rc5... different source (obsolete tag?)
> Missing object of tag v2.6.12-rc6... different source (obsolete tag?)
> Missing object of tag v2.6.13-rc1... different source (obsolete tag?)
> Missing object of tag v2.6.13-rc2... different source (obsolete tag?)
> New branch: 0109fd37046de64e8459f8c4f4706df9ac7cc82c
> Cloned (origin 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
> available as branch "origin")
> Cloned to ./ (origin 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
> available as branch "origin")
> 
> Is the "missing objects" thing spurious?

Yes, already fixed. Will release 0.12.1 soon.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
