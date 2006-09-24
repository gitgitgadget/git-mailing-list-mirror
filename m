From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] git-publish
Date: Sun, 24 Sep 2006 14:06:34 +0200
Message-ID: <20060924120634.GN20017@pasky.or.cz>
References: <Pine.LNX.4.64.0608131158500.9789@iabervon.org> <46a038f90608131653k1a2d0480x411be91bdc3f60ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 14:06:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRSks-0003p8-AG
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 14:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWIXMGg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 08:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWIXMGg
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 08:06:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32935 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750703AbWIXMGf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 08:06:35 -0400
Received: (qmail 8749 invoked by uid 2001); 24 Sep 2006 14:06:34 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90608131653k1a2d0480x411be91bdc3f60ca@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27662>

Dear diary, on Mon, Aug 14, 2006 at 01:53:07AM CEST, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> On 8/14/06, Daniel Barkalow <barkalow@iabervon.org> wrote:
> >Like how "pull" is "fetch" + "merge",
> 
> Slightly OT... I thought git-publish host:/path/to/repo.git would be
> something to automate the initial "publishing" actions, which for me
> are:
> 
> ssh host 'mkdir path/to/repo.git'
> ssh host 'GIT_DIR=path/to/repo.git git init-db'
> ssh host 'GIT_DIR=path/to/repo.git git repo-config someopts'
> git-push git+ssh://host:/path/to/repo.git
> 
> Hmmmm. Would this be git publish-repo maybe?

Actually, this is a nice idea for cg-admin-setuprepo, thanks. :-) It now
accepts a git+ssh URL just as well as a local path. (It won't work with
git-shell, but that's a good thing.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
