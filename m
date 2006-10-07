From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Sat, 7 Oct 2006 21:12:46 +0200
Message-ID: <20061007191246.GF20017@pasky.or.cz>
References: <20061007141043.16912.73982.stgit@rover> <20061007184418.64881.qmail@web31812.mail.mud.yahoo.com> <eg8tpu$drj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 21:13:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWHbZ-0002cq-FM
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 21:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbWJGTMt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 15:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932778AbWJGTMt
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 15:12:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59353 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932725AbWJGTMs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 15:12:48 -0400
Received: (qmail 25307 invoked by uid 2001); 7 Oct 2006 21:12:46 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eg8tpu$drj$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28499>

Dear diary, on Sat, Oct 07, 2006 at 09:06:25PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Luben Tuikov wrote:
> 
> > --- Petr Baudis <pasky@suse.cz> wrote:
> >> +                          esc_html($t->{'name'} . '/'));
> > 
> > First, this is a Unixism, and would confuse other OS users.

drwxr-xr-x

> By the way, I miss somewhat the "redundant" tree/blob links in tree
> view...

I didn't want to post about it but I share the feeling - I have to keep
thinking consciously about clicking on the file name instead of on the
view name - and the situation is worse for regular files, since it is
not really apparent that the filenames are clickablea. My mind knows
that I'm supposed to click on them (not users' mind!), but the eyes and
hands are still clueless.

So, I'd like to either have the view links or the filenames in classical
link style so that it's apparent they are clickable; I didn't post a
patch since I didn't have time/energy to fight for it yet. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
