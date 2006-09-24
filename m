From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Git.pm: Kill Git.xs for now
Date: Sun, 24 Sep 2006 13:08:16 +0200
Message-ID: <20060924110816.GK20017@pasky.or.cz>
References: <20060923181849.28753.56984.stgit@machine.or.cz> <7vwt7ta6sh.fsf@assigned-by-dhcp.cox.net> <20060924105016.GA5732@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 13:08:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRRqQ-0001vn-0N
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 13:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbWIXLIT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 07:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbWIXLIS
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 07:08:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31148 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751983AbWIXLIS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 07:08:18 -0400
Received: (qmail 4080 invoked by uid 2001); 24 Sep 2006 13:08:16 +0200
To: Alex Riesen <fork0@users.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060924105016.GA5732@steel.home>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27656>

Dear diary, on Sun, Sep 24, 2006 at 12:50:16PM CEST, I got a letter
where Alex Riesen <fork0@t-online.de> said that...
> Junio C Hamano, Sun, Sep 24, 2006 12:38:22 +0200:
> > Petr Baudis <pasky@suse.cz> writes:
> > 
> > > This patch removes Git.xs from the repository for the time being. This
> > > should hopefully enable Git.pm to finally make its way to master.
> > 
> > It's a bit sad, but I think this is a sane thing to do.
> > 
> > I suspect Alex still has problem with Makefile.PL due to issues
> > around ActiveState (slash vs bs and CRLF line ending if I recall
> > correctly)?
> > 
> 
> Absolutely.

I'm sorry but I don't even have a Windows installation on my machine and
I don't intend to personally work on Windows support. If you need to
keep ActiveState working seamlessly, please post patches. I hate to say
it, but that's just how it should work - if someone cares about Git
working on a non-mainstream (for Git audience) platform, he needs to
maintain it, not ask the "core" developers do it. It's like if you
withheld random kernel features because they break m68k and noone is
around to fix it.

If someone cares, we'll get patches.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
