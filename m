From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC][RESEND][PATCH] Allow fetching from multiple repositories at once
Date: Sat, 23 Sep 2006 20:05:39 +0200
Message-ID: <20060923180539.GC20017@pasky.or.cz>
References: <20060923164308.16334.49252.stgit@machine.or.cz> <45156780.6070801@gmail.com> <20060923170439.GQ8259@pasky.or.cz> <Pine.LNX.4.63.0609231921110.25853@wbgn013.biozentrum.uni-wuerzburg.de> <20060923173943.GA20017@pasky.or.cz> <Pine.LNX.4.63.0609231947340.25853@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 20:05:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRBsm-0000zN-RY
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 20:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWIWSFl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 14:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWIWSFl
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 14:05:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37526 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751386AbWIWSFl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 14:05:41 -0400
Received: (qmail 27433 invoked by uid 2001); 23 Sep 2006 20:05:39 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609231947340.25853@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27609>

  Hi!

Dear diary, on Sat, Sep 23, 2006 at 07:54:10PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> On Sat, 23 Sep 2006, Petr Baudis wrote:
> 
> > Dear diary, on Sat, Sep 23, 2006 at 07:23:01PM CEST, I got a letter
> > where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > > I still firmly believe that it would be way more efficient to fetch all 
> > > those branches into _one_ proxy repository. Especially since you can reuse 
> > > the objects with an alternate, which has an additional benefit over your 
> > > approach.
> > 
> >   Huh? You can reuse the objects with my approach as well. Actually, it
> > is automagically done so.
> > 
> >   With proxy repository, you would still need a server-side setup to
> > maintain that repository, and specialized client-side porcelain to fetch
> > from it. My approach initially requires some core changes (which aren't
> > very pretty as it is but are not very fundamental or logically intrusive
> > either) but in the longer run it pays off since you don't need a
> > convoluted server-side setup for that.
> 
> No, you do not need _any_ server-side setup. And you do not need any 
> specialized client-side porcelain other than a script, which just does 
> the job.

  So how should the proxy repository be set up at the server side? I can
just imagine a cronjob periodically sweeping the repositories and
populate the proxy repository with new stuff (refs and objects) from
those.

  Looking at what you wrote again, you talk about fetching all those
branches _into_ one proxy repository. Perhaps we misunderstand each
other. This patch is not about the "into" part, it is about being able
to fetch _FROM_ _multiple_ repositories.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
