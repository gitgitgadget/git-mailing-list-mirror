From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Even more support for PATH_INFO based URLs
Date: Sat, 23 Sep 2006 16:29:41 +0200
Message-ID: <20060923142941.GL8259@pasky.or.cz>
References: <200609200049.52036.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>,
	Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sat Sep 23 16:29:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR8Vt-0004qA-9d
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 16:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWIWO3n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 10:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWIWO3n
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 10:29:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:7124 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751183AbWIWO3n (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 10:29:43 -0400
Received: (qmail 27372 invoked by uid 2001); 23 Sep 2006 16:29:41 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200609200049.52036.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27592>

  Hi,

Dear diary, on Wed, Sep 20, 2006 at 12:49:51AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Now the following types of path based URLs are supported:
> 
> * project              overview (summary) page of project
> * project/branch       shortlog of branch
> * project/branch:file  file in branch, blob_plain view
> * project/branch:dir/  directory listing of dir in branch, tree view
> 
> The following shortcuts works (see explanation below):
> 
> * project/branch:      directory listing of branch, main tree view
> * project/:file        file in HEAD (raw)
> * project/:dir/        directory listing of dir in HEAD
> * project/:            directory listing of project's HEAD

  I haven't followed this stuff carefully but just to confirm, there is
currently no way to persuade gitweb to actually produce such links,
right?

  I like pathinfo and would like to use it for repo.or.cz's gitweb.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
