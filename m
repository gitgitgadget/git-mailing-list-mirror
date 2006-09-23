From: Petr Baudis <pasky@suse.cz>
Subject: Re: git commands that only work correctly at top directory
Date: Sat, 23 Sep 2006 17:16:30 +0200
Message-ID: <20060923151630.GN8259@pasky.or.cz>
References: <fcaeb9bf0609220221w3a65af24u9db1da4e1be0d1eb@mail.gmail.com> <20060922112615.GB10124@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 23 17:16:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR9FI-0005LT-S8
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 17:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWIWPQc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 11:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWIWPQc
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 11:16:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33491 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751230AbWIWPQc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 11:16:32 -0400
Received: (qmail 31924 invoked by uid 2001); 23 Sep 2006 17:16:30 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060922112615.GB10124@moooo.ath.cx>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27596>

Dear diary, on Fri, Sep 22, 2006 at 01:26:15PM CEST, I got a letter
where Matthias Lederhofer <matled@gmx.net> said that...
> repack/bisect/reset and some other commands make only sense from the
> toplevel directory but anyway I would allow them to be run in a
> subdirectory and change up to the topdirectory (like git checkout for
> branch switching).  Is there any good reason not to do this?  I found
> it often annoying to go down to the toplevel directory/get a new shell
> just to reset to HEAD~1.

Probably not for repack, but in case of bisect and especially reset it
would be reasonable to expect that it will touch just the subdirectory
and in case of git reset --hard that could be deadly.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
