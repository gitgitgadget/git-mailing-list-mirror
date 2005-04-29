From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 04:40:16 -0400 (EDT)
Message-ID: <1680.10.10.10.24.1114764016.squirrel@linux1>
References: <20050426004111.GI21897@waste.org>
    <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
    <20050429060157.GS21897@waste.org>
    <3817.10.10.10.24.1114756831.squirrel@linux1>
    <20050429074043.GT21897@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 10:35:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRQxo-0005tb-Op
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 10:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbVD2Ik2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 04:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVD2Ik2
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 04:40:28 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:25999 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262473AbVD2IkS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 04:40:18 -0400
Received: from linux1 ([67.71.124.169]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050429084017.ZEGM1623.simmts8-srv.bellnexxia.net@linux1>;
          Fri, 29 Apr 2005 04:40:17 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j3T8eGw9027371;
	Fri, 29 Apr 2005 04:40:16 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Fri, 29 Apr 2005 04:40:16 -0400 (EDT)
In-Reply-To: <20050429074043.GT21897@waste.org>
To: "Matt Mackall" <mpm@selenic.com>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, April 29, 2005 3:40 am, Matt Mackall said:

> This trade-off FAILS, as my benchmarks against Mercurial have shown.
> It trades 10x disk space for maybe 10% performance relative to my
> approach. Meanwhile, it makes a bunch of other things hard, namely the
> ones I've listed. Yes, you can hack around them, but the back end will
> still be bloated.

But since performance can be seen as worth so much more than disk, this
might still be a good tradeoff, even given your numbers.


> Mercurial is even younger (Linus had a few days' head start, not to
> mention a bunch of help), and it is already as fast as git, relatively
> easy to use, much simpler, and much more space and bandwidth
> efficient.


There are some really nice things about the git design, not just
performance related.   However, i have a git repository going back to the
start of 2.4 and for my uses there aren't any performance problems.  (okay
fsck-cache, gets oom killed but i suspect that can be fixed).

No _argument_ is going to change the fundamental design of git, it is what
it is.  Git started out as just an interim fix and maybe that's all it
will turn out to be.  But it's working pretty well so far, with lots of
room for improvement over time, and in my estimation Linus has made a
pretty compelling argument for the design tradeoffs he's made.

Sean


