From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [CFH] Remotes conversion script
Date: Mon, 25 Sep 2006 00:16:44 +0200
Message-ID: <20060924221644.GE13132@pasky.or.cz>
References: <20060924212142.GB20017@pasky.or.cz> <8aa486160609241457u40fffdd8h298e44351749bb29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 00:17:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRcHu-0006Jt-7h
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 00:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWIXWQu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 18:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWIXWQt
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 18:16:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25221 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751278AbWIXWQr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 18:16:47 -0400
Received: (qmail 29711 invoked by uid 2001); 25 Sep 2006 00:16:44 +0200
To: Santi <sbejar@gmail.com>
Content-Disposition: inline
In-Reply-To: <8aa486160609241457u40fffdd8h298e44351749bb29@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27703>

Dear diary, on Sun, Sep 24, 2006 at 11:57:34PM CEST, I got a letter
where Santi <sbejar@gmail.com> said that...
> 2006/9/24, Petr Baudis <pasky@suse.cz>:
> >  I think about supporting just the [remote] sections in Cogito since
> >they are much easier to handle than the remotes/ file format,
> 
> What about branches/ files?

I don't know yet. Cogito will certainly *recognize* them for *long* time
ahead (many months to be sure), no matter what will we decide to do with
them. Of course Cogito would start being growingly critical about them.

But the best technical solution is probably to stop using remote
branches in the heads namespace in new repositories altogether and
strictly create a new [remote] per each repository you fetch from (no
matter if it's a single branch or all of them or just a set), and there
will be cg-remote-add and perhaps cg-remote-chg to help you maintain
that easily.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
