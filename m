From: Pavel Machek <pavel@suse.cz>
Subject: Re: hgmq vs. StGIT
Date: Thu, 10 Nov 2005 01:08:04 +0100
Message-ID: <20051110000804.GL12459@elf.ucw.cz>
References: <20051101090804.GA11618@pasky.or.cz> <b0943d9e0511010123i1f9eb679w@mail.gmail.com> <436787BD.9080705@citi.umich.edu> <20051101153650.GB26847@watt.suse.com> <b0943d9e0511010918ob2dbcfcv@mail.gmail.com> <20051101181352.GD26847@watt.suse.com> <b0943d9e0511011330v7045c568u@mail.gmail.com> <20051102154108.GM26847@watt.suse.com> <b0943d9e0511051223g74c2be43h@mail.gmail.com> <20051109233255.GI30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Chris Mason <mason@suse.com>, Chuck Lever <cel@citi.umich.edu>,
	Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 01:09:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea00Q-0007g0-FL
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 01:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbVKJAJ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 19:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVKJAJ0
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 19:09:26 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35512 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750940AbVKJAJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 19:09:25 -0500
Received: by amd.ucw.cz (Postfix, from userid 8)
	id 85E988AF42; Thu, 10 Nov 2005 01:08:04 +0100 (CET)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051109233255.GI30496@pasky.or.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11451>

Hi!

> Dear diary, on Sat, Nov 05, 2005 at 09:23:33PM CET, I got a letter
> where Catalin Marinas <catalin.marinas@gmail.com> said that...
...
> A night city, the snow slowly falling. Approaching the roofs covered in
> white and illuminated by the yellow street lighting, dark windows - but
> one dimly glowing, a computer screen inside. Close-up on a hacker:
> $EDITOR opened, lost deep in hack mode, fingers dancing over the
> keyboard.  Dreamy-monumental music in the background.
> 
> StGIT user, only part of the patches in stack, and the rest depends on
> the one currently edited, and I want to record my work on this one.
> I can either:

Are you sure you are git hacker? Maybe you should have been fiction
writer :-).

> (i) Just keep per-patch history only.
> 
> (ii) Keep _both_ per-patch and per-stack history (since I don't want to
> record the stack when I have to keep some patches out of it - the
> history would look like randomly removing and adding tons of patches,
> and jumping around would be difficult because of this too).
> 
> (iii) Keep per-patchlist history - do not actually record only our
> current stack, but all the patches StGIT knows about. The patches
> depending on the one currently being changed will not be in consistent
> state, but that's tough. Actually, this seems to be the most viable
> strategy. One question is whether to record if some patch is actually
> applied right now or not (I'd say don't record it since you again have
> the "bouncing problem" otherwise).

I do not know if ii or iii is better, but please *do* record what
patches were applied at what moment. That is useful info. "I'd like to
go back to know working configuration". If I do not know what patches
were applied at what moment, going back to working config is hard to
do.
								Pavel
-- 
Thanks, Sharp!
