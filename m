From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] GIT commit statistics.
Date: Mon, 14 Nov 2005 10:25:54 +0100
Message-ID: <20051114092554.GR30496@pasky.or.cz>
References: <7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net> <43758D21.3060107@michonline.com> <7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net> <46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com> <7vy83s95k0.fsf@assigned-by-dhcp.cox.net> <46a038f90511131242p4692c74fn20c015998620b9f4@mail.gmail.com> <7vlkzr6gzz.fsf@assigned-by-dhcp.cox.net> <46a038f90511132001x6a9109fk17593b7ceaf3177e@mail.gmail.com> <7vwtjb4vc4.fsf@assigned-by-dhcp.cox.net> <46a038f90511140051o1fa5ef7cyb9dd723fb8161ef9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 10:27:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbabA-0008Gm-O9
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 10:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbVKNJZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 04:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbVKNJZ5
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 04:25:57 -0500
Received: from w241.dkm.cz ([62.24.88.241]:47813 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751026AbVKNJZ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 04:25:57 -0500
Received: (qmail 26539 invoked by uid 2001); 14 Nov 2005 10:25:54 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511140051o1fa5ef7cyb9dd723fb8161ef9@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11777>

Dear diary, on Mon, Nov 14, 2005 at 09:51:29AM CET, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> In the meantime, the user experience of working with a small team and
> a shared repo has improved significantly by switching from cg-update
> to cg-fetch && git-rebase origin. So much so that I suspect that it'd
> be a big win for cg-update to default to rebase on merges from
> 'origin'.

I still don't understand what's the point. And it is confusing for
the user, since the history suddenly doesn't reflect how the GIT
development happened (which is what the history is about), and it is
downright deadly as soon as more than one branch gets around, which
makes it even more confusing for the user (you can do cg-update, yeah
- oh wait, unless you do X, then you need to remember to always do
cg-update -R or whatever).

All the woes just to get rid of the merge commits. What's wrong on merge
commits? If they irritate you so much, cg-log -M. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
