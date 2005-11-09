From: Petr Baudis <pasky@suse.cz>
Subject: Re: Expected Behavior?
Date: Thu, 10 Nov 2005 00:49:25 +0100
Message-ID: <20051109234925.GL30496@pasky.or.cz>
References: <E1EZKOB-0002j5-VY@jdl.com> <7vwtjjllw4.fsf@assigned-by-dhcp.cox.net> <20051108210332.GB23265@c165.ib.student.liu.se> <20051109112452.GD30496@pasky.or.cz> <46a038f90511091504l7218df18k251bec75491891e9@mail.gmail.com> <20051109231248.GL16061@pasky.or.cz> <46a038f90511091543h520f6a84k3e3b14c2e502989f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Junio C Hamano <junkio@cox.net>,
	Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:49:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZzh7-0000x3-Vd
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbVKIXtb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbVKIXta
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:49:30 -0500
Received: from w241.dkm.cz ([62.24.88.241]:1747 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751636AbVKIXt3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 18:49:29 -0500
Received: (qmail 13937 invoked by uid 2001); 10 Nov 2005 00:49:25 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511091543h520f6a84k3e3b14c2e502989f@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11448>

Dear diary, on Thu, Nov 10, 2005 at 12:43:04AM CET, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> On 11/10/05, Petr Baudis <pasky@suse.cz> wrote:
> > what mechanism are you talking about?
> 
> I suspect you haven't seen the git-merge mechanism in action -- or
> perhaps I'm a bit lost and we're talking about different things. At
> least last time I merged with git-merge.sh, it tried several
> strategies in order in a temporary index. Actually, it tried in order:
> stupid, resolve, recursive... It shortcuts if one merges cleanly, but
> it'll definitely work through them. It's very nice to see this in
> action.

But that's something different that I'm talking about. :-)

As I said, I'm talking about per-file automergers. git-merge-one-file
and that stuff. I know about merge strategies and they are cool.

> The mergers and things like git-merge-base are probably the areas of
> git that need the most focus and polish -- that's why I'm
> uncomfortable with cg-merge doing its own thing, as it gets a lot less
> review than git-merge-XX resolvers.

Yes. My longer plan is to use the strategy resolvers as well, but my
TODO list is big... And I don't perceive this as a critical thing (the
standard strategy seems to work well enough), although I would like to
see this before 1.0.

> Right now I am seeing some slightly abnormal things (*) in how some
> our our merges are going, so I' ll have to roll up my sleeves at some
> point and try and figure out what's going on. And as I look into
> cg-merge and cg-Xmergefile, not many eyes have been through it...

At least this is the one area of Cogito that has at least a bit
reasonable automated testing suite. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
