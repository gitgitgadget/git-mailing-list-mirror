From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Introducing cg-xxdiff for conflict resolution
Date: Sun, 24 Sep 2006 18:50:37 +0200
Message-ID: <20060924165037.GS20017@pasky.or.cz>
References: <11546624471356-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 18:50:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRXBm-0006sk-Vz
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 18:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWIXQuk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 12:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWIXQuk
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 12:50:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60855 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750756AbWIXQuj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 12:50:39 -0400
Received: (qmail 3210 invoked by uid 2001); 24 Sep 2006 18:50:37 +0200
To: Martin Langhoff <martin@catalyst.net.nz>
Content-Disposition: inline
In-Reply-To: <11546624471356-git-send-email-martin@catalyst.net.nz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27674>

Dear diary, on Fri, Aug 04, 2006 at 05:34:07AM CEST, I got a letter
where Martin Langhoff <martin@catalyst.net.nz> said that...
> This is a bit of a crude but really useful shortcut for conflict resolution.
> The name is bad, but matches git-xxdiff which has been around for like... ages

Yes, the name is horrible. :-)

> As Cogito doesn't make use of the index during merges/applies, cg-xxdiff
> is somewhat more brittle and cannot not help during conflict resolution when
> using cg-patch.
> 
> Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>

Hmm, I think this would be generally more useful during the actual merge
phase - if merge returns error, you fire up
git-magic-conflict-resolution-driver and have fun.

Which reminds me that I should make some more effort to unify
cg-Xmergeonefile and git-merge-one-file...

> +. git-sh-setup

Uh-oh. :-)

> +git cat-file blob `git rev-parse FETCH_HEAD`:$FILE > $FILE~branch

Cogito does not use FETCH_HEAD.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
