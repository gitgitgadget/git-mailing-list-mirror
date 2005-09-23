From: "Peter TB Brett" <peter@peter-b.co.uk>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Fri, 23 Sep 2005 09:50:55 -0400 (EDT)
Message-ID: <14403.62.254.128.6.1127483455.squirrel@mail.twu.net>
References: <ud5mznc1x.fsf@peter-b.co.uk>
    <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 15:54:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EInxT-000367-Eb
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 15:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVIWNvR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 09:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbVIWNvR
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 09:51:17 -0400
Received: from bilbo.twu.net ([64.246.24.15]:5550 "EHLO twu.net")
	by vger.kernel.org with ESMTP id S1750991AbVIWNvQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 09:51:16 -0400
Received: from mail.twu.net (localhost.localdomain [127.0.0.1])
	by twu.net (8.12.9/8.12.9) with ESMTP id j8NDot99010742;
	Fri, 23 Sep 2005 09:50:55 -0400
Received: from 62.254.128.6 (proxying for 82.9.228.97)
        (SquirrelMail authenticated user brettp)
        by mail.twu.net with HTTP;
        Fri, 23 Sep 2005 09:50:55 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
User-Agent: SquirrelMail/1.4.4
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9193>


Johannes Schindelin wrote:

>> I wanted to use git on a Windows-based project (yes, there are some
>> out there still), so I fired up my Cygwin xterm, untarred the git
>> sources and totally failed to succeed in building them:
>
> Also see my mail regarding cygwin:
>
> http://www.gelato.unsw.edu.au/archives/git/0508/7956.html

Yes. I found that just after I'd spammed the list.

> This is the IPv6 stuff. There are patches to cygwin to support IPv6
> somewhere, but they haven't made it into mainline.
>
> As for the other problem I mentioned in my original mail:
>
> It seems that the fixup of the mmap()ed regions after a fork() does not
> work properly in cygwin. Remember that cygwin just wraps the non-POSIX
> Win32API and tries to make it sort of POSIX compliant. The problem is that
> Win32API lacks a proper fork(). This is therefore emulated, and after
> that, all the mmap()ed regions have to be mapped again. That fails.

Hmph. Sounds like I'm stuffed.

Ah well, I'll just have to use something else -- I know Mercurial works on
Windows.  To be honest, I'd prefer to use git though; I've used it on
other projects and it's really nice.

Ah well, can't have everything you want all of the time, neh?

Peter


-- 
Quake II build tools: http://peter-b.co.uk/
Latest QuArK:         http://quark.sourceforge.net/LatestVersion

v2sw6YShw7ln5pr6ck3ma8u7Lw3+2m0l7CFi6e4+8t4Eb8Aen4g6Pa2Xs5MSr5p4
  hackerkey.com
