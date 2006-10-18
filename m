From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 13:15:52 +0200
Message-ID: <20061018111552.GT20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca> <200610171120.09747.jnareb@gmail.com> <1161078035.9020.73.camel@localhost.localdomain> <4534AB8B.8030505@op5.se> <1161147348.3423.24.camel@localhost.localdomain> <4535EB7C.7030209@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Collins <robertc@robertcollins.net>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 18 13:16:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga9Ox-0004iU-BF
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 13:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWJRLPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 07:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWJRLPz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 07:15:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:7100 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030220AbWJRLPy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 07:15:54 -0400
Received: (qmail 10376 invoked by uid 2001); 18 Oct 2006 13:15:52 +0200
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <4535EB7C.7030209@op5.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29223>

Dear diary, on Wed, Oct 18, 2006 at 10:53:16AM CEST, I got a letter
where Andreas Ericsson <ae@op5.se> said that...
> Robert Collins wrote:
> >Anyone can push and pull from each other - full stop. Whenever they
> >'pull' in bzr terms, they get fast-forward happening (if I understand
> >the git fast-forward behaviour correctly). After a fast-forward, the
> >dotted decimal revision numbers in the two branches are identical - and
> >they remain immutable until another fast forward occurs.
..snip..
> >You can determine it locally - if you know any of the motherships
> >revisions locally, we can generate the dotted-revnos that the
> >motherships master-branch would have from the local data - and the last
> >merge of mothership you did will have given you that details.
> 
> 
> To me, this means bazaar isn't distributed at all and I could achieve 
> much the same distributedness(?) by rsyncing an SVN repo, working 
> against that and then rsyncing it back with some fancy merging. In other 
> words, bazaar requires there to be one Lord of the Code, or some of the 
> key features break down.

Well as far as I understand, the Lord of the Code is whoever you pulled
from the last time.

It's just a different focus here. If I understood everything in this
thread correctly, both Git and Bazaar have persistent (SHA1, UUID) and
volatile (revspec, revision number) revision ids. The only difference is
that Git primarily presents the user with the SHA1 ids while Bazaar
primarily presents the user with a revision number (and that revspecs
change after every commit while revision numbers change only after a
merge).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
