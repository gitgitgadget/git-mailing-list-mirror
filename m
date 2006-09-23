From: Petr Baudis <pasky@suse.cz>
Subject: Re: git pull for update of netdev fails.
Date: Sat, 23 Sep 2006 06:09:42 +0200
Message-ID: <20060923040942.GG8259@pasky.or.cz>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org> <Pine.LNX.4.63.0609202304270.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060923034407.GF8259@pasky.or.cz> <20060923040035.GB18105@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	catalin.marinas@gmail.com, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 06:09:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQypp-00018y-7d
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 06:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWIWEJp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 00:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWIWEJp
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 00:09:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5001 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750789AbWIWEJo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 00:09:44 -0400
Received: (qmail 11404 invoked by uid 2001); 23 Sep 2006 06:09:42 +0200
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20060923040035.GB18105@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27559>

Dear diary, on Sat, Sep 23, 2006 at 06:00:35AM CEST, I got a letter
where Shawn Pearce <spearce@spearce.org> said that...
> I can see the same concept of ref history being useful even for
> core git-rebase and doing it this way would also give it to StGIT
> without Catalin needing to change code.

In my StGIT tree, I don't want to have arbitrary N-days cutoff point,
I want all the patches history preserved at least as long as I carry
the patch, because it's just as valuable as the "regular" project
history to me.

> But it doesn't help git bisect.

It's not really all that clear how should bisect work in case of
multi-dimensional history. To do it sensibly, I guess you would have to
have another command like "stg commitseries" which declares "right now I
have the series (patches, their applied/unapplied state and their
ordering) in a clearly defined state" and then bisect between those.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
