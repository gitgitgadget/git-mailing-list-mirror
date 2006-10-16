From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] svnimport: Fix broken tags being generated
Date: Mon, 16 Oct 2006 13:26:59 +0200
Message-ID: <20061016112659.GB20017@pasky.or.cz>
References: <20061016010037.27259.26157.stgit@machine.or.cz> <7vpscsx1hr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 16 13:27:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZQcc-0001fr-Ud
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 13:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWJPL1D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 07:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWJPL1D
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 07:27:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48077 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751524AbWJPL1B (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 07:27:01 -0400
Received: (qmail 16112 invoked by uid 2001); 16 Oct 2006 13:26:59 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpscsx1hr.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28957>

Dear diary, on Mon, Oct 16, 2006 at 07:40:00AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Currently git-svnimport generates broken tags missing the timespec in the
> > 'tagger' line. This is a random stab at a minimal fix.
> >
> > Signed-off-by: Petr Baudis <pasky@suse.cz>
> 
> Interesting.  Applied.
> 
> I remember that older "git tag" does not even add the tagger
> line (the kernel history starts using one from 2.6.13-rc4 on Jul
> 28, 2005).  Does gitweb handle those tags correctly, I wonder?

It seems from git_tag() that the original author thought about that.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
