From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's in git.git
Date: Thu, 28 Sep 2006 11:36:23 +0200
Message-ID: <20060928093623.GJ20017@pasky.or.cz>
References: <7vodt0zbhc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 11:36:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSsJh-0007P9-6Z
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 11:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWI1Jg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 05:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWI1Jg0
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 05:36:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54947 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751760AbWI1JgZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 05:36:25 -0400
Received: (qmail 26531 invoked by uid 2001); 28 Sep 2006 11:36:23 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodt0zbhc.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27997>

Dear diary, on Thu, Sep 28, 2006 at 09:39:11AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
>   -

BTW, what's the difference between '-' and '+'?

>   + Git.pm lost Git.xs; its remnant still remains, though.
>     Notably, we still compile x86_64 with -fPIC, and the top
>     level Makefile has {BASIC,ALL}_{CFLAGS,LDFLAGS} distinction
>     and INSTALL talks about perl/blib/arch/auto.  I am torn
>     between removing these and keeping them; on one hand, they
>     are not needed and makes new developers wonder what the
>     distinction between BASIC and ALL are.  On the other hand,
>     we may eventually would want to reintroduce Git.xs in the
>     future and keeping them might help us.  But on the third
>     hand ;-), we can always resurrect it from the repository and
>     that is the point of using git to keep track of the project,
>     so removing them might not be such a big deal.  I'd like to
>     decide between this two and push it out to 'master' before
>     doing the -rc1.

FWIW, I'd say kill it all (perhaps except BASIC_*, I don't know about
that one) - we indeed can easily resurrect this, and that was the
presumption with which I've killed the rest of Git.xs. There's no point
in keeping legacy cruft around when we can take it back from the
history.

Perhaps we could throw a note to perl/Makefile saying

	# If you are thinking about adding Git.xs support, please note
	# that we have already been there before - see the #next branch
	# history for more-or-less working one already added, and also
	# the reason why it was removed for now.

so that noone wastes their time.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
