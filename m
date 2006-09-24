From: Petr Baudis <pasky@suse.cz>
Subject: Re: 2.6.18-mm1
Date: Sun, 24 Sep 2006 18:55:15 +0200
Message-ID: <20060924165515.GX13132@pasky.or.cz>
References: <20060924040215.8e6e7f1a.akpm@osdl.org> <20060924124647.GB25666@flint.arm.linux.org.uk> <20060924132213.GE11916@pasky.or.cz> <20060924142005.GF25666@flint.arm.linux.org.uk> <20060924142958.GU13132@pasky.or.cz> <20060924144710.GG25666@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 18:55:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRXGF-0007rW-6g
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 18:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWIXQzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 12:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWIXQzT
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 12:55:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:14740 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751104AbWIXQzR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 12:55:17 -0400
Received: (qmail 3595 invoked by uid 2001); 24 Sep 2006 18:55:15 +0200
To: linux-kernel@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060924144710.GG25666@flint.arm.linux.org.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27675>

Dear diary, on Sun, Sep 24, 2006 at 04:47:10PM CEST, I got a letter
where Russell King <rmk+lkml@arm.linux.org.uk> said that...
> On Sun, Sep 24, 2006 at 04:29:58PM +0200, Petr Baudis wrote:
> > Dear diary, on Sun, Sep 24, 2006 at 04:20:06PM CEST, I got a letter
> > where Russell King <rmk+lkml@arm.linux.org.uk> said that...
> > > I'm now told that the resulting tree after all the commits is correct.
> > > The problem is that all the files which were supposed to be deleted by
> > > previous patches ended up actually being deleted by the final patch in
> > > the series.
> > > 
> > > So the resulting tree is fine, it's just that the history is rather
> > > broken.
> > 
> > Well, that rewritehist batch should work fine even in this case.
> > 
> > (Of course that's assuming that no change was supposed to happen to
> > those files in the last four days.)
> > 
> > > I think a solution to this might be to use git-apply, but there's one
> > > draw back - I currently have the facility to unpatch at a later date,
> > > but git-apply doesn't support -R.
> > 
> > Yes, if there's not too many patches perhaps using git-apply -R would be
> > simpler. git-apply in git-1.4.2.1 does support -R.
> 
> I'm just experimenting with git-apply for the forward case, and I'm
> hitting a small problem.  I can do:
> 
> 	cat patch | git-apply --stat
> 
> then I come to commit it:
> 
> 	git commit -F -
> 
> but if I just use that, _all_ changes which happen to be in the tree
> get committed, not just those which are in the index file.  Manually
> doing each step of the commit is far too much work in perl...

Hmm, I'm sorry but I'm not all that well-versed in git commit inner
workings. The best way to get help is to cc' git@vger.kernel.org.

According to git-commit documentation, when you do what you wrote you
use, it _should_ commit just the index file...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
