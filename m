From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Make search type a popup menu
Date: Tue, 24 Oct 2006 13:27:27 +0200
Message-ID: <20061024112727.GZ20017@pasky.or.cz>
References: <20061024031546.2877.51620.stgit@rover> <ehkfis$6da$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 13:27:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcKRQ-0008O2-HG
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 13:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWJXL13 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 07:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWJXL13
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 07:27:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:908 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030318AbWJXL12 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 07:27:28 -0400
Received: (qmail 20928 invoked by uid 2001); 24 Oct 2006 13:27:27 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ehkfis$6da$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29964>

Dear diary, on Tue, Oct 24, 2006 at 09:33:12AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Petr Baudis wrote:
> 
> > This makes the multiple search types actually usable by the user;
> > if you don't read the gitweb source, you don't even have an idea
> > that you can write things like that there.
> 
> This is I think good change, although I'm not sure if I like changing
> using search operators to using additional CGI parameter.
> 
> Having help page for search is _certainly_ very good change. Perhaps
> we should put it out-of-line, not embedded? Just a thought...

You mean out-of-file? I've pondered it but I think this is simpler than
having yet another external file with yet another configuration option,
and the help file is not anyway likely something you will want to
customize per-site.

> This patch changes search box into something similar to Google
> "Advanced Search". Yet Google "Advanced Search" box generates search
> query using search operators. Search operators are just more powerfull.
> I know that gitweb doesn't use this power now (it uses only one operator,
> first if I remember correctly), but we can do this in the future
> (e.g. searching for both author and specified string in commit message,
> or searching for given author OR given committer). Well, we can always
> change it back...

Well, yes, that's something we can do when we actually implement the
operators, but I think doing it this way is less powerful, but much more
*useful* since users not familiar with gitweb will have an actual idea
on how to use it, and gitweb is something that will have 90% of users
not familiar with it. So perhaps have an "extended" search type which
will accept the keywords?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
