From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Do not print "log" and "shortlog" redundantly in commit view
Date: Fri, 6 Oct 2006 18:35:52 +0200
Message-ID: <20061006163552.GT20017@pasky.or.cz>
References: <20061005192257.50209.qmail@web31809.mail.mud.yahoo.com> <eg51fi$7rs$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 18:36:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVsg2-0001yb-GS
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 18:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422704AbWJFQfz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 12:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422705AbWJFQfz
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 12:35:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45238 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422704AbWJFQfy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 12:35:54 -0400
Received: (qmail 19653 invoked by uid 2001); 6 Oct 2006 18:35:52 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eg51fi$7rs$2@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28417>

Dear diary, on Fri, Oct 06, 2006 at 09:44:29AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Gaah, the whole cae1862a3b55b487731e9857f2213ac59d5646d commit
> "gitweb: More per-view navigation bar links" is somewhat broken.
> Up to this point we used top navigation bar for commit (hash base)
> or whole project related links, while bottom part of navigation
> bar for "formats" i.e. links related to current view (passing hash)
> or for pagination.

Umm, and how did that commit break that? Except the issue this patch
fixes - sorry about that, I have no idea wth was I thinking.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
