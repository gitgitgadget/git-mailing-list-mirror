From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Fix showing of path in tree view
Date: Thu, 21 Sep 2006 13:25:36 +0200
Message-ID: <20060921112536.GV8259@pasky.or.cz>
References: <20060920231224.GN13132@pasky.or.cz> <7vpsdqdsh1.fsf@assigned-by-dhcp.cox.net> <20060920234052.GO13132@pasky.or.cz> <eetjp0$22n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 13:26:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQMgY-0000JD-1S
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 13:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWIULZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 07:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWIULZj
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 07:25:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26526 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750932AbWIULZi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 07:25:38 -0400
Received: (qmail 5821 invoked by uid 2001); 21 Sep 2006 13:25:36 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eetjp0$22n$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27474>

Dear diary, on Thu, Sep 21, 2006 at 10:50:46AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Petr Baudis wrote:
> 
> > Dear diary, on Thu, Sep 21, 2006 at 01:32:42AM CEST, I got a letter
> > where Junio C Hamano <junkio@cox.net> said that...
> 
> >> But I think the older one was visually nicer and more intuitive
> >> in one very small detail that I think matters.  Slashes between
> >> path components were not part of the anchor elements, so it was
> >> clear that there were two links in "gitweb / gitweb.perl" page
> >> title, not just one link.  Now it is not obvious that clicking
> >> different parts of the path string in "/stgit/commands/mail.py"
> >> would lead to different places.  And as you are aware, losing
> >> the leading "/" would be nicer as well ;-).
> > 
> >   Well, this was the best I could come up without introducing "[root] /"
> > or something in front of the path, which would be IMHO even uglier.
> > Alternative ideas welcomed. :-)
> 
> "[$project] /", or "~ /" instead of "[root] /".

Yes, the former is what repo.or.cz uses now and in a patch I've sent
privately to Junio (since my StGIT configuration at repo.or.cz is messed
up and I had no time to fix it).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
