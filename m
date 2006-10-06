From: Petr Baudis <pasky@suse.cz>
Subject: Re: perhaps time to remove git_blame from gitweb, and git-annotate?
Date: Fri, 6 Oct 2006 21:08:50 +0200
Message-ID: <20061006190850.GA4827@pasky.or.cz>
References: <20061006161637.GS20017@pasky.or.cz> <20061006185529.9481.qmail@web31802.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 06 21:09:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVv4L-000430-WB
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 21:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422893AbWJFTIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 15:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422897AbWJFTIy
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 15:08:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58072 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422893AbWJFTIw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 15:08:52 -0400
Received: (qmail 1558 invoked by uid 2001); 6 Oct 2006 21:08:50 +0200
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20061006185529.9481.qmail@web31802.mail.mud.yahoo.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28436>

(Trimmed cc list to people caring about gitweb.)

Dear diary, on Fri, Oct 06, 2006 at 08:55:29PM CEST, I got a letter
where Luben Tuikov <ltuikov@yahoo.com> said that...
> --- Petr Baudis <pasky@suse.cz> wrote:
> > I will not mourn git-annotate disappearance (perhaps it could stay an
> > alias to git-blame -c; I don't like this UI-wise but we already do this
> > kind of thing with git-log / git-whatchanged). I still like gitweb blame
> > better than blame2 but I'll just patch blame to look like blame2 (or
> > better) and be happy with that.
> 
> That's exactly what I don't want to happen.  blame2 is much less
> bloated than blame both in code and in visual appearance and in using
> git.  And this was the whole point: quick, short, fast and straight
> to the point.
> 
> I'd like to keep the blame interface as simple as possible, more
> window estate given to the code lines, and as little as possible to
> the commit id: a clickable commit-8 and now we also have clickable
> line_no to show us the state of the file, is more than enough.
> 
> So far, blame2 has been by far the better "annotate" (as it is called
> in the other SCMs) interface I've seen in four other SCMs (some proprietary).
> Let's keep it like this.
> 
> When data-mining code, what I'm interested in is: where did this line
> of code come from (commit-8), is it a part of a larger chunk (zebra
> coloring) and how it relates to the surrounding code.  Blame2 is more
> than efficient at this.

And _I_ like to have some general idea about who and when touched given
line of code, without having to click on a bunch of commit ids or spend
a minute hovering over them patiently. ;-)

If you really feel strongly about it, we should be able to make the
individual columns hideable at view time, e.g. by a tiny bit of
javascript just changing the display CSS property, which would be really
comfortable. My idea about the output would be cg-log -s format, which
is still reasonably tense. OTOH, there's still some space to burn in the
Line column.

There should be no additional load caused by this since we already
extract this information anyway - we show it as a tooltip.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
