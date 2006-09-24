From: Petr Baudis <pasky@suse.cz>
Subject: Re: [CFH] Remotes conversion script
Date: Mon, 25 Sep 2006 01:50:53 +0200
Message-ID: <20060924235053.GF20017@pasky.or.cz>
References: <20060924212142.GB20017@pasky.or.cz> <8aa486160609241457u40fffdd8h298e44351749bb29@mail.gmail.com> <20060924221644.GE13132@pasky.or.cz> <8aa486160609241534yc78b194g64038fe22048c443@mail.gmail.com> <20060924224017.GC20017@pasky.or.cz> <ef72ts$dk9$2@sea.gmane.org> <20060924231108.GE20017@pasky.or.cz> <ef750s$jg4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 01:51:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRdkz-0007Ng-Tt
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 01:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWIXXuz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 19:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWIXXuz
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 19:50:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64661 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751427AbWIXXuz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 19:50:55 -0400
Received: (qmail 7280 invoked by uid 2001); 25 Sep 2006 01:50:53 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ef750s$jg4$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27719>

Dear diary, on Mon, Sep 25, 2006 at 01:40:26AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> s/directory/repository/ of course. And as of why: I'd rather have 'next',
> 'maint, 'html', 'man' in main namespace (with 'origin' substituting
> 'master') instead of remotes/origin/next etc.

Well, I don't know. Cogito should stay simple (and stupid) and if you
introduce too much choice, you will lose that. Especially if the choice
is in something already so confusing as branching. And for larger
repositories or more complex distributed branching situations, the
separated-remotes model is clearly superior, so I'd rather keep it for
the simpler cases as well, since if it introduces any hassle, I believe
it's only very minor (and pays off in the long run for the simpler
setups as well, I believe).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
