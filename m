From: Petr Baudis <pasky@suse.cz>
Subject: Re: Comments on recursive merge..
Date: Wed, 9 Nov 2005 01:32:36 +0100
Message-ID: <20051109003236.GA30496@pasky.or.cz>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org> <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org> <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de> <20051108210211.GA23265@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081351020.3247@g5.osdl.org> <20051108223609.GA4805@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 01:33:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZdtL-00008C-4z
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 01:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbVKIAck (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 19:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbVKIAcj
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 19:32:39 -0500
Received: from w241.dkm.cz ([62.24.88.241]:46020 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030471AbVKIAcj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 19:32:39 -0500
Received: (qmail 31803 invoked by uid 2001); 9 Nov 2005 01:32:36 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11373>

Dear diary, on Wed, Nov 09, 2005 at 12:05:43AM CET, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> Junio, that points out that "git-merge-base" is another program that could 
> just be removed, since it's really supreceded by git-show-branch. Or did I 
> miss something?

Wow, I didn't know git-show-branch could do that (even though it's a bit
unnatural to expect this from command named this way; then again,
there's git-rev-parse...).

BTW, git-show-branch is also by orders of magnitude faster (not that
this would be any major timesaver). Median 0.006s vs. median 0.124s.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
