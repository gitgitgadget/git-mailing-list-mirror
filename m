From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Show project's README.html if available
Date: Tue, 24 Oct 2006 13:30:57 +0200
Message-ID: <20061024113057.GA20017@pasky.or.cz>
References: <20061024032346.4185.85330.stgit@rover> <350280.74860.qm@web31804.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 13:31:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcKUv-0000kD-LB
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 13:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWJXLbA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 07:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWJXLbA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 07:31:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61111 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030335AbWJXLa7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 07:30:59 -0400
Received: (qmail 21271 invoked by uid 2001); 24 Oct 2006 13:30:57 +0200
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <350280.74860.qm@web31804.mail.mud.yahoo.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29965>

Dear diary, on Tue, Oct 24, 2006 at 10:43:08AM CEST, I got a letter
where Luben Tuikov <ltuikov@yahoo.com> said that...
> --- Petr Baudis <pasky@suse.cz> wrote:
> > If the repository includes a README.html file, show it in the summary page.
> > The usual "this should be in the config file" argument does not apply here
> > since this can be larger and having such a big string in the config file
> > would be impractical.
> > 
> > I don't know if this is suitable upstream, but it's one of the repo.or.cz
> > custom modifications that I've thought could be interesting for others
> > as well.
> > 
> > Compared to the previous patch, this adds the '.html' extension to the
> > filename, so that it's clear it is, well, HTML.
> > 
> > Signed-off-by: Petr Baudis <pasky@suse.cz>
> > ---
> 
> Why not instead re-submit a patch implementing what was discussed
> in this thread bearing the same name:
> 
> http://marc.theaimsgroup.com/?t=116044914900001&r=1&w=2

This implements

	http://marc.theaimsgroup.com/?l=git&m=116047939517299&w=2

I see no other ideas I could take there except various naming proposals
and perhaps using File::Copy but I'll wait until someone does a
gitweb-wide change for the latter.

I don't really care _what_ name it bears, but I'd like to have it
included. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
