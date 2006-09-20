From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Fix showing of path in tree view
Date: Thu, 21 Sep 2006 01:40:52 +0200
Message-ID: <20060920234052.GO13132@pasky.or.cz>
References: <20060920231224.GN13132@pasky.or.cz> <7vpsdqdsh1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 21 01:41:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQBgX-0007HQ-5p
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 01:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWITXky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 19:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWITXky
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 19:40:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:9927 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750723AbWITXkx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 19:40:53 -0400
Received: (qmail 10256 invoked by uid 2001); 21 Sep 2006 01:40:52 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsdqdsh1.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27434>

Dear diary, on Thu, Sep 21, 2006 at 01:32:42AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > This patch fixes two things - links to all path elements except the last
> > one were broken since gitweb does not like the trailing slash in them, and
> > the root tree was not reachable from the subdirectory view.
> >
> > To compensate for the one more slash in the front, the trailing slash is
> > not there anymore. ;-) I don't care if it stays there though.
> 
> Hmph.  I see the breakage and behaviour-wise your patch is fine.
> 
> But I think the older one was visually nicer and more intuitive
> in one very small detail that I think matters.  Slashes between
> path components were not part of the anchor elements, so it was
> clear that there were two links in "gitweb / gitweb.perl" page
> title, not just one link.  Now it is not obvious that clicking
> different parts of the path string in "/stgit/commands/mail.py"
> would lead to different places.  And as you are aware, losing
> the leading "/" would be nicer as well ;-).

  Well, this was the best I could come up without introducing "[root] /"
or something in front of the path, which would be IMHO even uglier.
Alternative ideas welcomed. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
