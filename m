From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-commit: Fix a typo that would inhibit running of post-commit script:
Date: Sun, 24 Sep 2006 19:39:58 +0200
Message-ID: <20060924173958.GV20017@pasky.or.cz>
References: <8764giro6t.fsf@rho.meyering.net> <20060825002013.GG2817@diku.dk> <87ac4zq237.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 19:40:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRXxi-0008MJ-4d
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 19:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWIXRkB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 13:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWIXRkB
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 13:40:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28308 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751300AbWIXRkA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 13:40:00 -0400
Received: (qmail 9859 invoked by uid 2001); 24 Sep 2006 19:39:58 +0200
To: Jim Meyering <jim@meyering.net>
Content-Disposition: inline
In-Reply-To: <87ac4zq237.fsf@rho.meyering.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27682>

Dear diary, on Sat, Sep 16, 2006 at 05:10:36PM CEST, I got a letter
where Jim Meyering <jim@meyering.net> said that...
> Jonas Fonseca <fonseca@diku.dk> wrote:
> > Jim Meyering <jim@meyering.net> wrote Thu, Aug 24, 2006:
> >> I tried cg-commit with a commit hook, but the hook never ran.
> >> The problem was a typo:
> >>
> >> Fix a typo that would inhibit running the post-commit script:
> >> s/commit-post/post-commit/.
> >
> > If I remember correctly, historically, the commit-post existed before
> > the post-commit appeared. You can see that it is documented in the man
> > page so it is not a typo.
> >
> > However, this should certainly be updated, but I think a better fix
> > would be to transitionally warn the user about the existence of the
> > commit-post hook before using it in favour of post-commit.
> 
> How about this?
> Check for both and if there's exactly one, use that.
> If it's the old one, give a diagnostic suggesting to rename it.
> If both exist, execute neither, give a diagnostic and fail.
> 
> If you like this, I'll prepare a patch.

That would be awesome. :-)

Thanks in advance,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
