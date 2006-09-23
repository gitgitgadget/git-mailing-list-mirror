From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC][RESEND][PATCH] Allow fetching from multiple repositories at once
Date: Sat, 23 Sep 2006 19:04:39 +0200
Message-ID: <20060923170439.GQ8259@pasky.or.cz>
References: <20060923164308.16334.49252.stgit@machine.or.cz> <45156780.6070801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 19:05:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRAvq-0005Eb-6v
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 19:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWIWREl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 13:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWIWREl
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 13:04:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:14982 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751324AbWIWREk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 13:04:40 -0400
Received: (qmail 18718 invoked by uid 2001); 23 Sep 2006 19:04:39 +0200
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <45156780.6070801@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27601>

Dear diary, on Sat, Sep 23, 2006 at 06:57:36PM CEST, I got a letter
where A Large Angry SCM <gitzilla@gmail.com> said that...
> Petr Baudis wrote:
> >You still need to pass git-fetch-pack some URL in addition to the
> >repositories - it is used only for git_connect(), the purpose is that
> >repositories must be local directories so if you want to talk remote, you
> >need to do something like
> >
> >	git-fetch-pack git://kernel.org/pub/scm/git/git.git 
> >	--repo=/pub/scm/git/git.git master next 
> >	--repo=/pub/scm/cogito/cogito.git master
> >
> 
> Can't this be done with a simple wrapper around git-fetch* ?

The point is that that is too slow (the difference is noticeable
especiall in the case there is no new stuff ready), you need to create a
connection and do whole lot of work for each of the repositories.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
