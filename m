From: Petr Baudis <pasky@suse.cz>
Subject: Re: [CFH] Remotes conversion script
Date: Mon, 25 Sep 2006 01:11:08 +0200
Message-ID: <20060924231108.GE20017@pasky.or.cz>
References: <20060924212142.GB20017@pasky.or.cz> <8aa486160609241457u40fffdd8h298e44351749bb29@mail.gmail.com> <20060924221644.GE13132@pasky.or.cz> <8aa486160609241534yc78b194g64038fe22048c443@mail.gmail.com> <20060924224017.GC20017@pasky.or.cz> <ef72ts$dk9$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 01:11:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRd7y-00007N-QK
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 01:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWIXXLL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 19:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWIXXLL
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 19:11:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:15061 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751348AbWIXXLK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 19:11:10 -0400
Received: (qmail 4137 invoked by uid 2001); 25 Sep 2006 01:11:08 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ef72ts$dk9$2@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27714>

Dear diary, on Mon, Sep 25, 2006 at 01:04:41AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Petr Baudis wrote:
> 
> > Dear diary, on Mon, Sep 25, 2006 at 12:34:24AM CEST, I got a letter
> > where Santi <sbejar@gmail.com> said that...
> >> It could be I'm wrong (for sure, I miss something), but I see the
> >> branches/ files like [remote] sections files with just one fetch:
> >> 
> >> .git/branches/git:
> >> git://...../git.gi
> >> 
> >> would be:
> >> 
> >> [remote "git"]
> >> url=git://...../git.git
> >> fetch=refs/heads/master:refs/heads/git
> > 
> > That's basically right, the point is that with moving to remotes
> > support, we will make each remote live in its own separate namespace,
> 
> Which is overkill if we fetch only from one directory.

Why?

> Besides using separate remotes (hmmm, we should add support for
> refs/remotes/ in gitweb) is a policy decision.

Cogito's designed so that users don't have to _care_ about the policy at
this level and it will just magically work for them, sensibly. If you
care enough, you can just modify the config file manually.

> On somewhat unrelated issue: should git-clone create [remote] section
> (and perhaps [branch] sections) instead of remotes file?

Ideally, I would hope for .git/remotes/ to be officially deprecated...
(perhaps after the next release?)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
