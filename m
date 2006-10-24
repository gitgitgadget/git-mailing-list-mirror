From: Petr Baudis <pasky@suse.cz>
Subject: Re: Pushing vs. alternates
Date: Tue, 24 Oct 2006 13:20:28 +0200
Message-ID: <20061024112028.GY20017@pasky.or.cz>
References: <20061024035335.GW20017@pasky.or.cz> <7vmz7muvqu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 13:20:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcKKh-000746-II
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 13:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWJXLUa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 07:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWJXLUa
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 07:20:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22920 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030301AbWJXLU3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 07:20:29 -0400
Received: (qmail 20374 invoked by uid 2001); 24 Oct 2006 13:20:28 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmz7muvqu.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29963>

Dear diary, on Tue, Oct 24, 2006 at 07:29:45AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@ucw.cz> writes:
> 
> >   I don't have time to code that myself right now, so I'm just tossing
> > an idea around - pushing to a directory with alternates set up should
> > avoid sending objects that are already in the alternate object database.
> 
> That is probably only relevant for the first time, since
> subsequent pushes have refs from its own repository that tracks
> the tips of branches that was pushed for the last time.

Well, I would send haves for the alternate repository anyway, since: you
push your kernel branch, half a year passes, you merge with new
development and want to push again; you really do not want to push
everything that happenned over the last half a year. And sending the
extra haves shouldn't hurt, right?

> And first time usage when you are initializing the repository
> with alternates, you have direct access to that repository
> (that's how you can set up alternates), you can as easily do the
> initial fetch/clone as well at that time.

I don't understand this paragraph. This mail is about pushing, not
fetch/clone. You can only push if your login access is reduced to
git-shell, and something external could've set up your alternates.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
