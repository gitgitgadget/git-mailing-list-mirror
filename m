From: Petr Baudis <pasky@suse.cz>
Subject: Re: [POOL] Who likes running Git without make install?
Date: Sun, 2 Jul 2006 13:30:57 +0200
Message-ID: <20060702113057.GF29115@pasky.or.cz>
References: <7vhd2atid1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606241338370.6483@g5.osdl.org> <7vd5cyt8a3.fsf@assigned-by-dhcp.cox.net> <20060625010202.GX21864@pasky.or.cz> <20060625014009.GA21864@pasky.or.cz> <7vac82q6mb.fsf@assigned-by-dhcp.cox.net> <20060625152157.GG21864@pasky.or.cz> <7vk674mmyo.fsf@assigned-by-dhcp.cox.net> <20060701235906.GE29115@pasky.or.cz> <7vlkrcdg6d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 13:31:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx0AM-00026S-3m
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 13:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWGBLa7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 07:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWGBLa7
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 07:30:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20430 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964865AbWGBLa7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 07:30:59 -0400
Received: (qmail 5937 invoked by uid 2001); 2 Jul 2006 13:30:57 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd20dg2g.fsf@assigned-by-dhcp.cox.net> <7vlkrcdg6d.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23102>

Dear diary, on Sun, Jul 02, 2006 at 02:05:46AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> That's fixed in ancient past in git timescale.  Why are you
> bringing it up again? ;-)

Because, it is, well, not fixed? ;-) (Apparently.)

Dear diary, on Sun, Jul 02, 2006 at 02:08:07AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Dear diary, on Mon, Jun 26, 2006 at 08:48:31AM CEST, I got a letter
> > where Junio C Hamano <junkio@cox.net> said that...
> >> I remember myself getting utterly discusted when I saw the
> >> inclusion of the build-time blib directory in the search path in
> >> some other Perl code outside git.
> >
> > Well, yes, it is ugly, but it was really cool that we could have used
> > Git without installing it anywhere.
> >
> > But perhaps that's just me refusing to break his old ways of doing
> > things. Does anyone else care about it? (And why?)
> 
> Well, for a quick test to see if I haven't broken anything, I
> use a new shell and do ". ./+denv" in my git repository where
> that file has something like this:
> 
>         $ cat ./+denv
>         :
> 
>         GIT_EXEC_PATH=`pwd`
>         PATH=`pwd`:/usr/bin:/bin
> 
>         export GIT_EXEC_PATH PATH
> 
> So to a certain degree, yes I do care.

But it is currently broken:

xpasky@machine[0:0]~/git-pb$ rm -rf /home/xpasky/lib/perl5/
xpasky@machine[0:0]~/git-pb$ ./git-mv
Can't locate Git.pm in @INC (...)

(And I can't see any change that could aim to fix it.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
