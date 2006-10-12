From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Fri, 13 Oct 2006 00:47:27 +0200
Message-ID: <20061012224727.GU20017@pasky.or.cz>
References: <7v7iz5rk4b.fsf@assigned-by-dhcp.cox.net> <egmdkv$k33$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 00:56:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY9Kx-0003Ek-Ei
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 00:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWJLWrb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 18:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWJLWrb
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 18:47:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46482 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751261AbWJLWra (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Oct 2006 18:47:30 -0400
Received: (qmail 15318 invoked by uid 2001); 13 Oct 2006 00:47:27 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <egmdkv$k33$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28816>

Dear diary, on Thu, Oct 12, 2006 at 11:55:49PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Junio C Hamano wrote:
> 
> > Currently it does what git-blame does, but only faster.
> > 
> > More importantly, its internal structure is designed to support
> > content movement (aka cut-and-paste) more easily by allowing
> > more than one paths to be taken from the same commit.
> > 
> > Signed-off-by: Junio C Hamano <junkio@cox.net>
> > ---
> > 
> > I really hate to do this immediately after writing obituary for
> > annotate, but I had a solid 24-hour to work on git, which is a
> > rare opportunity for me these days, so here it is.
> 
> Why not reuse git-annotate name? git-pickaxe doesn't do pickaxe...

I agree that git-pickaxe is wrong, and luckily Junio does too,
apparently.

But please, let's not go right back to the git-annotate / git-blame
situation. It's just confusing to have two tools that do the same thing,
perhaps subtly differently. If it's gonna replace git-blame, it should
either do that right away or live as git-blame2 for some time, but not
play any confusing games with the names.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
