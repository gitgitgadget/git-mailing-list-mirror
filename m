From: Petr Baudis <pasky@suse.cz>
Subject: Re: Comments on recursive merge..
Date: Wed, 9 Nov 2005 15:59:29 +0100
Message-ID: <20051109145929.GE30496@pasky.or.cz>
References: <20051108210211.GA23265@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081351020.3247@g5.osdl.org> <20051108223609.GA4805@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081450080.3247@g5.osdl.org> <20051109003236.GA30496@pasky.or.cz> <Pine.LNX.4.64.0511081646160.3247@g5.osdl.org> <7vlkzyd4aq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511081716450.3247@g5.osdl.org> <7v8xvyd2bh.fsf@assigned-by-dhcp.cox.net> <7v4q6mgm1l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 16:04:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZrQS-0000UL-HT
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 15:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVKIO7d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 09:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbVKIO7c
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 09:59:32 -0500
Received: from w241.dkm.cz ([62.24.88.241]:28089 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750839AbVKIO7c (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 09:59:32 -0500
Received: (qmail 23646 invoked by uid 2001); 9 Nov 2005 15:59:29 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4q6mgm1l.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11401>

Dear diary, on Wed, Nov 09, 2005 at 11:20:22AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> I do not think "git-show-branch --merge-base" can be any more
> efficient than "git-merge-base --all".  It does _more_ things
> (probably unnecessary things as well).  Pasky's number could be
> just an artifact of hot/cold cache difference.

Certainly not that. But I've fetched in the meantime and now show-branch
takes much longer - median 0.078s (git-merge-base's median still stays
around 0.128s). So possibly git-show-branch did some smart optimization
right away in the previous case. I can try to track down the particular
commits if there's any interest.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
