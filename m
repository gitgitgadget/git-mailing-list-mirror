From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: perhaps time to remove git_blame from gitweb, and git-annotate?
Date: Fri, 6 Oct 2006 11:55:29 -0700 (PDT)
Message-ID: <20061006185529.9481.qmail@web31802.mail.mud.yahoo.com>
References: <20061006161637.GS20017@pasky.or.cz>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Ryan Anderson <ryan@michonline.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Martyn Smith <martyn@catalyst.net.nz>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Oct 06 20:55:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVur8-0000z8-Op
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 20:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422840AbWJFSzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 14:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422841AbWJFSzb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 14:55:31 -0400
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:27026 "HELO
	web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422840AbWJFSza (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 14:55:30 -0400
Received: (qmail 9483 invoked by uid 60001); 6 Oct 2006 18:55:29 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=APZEAyDMm3EBO7EqCYFY5J8Cj7WnV62o5OfRFNPjFphm9WmrzvALeusvzQY9xEO/r9kUNhRuGsP54qooOOoTSW+KSsVRastQzOXuYZ/dDWxbW2wak1hpSuyHO4MZWgJ4PuqIw7wZbhwiOvbRewyREfyoT4TzezUaNIDAmoKeQec=  ;
Received: from [64.215.88.90] by web31802.mail.mud.yahoo.com via HTTP; Fri, 06 Oct 2006 11:55:29 PDT
To: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <20061006161637.GS20017@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28434>

--- Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Thu, Oct 05, 2006 at 10:13:15AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
> > It's been a while since we lost git_blame from %actions list.  I
> > am wondering maybe it's time to remove it, after 1.4.3 happens.
> 
> I will not mourn git-annotate disappearance (perhaps it could stay an
> alias to git-blame -c; I don't like this UI-wise but we already do this
> kind of thing with git-log / git-whatchanged). I still like gitweb blame
> better than blame2 but I'll just patch blame to look like blame2 (or
> better) and be happy with that.

That's exactly what I don't want to happen.  blame2 is much less
bloated than blame both in code and in visual appearance and in using
git.  And this was the whole point: quick, short, fast and straight
to the point.

I'd like to keep the blame interface as simple as possible, more
window estate given to the code lines, and as little as possible to
the commit id: a clickable commit-8 and now we also have clickable
line_no to show us the state of the file, is more than enough.

So far, blame2 has been by far the better "annotate" (as it is called
in the other SCMs) interface I've seen in four other SCMs (some proprietary).
Let's keep it like this.

When data-mining code, what I'm interested in is: where did this line
of code come from (commit-8), is it a part of a larger chunk (zebra
coloring) and how it relates to the surrounding code.  Blame2 is more
than efficient at this.

    Luben




> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> #!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
> $/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
> lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
> 
