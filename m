From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: I'm missing isofs.h
Date: Thu, 28 Apr 2005 19:39:04 -0400
Message-ID: <42717418.6050409@dwheeler.com>
References: <20050426214338.32e9ac27.akpm@osdl.org> <20050427235115.GN22956@pasky.ji.cz> <Pine.LNX.4.58.0504271708550.18901@ppc970.osdl.org> <20050428003246.GV22956@pasky.ji.cz> <7vhdhra2sg.fsf@assigned-by-dhcp.cox.net> <20050428075244.GE8612@pasky.ji.cz>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 01:32:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRITe-0008Hh-Pg
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 01:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVD1Xgv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 19:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVD1Xgv
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 19:36:51 -0400
Received: from aibo.runbox.com ([193.71.199.94]:47316 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S262337AbVD1Xgm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 19:36:42 -0400
Received: from [10.9.9.110] (helo=snoopy.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DRIYd-0003cw-GZ; Fri, 29 Apr 2005 01:36:35 +0200
Received: from [70.18.249.32] (helo=[192.168.2.73])
	by snoopy.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DRIYd-0007e0-3g; Fri, 29 Apr 2005 01:36:35 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050428075244.GE8612@pasky.ji.cz>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> There's no reason not to get the timestamps too if you can; just put
> them after the attributes. They aren't in the diff now either.
> 
> I need the mode bits to set the mode right, surprisingly. :-) Yes, in
> part it is a leftover from the old times when we didn't just track the
> execute bit; I don't know if it is worth changing this.

Actually, I like having the full mode bits in there.
"git" actually can be useful as a more general capability for
keeping careful track of an entire tree that's NOT just source code
(e.g., your entire home directory tree, so you can replicate it
across machines in its current state).

I can easily imagine an option flag
that stores "modes as they really are", and another that says
"use the modes as they are stored".  Add some support for symlinks,
and you could do quite a bit. Timestamps would be ducky,
too, for the same reason.

--- David A. Wheeler
