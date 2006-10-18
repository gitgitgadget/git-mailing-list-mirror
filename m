From: Petr Baudis <pasky@suse.cz>
Subject: Re: Integrating gitweb and git-browser (was: Re: VCS comparison table)
Date: Wed, 18 Oct 2006 04:02:24 +0200
Message-ID: <20061018020224.GR20017@pasky.or.cz>
References: <vpqejt76vgz.fsf@ecrins.imag.fr> <eh40e1$9g1$1@sea.gmane.org> <20061018015211.GP20017@pasky.or.cz> <200610180358.03669.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 04:06:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga0lJ-0006o5-Jd
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 04:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWJRCC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 22:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWJRCC0
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 22:02:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60587 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750999AbWJRCCZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 22:02:25 -0400
Received: (qmail 25986 invoked by uid 2001); 18 Oct 2006 04:02:24 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610180358.03669.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29178>

Dear diary, on Wed, Oct 18, 2006 at 03:58:03AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> You can have paginated graph (diagram). Although it is more natural
> to have diagram on the first page only, just like gitk --max-count=100.

Of course you _can_ have it, but you're going to have a lot of trouble
following the threads over page boundaries, especially if some branch
has no commits whatsoever at some page(s).

> The idea is for gitweb to generate (short)log, perhaps with pagination
> turned off (CSS overflow: scroll), and git-browser part to generate
> diagram and add it to log.

What's missing there is the scary AJAXish thing for fetching more
commits. You do not want to load the whole kernel history at once, but
instead on demand fetch more revisions.

BTW, I'm most probably not the one going to hack git-browser to fit in
this. My javascript knowledge is barely enough to implement a web
browser support for it. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
