From: Timothy Normand Miller <theosib@att.net>
Subject: =?windows-1252?Q?Re=3A_Git_hangs_at_=93Writing_objects=3A_11=25?=
 =?windows-1252?Q?=94?=
Date: Thu, 24 May 2012 21:41:55 -0400
Message-ID: <033AF49C-4CB3-4412-8845-0246D356358C@att.net>
References: <EF4D4C5F-2D6B-46F2-B5A4-9DB1BA55BB6B@att.net> <20120525005156.GC11300@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 25 03:48:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXjdH-0005Lm-K1
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 03:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679Ab2EYBrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 21:47:25 -0400
Received: from nm23.access.bullet.mail.mud.yahoo.com ([66.94.237.88]:27526
	"HELO nm23.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752856Ab2EYBrY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 21:47:24 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 May 2012 21:47:24 EDT
Received: from [66.94.237.201] by nm23.access.bullet.mail.mud.yahoo.com with NNFMP; 25 May 2012 01:41:57 -0000
Received: from [98.139.244.50] by tm12.access.bullet.mail.mud.yahoo.com with NNFMP; 25 May 2012 01:41:57 -0000
Received: from [127.0.0.1] by smtp112.sbc.mail.bf1.yahoo.com with NNFMP; 25 May 2012 01:41:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1337910117; bh=WGbVjHBlDuRGtzUEioj83aQGcye6AmfKhH8AWzCFW+Y=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:Subject:Mime-Version:Content-Type:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:To:X-Mailer; b=nhkluUwXhLCu7Q81LPz+KUj+eYyVu7nhUZ+WIIxzrJVHdAbbWLQ9qeX2Vp6R7gAj0qlBx1ZOZiEjpSLd64Ea4rqBH7A2MTLGye3XJtEDt0MHwdjrBAqLjB5fxH+tB2ayUXkzdlNUhYpvJHlA0/5SB78xLQy2C8/h59RPSy/awe8=
X-Yahoo-Newman-Id: 62904.36847.bm@smtp112.sbc.mail.bf1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: CCrROagVM1ko2etdnDvNMT0QXT1eLt.FAhuJE9qXkgHFFKT
 1kKScVqmCLvdhpXU6Lgw5W6l1EUt9oygMf5GAzJYweE8soU3e5o0bWBBEBiB
 di5kCMZ9iOK0aJq6LpqyHOj0GeJa6r3X964WIJcMc7ElKa49IG8pvruZLuyS
 sHQn0_U19gpJ4hqs253GWuo6IK5F3pTctD2blW0JMT4OIy9sr3kzpNLMvnwM
 wuU7FzPWcAUbL4NSTBp6d23Uc1sFtJspXveKX6.h6hVi3IDmBjJrtYcCdmrM
 4U5FaDKaaEau4OufeCE94NBObD3M3kaj3N0kgqNM3ee3BaLRNUauAgIY5o1N
 ofvjWVTE3.SCceNG8WLMzYTImxAfQb6QgEGZkJprECYxNRlzsmWND.FWRppN
 WlTSVB98klmnzU.KKSkEanE2jWjvJNB8B6skXu.OQBgNOVY.Ar.PZ6w8lEaY
 laOwDDlxKgcSLDXnlpsciPVussNtiinzUj_AiyGUbdhP.F9QdAgeg0SvYLQm
 MKmkmrmbFj3yScuUQ7GsBcQISiuA3HPyn3jLl3gd_e.rDTB31
X-Yahoo-SMTP: fnCipqKswBBOUfpM7XF4CajMkMYSy.KS.UTLsA--
Received: from [192.168.1.107] (theosib@76.232.38.36 with plain)
        by smtp112.sbc.mail.bf1.yahoo.com with SMTP; 24 May 2012 18:41:56 -0700 PDT
In-Reply-To: <20120525005156.GC11300@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198460>


On May 24, 2012, at 8:51 PM, Jeff King wrote:

> On Thu, May 24, 2012 at 05:40:41PM -0400, Timothy Normand Miller wrote:
> 
>> I've run into a problem that I cannot debug.  I've talked with people
>> at length on IRC, I've made ample use of Google.  I'm getting nowhere.
>> I'm not even getting any attention on stackexchange (where usually,
>> questions are answered with surprising alacrity).  
>> 
>> This is not the common scenario of Windows and git-daemon that I have
>> seen answered elsewhere. This is Linux to Linux, using ssh. On both
>> the client and server, git version is 1.7.8.6.

Thank you for helping!

> 
> I'd first start with trying to remove as many variables as possible.
> Does the problem only happen over ssh, or does it also happen when
> pushing across a pipe to a repo on the local machine? If so, does it
> also happen during a fetch of the same data?

If the local repo I'm pushing to is given by pathname, it's fine.  If I'm pushing to another account via ssh on the localhost, it has the same hangup.

All fetches work fine.

> 
> If you can reproduce it at will (which it sounds like you can), you
> could also try some older or newer git versions to see if they work any
> better. If you can find a working version, it might be worth trying to
> bisect and find the commit that introduces the breakage.

There's this one CentOS 6 machine where I know for a fact that git hasn't been updated since I was last able to push this particular repo.  That machine has git version 1.7.1.  That's where I first encountered the problem.  So I copied the repo to my Mac (version 1.7.8.6), but it freezes there at 11%.  Then I tried copying it to the same machine that hosts the repo (Gentoo Linux with git version 1.7.8.6), and push from there (still using ssh, but locally), and it also freezes at 11%.

So there's something wonky about the repo that git doesn't like, although it only has the problem over ssh.  I haven't tried git's native protocol.

> 
> If the problem still exists in the latest version, then I'd start by
> stracing as much as possible. On the client side, you can use "strace
> -f" to see what all of the processes are doing; you'll probably also
> want to pass:
> 
>  --receive-pack='strace -f -o foo.out git-receive-pack'

First, I ran the push and then killed it, and I got this:	
http://www.cse.ohio-state.edu/~millerti/foo.out

But then I realized that you'd want to see where it hung up, so I can it again and then sent the file before killing the push:
http://www.cse.ohio-state.edu/~millerti/foo2.out


> 
> to git-push to ask the remote side to strace. There's a reasonable
> chance you'll simply see that the client side is waiting on the server
> side for I/O, so you'll want to know what the server side is doing.

I really don't know how to interpret the trace.

> 
> I see you posted an strace snippet of a process waiting in select() on
> stack overflow. It's hard to tell what's going on from there, though,
> because we can't see which processes are which (we see the pids, but we
> don't know which programs they're running, or where the commands go). A
> full strace log would help a lot (if it's long and you need a place to
> post it, try something like https://gist.github.com).

Try this:
http://www.cse.ohio-state.edu/~millerti/revue_strace3.txt

This one was from earlier in the day.  It's from a push from the same machine that hosts the repo.

> 
> And finally, if the repo is something you can make public, I can try to
> reproduce on my machine. That might tell us if the problem is with your
> repo, or something else about your machines or setup.

That would make things a lot easier, but I'm not at liberty to share it.


Thanks again!
