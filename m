From: Petr Baudis <pasky@suse.cz>
Subject: Re: Tags
Date: Sun, 3 Jul 2005 00:14:34 +0200
Message-ID: <20050702221434.GA23021@pasky.ji.cz>
References: <m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com> <42C5DA77.4030107@zytor.com> <m1hdfdg0aa.fsf@ebiederm.dsl.xmission.com> <42C6D318.8050108@zytor.com> <m1k6k9drfk.fsf@ebiederm.dsl.xmission.com> <42C6D5AD.9070304@zytor.com> <m1fyuxdpq4.fsf@ebiederm.dsl.xmission.com> <42C7043C.9080904@zytor.com> <Pine.LNX.4.58.0507021432370.8247@g5.osdl.org> <42C70A5B.9070606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 00:18:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoqJo-0006fF-0P
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 00:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVGBWSE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 18:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVGBWPB
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 18:15:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11148 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261308AbVGBWOg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 18:14:36 -0400
Received: (qmail 25594 invoked by uid 2001); 2 Jul 2005 22:14:34 -0000
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <42C70A5B.9070606@zytor.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jul 02, 2005 at 11:42:51PM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> Linus Torvalds wrote:
> >
> >Note that the fact that you use a common object store does not mean that 
> >everything should be common.

\o/ Finally I have some hope that we don't end up with something
braindead w.r.t. the tags... ;-)

..snip..
> OK, so let me retell what I think I hear you say:
> 
> - Store all the tags in the object store; they may conflict.

They may have the same "human-readable name", but they will have a
different hash.

> - Let each source user have a set of refs, and provide a method for the 
> end user to select which refs to get.
> 
> In other words, the only way (other than knowing what GPG keys to trust) 
> to distinguish between your "v2.6.12" and J. Random Hacker's "v2.6.12" 
> is that the former is referenced by *your* refs as opposed to JRH's 
> refs.

After all, this is the best way to distinguish it, isn't it? Just "tag
name" without a name of the branch the tag concerns makes no sense -
that's the point I'm trying to get along. JRH's v2.6.12 wouldn't make
much sense to you if you use Linus' v2.6.12, since the object JRH's
v2.6.12 references simply may not be in the branch you use. Yes, JRH
could tag it somewhere in the common past, but that's kind of strange
and is likely some private JRH's stuff. If Linus merged JRH, he will
take his v2.6.12 if it makes sense in his branch - so the decision
is then up to the one who merges, which makes some sense too.

FYI, I'll teach Cogito about the refs/tags/<branch>/<tag> later today
(and totally offtopic, it already has some trivial cg-push now).
It will still fall back to refs/tags/<tag>.

> This also means the refs cannot be uniquely rebuilt from the 
> object storage.

Why should they be, after all.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
