From: Petr Baudis <pasky@suse.cz>
Subject: Re: PPC SHA-1 Updates in "pu"
Date: Sun, 25 Jun 2006 03:24:35 +0200
Message-ID: <20060625012435.GZ21864@pasky.or.cz>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net> <20060624012202.4822.qmail@science.horizon.com> <7vfyhv11ej.fsf@assigned-by-dhcp.cox.net> <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606241147480.6483@g5.osdl.org> <7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 03:24:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJMg-00022z-I7
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWFYBYh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWFYBYh
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:24:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2496 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964885AbWFYBYh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:24:37 -0400
Received: (qmail 23097 invoked by uid 2001); 25 Jun 2006 03:24:35 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22558>

Dear diary, on Sat, Jun 24, 2006 at 10:21:30PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Pasky, can we first iron out kinks in the build procedure and
> installation before converting existing programs further?

Sure.

> The things I worry about currently are:
> 
>  - the SITELIBARCH gotcha I sent you a message about (and you
>    responded to it already -- was that an Acked-by?);

Yes. :-)

>  - RPM target -- we probably acquired a new build-dependency in
>    which case the .spec file needs to be updated;

Well, perl is currently not listed even as a runtime dependency,
so does it really need to be listed as a build dependency?

>  - Make sure Git.xs builds and installed result works fine on
>    all platforms we care about, including Cygwin and other
>    non-Linux boxes.

Unfortunately I don't have access to a lot of those. :-(

> I'd even suggest we revert the changes to git-fmt-merge-msg to
> keep it working for now, until the above worries are resolved.
> Otherwise we cannot have it in "next" safely (and I REALLY _do_
> want to have Git.pm infrastructure in "next" soonish).

Yes, that sounds reasonable.

> We can start using Git.xs and friends in some _new_ ancillary
> programs, once we solve building and installing problems for
> everybody.  That way it would help us gain portability and
> confidence without disrupting existing users.

Well, I don't think it's very likely that Git.pm per se would be buggy
on a certain specific platform - it should either work as well as
everywhere else or not build at all, in which case you have disrupted
the existing users anyway. :-) (But without disrupting anyone we won't
get any bugreports and never get it fixed.)

Perhaps other converted perl scripts can linger at least on the pu
branch?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
