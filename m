From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Mon, 9 Oct 2006 22:55:51 +0200
Message-ID: <20061009205551.GO20017@pasky.or.cz>
References: <20061007141043.16912.73982.stgit@rover> <20061007184418.64881.qmail@web31812.mail.mud.yahoo.com> <eg8tpu$drj$1@sea.gmane.org> <20061007191246.GF20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 09 22:56:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX2AH-0007Sx-0x
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 22:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWJIUzy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 16:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWJIUzy
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 16:55:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26600 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964851AbWJIUzx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Oct 2006 16:55:53 -0400
Received: (qmail 30797 invoked by uid 2001); 9 Oct 2006 22:55:51 +0200
To: Luben Tuikov <ltuikov@yahoo.com>, Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <20061007191246.GF20017@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28577>

> Dear diary, on Sat, Oct 07, 2006 at 09:06:25PM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
> > By the way, I miss somewhat the "redundant" tree/blob links in tree
> > view...
> 
> I didn't want to post about it but I share the feeling - I have to keep
> thinking consciously about clicking on the file name instead of on the
> view name - and the situation is worse for regular files, since it is
> not really apparent that the filenames are clickablea. My mind knows
> that I'm supposed to click on them (not users' mind!), but the eyes and
> hands are still clueless.

I was looking into accesslogs of repo.or.cz for something and noticed
that I see unusually large number of blame requests. That of course
attracted my curiosity and I came to conclusion that what I'm seeing is
not just my personal whim but we have serious usability problem here.

I'm unfortunately not sure when the update of repo.or.cz gitweb which
dropped the blob/tree links happenned, so the following _is_ somewhat
dubious, but I think it's quite telling anyway.

I have three samples (logfiles) available: #2 almost certainly when the
blob link was still there, #1 covering the switch and some time before
and after, and #0 certainly when the blob link was not there anymore,
but unfortunately spanning only one or two days.

This is the count of actions invoked from the tree, commit and
commitdiff view (using the referer information):

    blame  blob   total requests containing 'a='
#2  1      18     264
#1  31     23     399
#0  4      6      50

The disparation between #2 and #1,#0 is quite apparent. If we want more
exact results, I will let #0 accumulate data for a week and then revert
the removal of the links and start another sample.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
