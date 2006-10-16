From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 15 Oct 2006 23:30:59 -0400
Message-ID: <9e4733910610152030q45dbeb31l9eb0eb06bd6fd159@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <egrgqe$1i9$1@sea.gmane.org>
	 <9e4733910610141606g749d268eudd85791620e1363a@mail.gmail.com>
	 <20061015182303.GW20017@pasky.or.cz>
	 <9e4733910610151249m37c9f6abv37e07d7a801758bc@mail.gmail.com>
	 <20061016032314.GA20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 16 05:41:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZJM7-0005pC-0l
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 05:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWJPDlE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 23:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWJPDlE
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 23:41:04 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:39868 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751431AbWJPDlC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 23:41:02 -0400
Received: by py-out-1112.google.com with SMTP id n25so2154679pyg
        for <git@vger.kernel.org>; Sun, 15 Oct 2006 20:41:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IsLHUgZu17+mm/xGh/BtJc26eUlpdAgqztkDbw6yn3QdoLmoXi7A9hYTh8g/0ItdJL5c+7Ms6KoqWAH1MsIHplMk00I1tfCyz4hW82hQ4obrki1BFubaBtYTApVYCwd23sMgBdAUyAIXP9UDgIqwhV6FuRdA+j6YQgX72h9G/k0=
Received: by 10.35.99.6 with SMTP id b6mr11884358pym;
        Sun, 15 Oct 2006 20:30:59 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Sun, 15 Oct 2006 20:30:59 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20061016032314.GA20017@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28948>

On 10/15/06, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Sun, Oct 15, 2006 at 09:49:08PM CEST, I got a letter
> where Jon Smirl <jonsmirl@gmail.com> said that...
> > On 10/15/06, Petr Baudis <pasky@suse.cz> wrote:
> > >> I am still working with the developers of the cvs2svn import tool to
> > >> fix things so that Mozilla CVS can be correctly imported. There are
> > >> still outstanding bugs in cvs2svn preventing a correct import. MozCVS
> > >> can be imported, but the resulting repository is not entirely correct.
> > >>
> > >> Once they get the base cvs2svn fixed I'll port my patches to turn it
> > >> into cvs2git again.
> > >
> > >So what exactly is the cvs2git status now? AFAIU, there's a tool that
> > >parses the CVS repository and that is then "piped" to git-fastimport?
> > >git-fastimport is available somewhere (perhaps it would be interesting
> > >to publish it at repo.or.cz or something), is the current cvs2git
> > >version available as well?
> >
> > cvs2git is a set of patches that get applied to cvs2svn. The patches
> > modify cvs2svn to output things in a format that git-fastimport can
> > consume.
>
> By the way, isn't what you want an incremental importer, because of the
> 1.9 branch? According to its homepage, cvs2svn is not designed for
> incremental importing. Or are you fixing that as well?

cvsps works ok on small amounts of data, but it can't handle the full
Mozilla repo. The current idea is to convert the full repo with
cvs2git and build the ini file needed by cvsps to support incremental
imports. After that use cvsps.


>
> --
>                                 Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> #!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
> $/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
> lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
>


-- 
Jon Smirl
jonsmirl@gmail.com
