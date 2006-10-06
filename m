From: Petr Baudis <pasky@suse.cz>
Subject: Re: perhaps time to remove git_blame from gitweb, and git-annotate?
Date: Fri, 6 Oct 2006 18:16:37 +0200
Message-ID: <20061006161637.GS20017@pasky.or.cz>
References: <7vejtnij5n.fsf@assigned-by-dhcp.cox.net> <20061005064817.21552.qmail@web31804.mail.mud.yahoo.com> <7vu02jfaec.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Ryan Anderson <ryan@michonline.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Martyn Smith <martyn@catalyst.net.nz>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Oct 06 18:16:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVsNP-000509-GW
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 18:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWJFQQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 12:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWJFQQk
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 12:16:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41362 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751382AbWJFQQk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 12:16:40 -0400
Received: (qmail 17930 invoked by uid 2001); 6 Oct 2006 18:16:37 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu02jfaec.fsf_-_@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28415>

Dear diary, on Thu, Oct 05, 2006 at 10:13:15AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> It's been a while since we lost git_blame from %actions list.  I
> am wondering maybe it's time to remove it, after 1.4.3 happens.

I will not mourn git-annotate disappearance (perhaps it could stay an
alias to git-blame -c; I don't like this UI-wise but we already do this
kind of thing with git-log / git-whatchanged). I still like gitweb blame
better than blame2 but I'll just patch blame to look like blame2 (or
better) and be happy with that.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
