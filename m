From: Petr Baudis <pasky@suse.cz>
Subject: Re: Commit to more than one branch at once?
Date: Fri, 6 Oct 2006 20:52:27 +0200
Message-ID: <20061006185227.GV20017@pasky.or.cz>
References: <45269E02.50407@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 20:53:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVuoD-0000Hi-2W
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 20:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422834AbWJFSwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 14:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422840AbWJFSwa
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 14:52:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65428 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422834AbWJFSw3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 14:52:29 -0400
Received: (qmail 32326 invoked by uid 2001); 6 Oct 2006 20:52:27 +0200
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Content-Disposition: inline
In-Reply-To: <45269E02.50407@s5r6.in-berlin.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28433>

Dear diary, on Fri, Oct 06, 2006 at 08:18:42PM CEST, I got a letter
where Stefan Richter <stefanr@s5r6.in-berlin.de> said that...
> if I git-cherry-pick a commit from branch A into branch B, this is shown
> as a difference in "git-log B..A".
> 
> Is it possible to commit a change to two or more branches but preserve
> the identity of the change? IOW, is there an alternative to
> git-cherry-pick that does not have above mentioned side effect?

  Philosophical answer:

  This is a point where it shows that Git is snapshot-based, not
changeset-based version control system. So you are not committing a
change, you are committing a snapshot taken after the change. So only
snapshots have identity and if the snapshots differ, they obviously have
different identity. Thus your commit has to have different identity.
Furthermore the commit ties the snapshot with some history (and only
this is the first moment where the concept of the 'change' emerges), and
if you have different history, identity of your commit cannot be
the same either.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
