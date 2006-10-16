From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Mon, 16 Oct 2006 05:23:14 +0200
Message-ID: <20061016032314.GA20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egrgqe$1i9$1@sea.gmane.org> <9e4733910610141606g749d268eudd85791620e1363a@mail.gmail.com> <20061015182303.GW20017@pasky.or.cz> <9e4733910610151249m37c9f6abv37e07d7a801758bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 16 05:23:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZJ4S-00025E-QH
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 05:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWJPDXR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 23:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWJPDXR
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 23:23:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46760 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751334AbWJPDXQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 23:23:16 -0400
Received: (qmail 2052 invoked by uid 2001); 16 Oct 2006 05:23:15 +0200
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910610151249m37c9f6abv37e07d7a801758bc@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28947>

Dear diary, on Sun, Oct 15, 2006 at 09:49:08PM CEST, I got a letter
where Jon Smirl <jonsmirl@gmail.com> said that...
> On 10/15/06, Petr Baudis <pasky@suse.cz> wrote:
> >> I am still working with the developers of the cvs2svn import tool to
> >> fix things so that Mozilla CVS can be correctly imported. There are
> >> still outstanding bugs in cvs2svn preventing a correct import. MozCVS
> >> can be imported, but the resulting repository is not entirely correct.
> >>
> >> Once they get the base cvs2svn fixed I'll port my patches to turn it
> >> into cvs2git again.
> >
> >So what exactly is the cvs2git status now? AFAIU, there's a tool that
> >parses the CVS repository and that is then "piped" to git-fastimport?
> >git-fastimport is available somewhere (perhaps it would be interesting
> >to publish it at repo.or.cz or something), is the current cvs2git
> >version available as well?
> 
> cvs2git is a set of patches that get applied to cvs2svn. The patches
> modify cvs2svn to output things in a format that git-fastimport can
> consume.

By the way, isn't what you want an incremental importer, because of the
1.9 branch? According to its homepage, cvs2svn is not designed for
incremental importing. Or are you fixing that as well?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
