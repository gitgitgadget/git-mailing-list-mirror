From: Petr Baudis <pasky@suse.cz>
Subject: Re: Expected Behavior?
Date: Thu, 10 Nov 2005 20:34:30 +0100
Message-ID: <20051110193430.GU30496@pasky.or.cz>
References: <E1EZKOB-0002j5-VY@jdl.com> <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net> <20051108210332.GB23265@c165.ib.student.liu.se> <20051109112452.GD30496@pasky.or.cz> <46a038f90511091504l7218df18k251bec75491891e9@mail.gmail.com> <20051109231248.GL16061@pasky.or.cz> <46a038f90511091543h520f6a84k3e3b14c2e502989f@mail.gmail.com> <20051109234925.GL30496@pasky.or.cz> <46a038f90511091847t70567e50o2303f1dc7ada2464@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Junio C Hamano <junkio@cox.net>,
	Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 20:35:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaIBw-0007bh-Jw
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 20:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVKJTee (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 14:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVKJTee
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 14:34:34 -0500
Received: from w241.dkm.cz ([62.24.88.241]:52961 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751219AbVKJTed (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 14:34:33 -0500
Received: (qmail 22367 invoked by uid 2001); 10 Nov 2005 20:34:30 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511091847t70567e50o2303f1dc7ada2464@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11509>

Dear diary, on Thu, Nov 10, 2005 at 03:47:38AM CET, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> On 11/10/05, Petr Baudis <pasky@suse.cz> wrote:
> > Yes. My longer plan is to use the strategy resolvers as well, but my
> > TODO list is big... And I don't perceive this as a critical thing (the
> > standard strategy seems to work well enough), although I would like to
> > see this before 1.0.
> 
> Fair enough. If you can outline how the interaction between cg-merge
> and cg-commit are expected to work, I'll try and find some time for
> that.

Well, basically like right now ;-).

Merging is a two-stage process, where the two stages are isolated and
the latter does not interfere with the former. The former one is doing
the actual content merge, and that's what cg-merge does. The latter one
is recording the merge in history, and that's what cg-commit does.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
