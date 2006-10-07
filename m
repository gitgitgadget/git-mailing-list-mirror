From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: [commit view] Do not suppress commitdiff link in root commit
Date: Sat, 7 Oct 2006 14:33:44 +0200
Message-ID: <20061007123344.GZ20017@pasky.or.cz>
References: <20061006165933.4127.72491.stgit@rover> <7vmz88ziwv.fsf@assigned-by-dhcp.cox.net> <eg7tqd$lie$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 14:34:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWBNQ-0000T0-GC
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 14:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWJGMdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 08:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWJGMdr
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 08:33:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4244 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751050AbWJGMdq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 08:33:46 -0400
Received: (qmail 20906 invoked by uid 2001); 7 Oct 2006 14:33:44 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eg7tqd$lie$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28478>

Dear diary, on Sat, Oct 07, 2006 at 12:00:29PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Junio C Hamano wrote:
> 
> > Petr Baudis <pasky@suse.cz> writes:
> > 
> >> There's no reason for that, the commitdiff view is meaningful for the
> >> root commit as well and we link to it everywhere else.
> > 
> > It probably is not any more useful than the blob view but I
> > agree there is no strong reason to supress it, as long as the
> > commitdiff page is prepared to show the root commit (which I
> > haven't checked -- if you have --root you should be Ok).
> 
> The commitdiff for root commit is much less useful, I think, and not having
> commitdiff link serves as indicator of root (parentless) commit, important
> in non-commit views. 

  But we don't shor commitdiff _only_ (afaics) in the commit view. ;-)
So it doesn't indicate anything anyway.

  I personally don't mind looking at mass-addition patches (something
looking at Debian package diffs teaches you), and it's a quick way to
see all the files being added to the tree, not browse them blob-by-blob.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
