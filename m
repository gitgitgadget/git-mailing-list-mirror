From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's in git.git
Date: Fri, 29 Sep 2006 10:32:08 +0200
Message-ID: <20060929083208.GL13132@pasky.or.cz>
References: <7vodt0zbhc.fsf@assigned-by-dhcp.cox.net> <20060928093623.GJ20017@pasky.or.cz> <7vhcyrnn1g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 10:32:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTDn5-0001Hv-SQ
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 10:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbWI2IcM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 04:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbWI2IcM
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 04:32:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46993 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161142AbWI2IcL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 04:32:11 -0400
Received: (qmail 22228 invoked by uid 2001); 29 Sep 2006 10:32:08 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhcyrnn1g.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28104>

Dear diary, on Fri, Sep 29, 2006 at 09:34:51AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> diff --git a/INSTALL b/INSTALL
> index 0d432d7..fa9bf74 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -38,19 +38,6 @@ Issues of note:
>     has been actively developed since 1997, and people have moved over to
>     graphical file managers.
>  
> - - You can use git after building but without installing if you
> -   wanted to.  Various git commands need to find other git
> -   commands and scripts to do their work, so you would need to
> -   arrange a few environment variables to tell them that their
> -   friends will be found in your built source area instead of at
> -   their standard installation area.  Something like this works
> -   for me:
> -
> -	GIT_EXEC_PATH=`pwd`
> -	PATH=`pwd`:$PATH
> -	GITPERLLIB=`pwd`/perl/blib/lib:`pwd`/perl/blib/arch/auto/Git
> -	export GIT_EXEC_PATH PATH GITPERLLIB
> -
>   - Git is reasonably self-sufficient, but does depend on a few external
>     programs and libraries:
>  

The passage should be kept and even GITPERLLIB - just drop the second
path after the colon.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
