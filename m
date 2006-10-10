From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Show project README if available
Date: Tue, 10 Oct 2006 12:55:21 +0200
Message-ID: <20061010105521.GQ20017@pasky.or.cz>
References: <20061010025627.19317.70511.stgit@rover> <7vejtg97qh.fsf@assigned-by-dhcp.cox.net> <7v7iz894ct.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 12:55:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXFGg-00057A-JG
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 12:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbWJJKzX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 06:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWJJKzX
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 06:55:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38533 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932625AbWJJKzX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 06:55:23 -0400
Received: (qmail 21315 invoked by uid 2001); 10 Oct 2006 12:55:21 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7iz894ct.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28625>

Dear diary, on Tue, Oct 10, 2006 at 06:33:54AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Petr Baudis <pasky@suse.cz> writes:
> >
> >> If the project includes a README file, show it in the summary page.
> >...
> > I wonder how this should relate to .git/description file,
> > though.  In other words, it _might_ make sense to change where
> > we show the contents of description right now to show the first
> > line and take README from the same location.

In principle I like this idea. One problem is that description is not
supposed to contain HTML and my README is (perhaps it should read
README.html instead), and I really want README to. And if it's not
plaintext, division of the first line and the rest does not work so
well:

If you show first line of description as the "short" one and whole
description as the "full" one in summary page, it will look awkward. If
you look at http://repo.or.cz/gitweb.cgi/hed.git, the first line in the
full description starts with boldened Hed, and is of course a separate
paragraph etc.

> Also we might want to consider using this file (or description)
> for git-daemon "motd" action if we were to enhance it.  I
> remember that early days of git-daemon some people wanted to
> have motd.

I'd rather keep those separate...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
