From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Git.pm: Kill Git.xs for now
Date: Sun, 24 Sep 2006 14:09:02 +0200
Message-ID: <20060924120902.GO20017@pasky.or.cz>
References: <20060923181849.28753.56984.stgit@machine.or.cz> <7vwt7ta6sh.fsf@assigned-by-dhcp.cox.net> <20060924105016.GA5732@steel.home> <20060924110816.GK20017@pasky.or.cz> <20060924114834.GA5800@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 14:09:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRSnE-0004EW-3z
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 14:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWIXMJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 08:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWIXMJF
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 08:09:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34473 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750717AbWIXMJE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 08:09:04 -0400
Received: (qmail 8928 invoked by uid 2001); 24 Sep 2006 14:09:02 +0200
To: Alex Riesen <fork0@users.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060924114834.GA5800@steel.home>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27664>

Dear diary, on Sun, Sep 24, 2006 at 01:48:34PM CEST, I got a letter
where Alex Riesen <fork0@t-online.de> said that...
> Aside from that, any chance of making Git.xs optional (enabled by
> default, but disableable)? Disabling Git.xs will disable related
> scripts, sure, but also gives you an installation with one external
> (libperl) dependency less (probably with ability to install git and
> Git.xs separately).

Absolutely.

Actually, as I noted in the patch comment, if we reintroduce Git.xs
again we should probably do it so that it is completely optional and the
equivalent functionality is also implemented in Git.pm in pure perl +
execing Git. I have been originally opposed to that but after all the
woes we had to go through I have changed my opinion.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
