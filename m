From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Tue, 26 Sep 2006 18:07:29 +0200
Message-ID: <20060926160729.GH20017@pasky.or.cz>
References: <20060926053816.54951.qmail@web31815.mail.mud.yahoo.com> <efapsl$e65$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 18:14:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSFT6-0007Vf-Aw
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 18:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWIZQHc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 12:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWIZQHc
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 12:07:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45530 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932325AbWIZQHb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 12:07:31 -0400
Received: (qmail 29820 invoked by uid 2001); 26 Sep 2006 18:07:29 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <efapsl$e65$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27800>

Dear diary, on Tue, Sep 26, 2006 at 10:54:49AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> I'd rather not. The fact that the file name and tree name is link,
> and the fact that commit title and tag title is link is a _convenience_.
> Not always it is visible (without mouseover) that it is link.
> And it is _not_ visible in the case of files!

Then that should be fixed.

And directories should have trailing slash in their name in the tree
listing, for people with non-UNIX background who don't understand the
ls -l like output.

> And for example for commits and heads there are two possible
> views, commit and commitdiff for commit, shortlog and log for head,
> of which we arbitrary chose one for the subject link. So in that
> case the additional self link is needed. I'd rather have both.

For commits and heads, I agree. But that's not what this patch does.

> And for consistency I'd rather always have visible form default
> self link/

A parse error kicked me off here, sorry.


(I'm personally kind of ambivalent to the change.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
