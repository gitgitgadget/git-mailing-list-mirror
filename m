From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Kill git-resolve.sh
Date: Sun, 24 Sep 2006 15:00:54 +0200
Message-ID: <20060924130054.GQ20017@pasky.or.cz>
References: <20060923195530.5570.23774.stgit@machine.or.cz> <7v64fensge.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 15:01:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRTbc-0004li-3a
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 15:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWIXNA4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 09:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWIXNA4
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 09:00:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29915 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750715AbWIXNAz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 09:00:55 -0400
Received: (qmail 12586 invoked by uid 2001); 24 Sep 2006 15:00:54 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64fensge.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27668>

Dear diary, on Sun, Sep 24, 2006 at 12:12:01AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> On a very related note, we should prepare plan to deprecate
> merge-recursive.py.

While we are busy deprecating and removing stuff, we should also:

* probably finally get rid of git-ssh-upload and git-ssh-pull
  (mentioned in another thread already)
* make git-annotate alias to git-blame -c? (and probably print
  a deprecation warning)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
