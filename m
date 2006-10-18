From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 23:39:35 +0200
Message-ID: <20061018213935.GX20017@pasky.or.cz>
References: <200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca> <200610180057.25411.jnareb@gmail.com> <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org> <20061018053647.GA3507@coredump.intra.peff.net> <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org> <20061018185225.GU20017@pasky.or.cz> <20061018155704.b94b441d.seanlkml@sympatico.ca> <20061018204618.GW20017@pasky.or.cz> <20061018165341.bcece11f.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:39:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJ8b-0001n1-JQ
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbWJRVji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423004AbWJRVji
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:39:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43208 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422655AbWJRVjh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 17:39:37 -0400
Received: (qmail 20662 invoked by uid 2001); 18 Oct 2006 23:39:35 +0200
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061018165341.bcece11f.seanlkml@sympatico.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29273>

(Trimmed Cc' list, this is offtopic for bazaar-ng.)

Dear diary, on Wed, Oct 18, 2006 at 10:53:41PM CEST, I got a letter
where Sean <seanlkml@sympatico.ca> said that...
> On Wed, 18 Oct 2006 22:46:18 +0200
> Petr Baudis <pasky@suse.cz> wrote:
> 
> > They could be written, but certainly not "just as easily". I'm more used
> > to coding Cogito, I find it much more convenient than hacking git's
> > shell scripts (those two may be interconnected ;), and there's plenty of
> > infrastructure in Cogito missing in Git - Cogito has more flexible
> > arguments parsing, documentation bundled with code, I could just
> > cut'n'paste the code to handle -m arguments and message editor (and most
> > of it is libified anyway) so I got that basically for free, and I think
> > Cogito beats Git hands down in code readability.
> 
> Hmmm, if I get some time over the weekend i'll take a look at porting
> them to Git.  But maybe some of the items you mentioned above deserve
> to become part of Git proper?  It would definitely be nice to see
> something like what you just did put into the hands of more users than
> just those using Cogito, and its unfortunate that the current state
> of Git code kept you from going that route.

You can use just this single tool from Cogito. ;-)

The point is, I'll of course prefer doing this stuff in Cogito while I'm
enhancing Cogito, and I'll work on Cogito while I and others will be
using it. I didn't move on to pure Git long time ago since I simply
consider its UI much inferior to Cogito's. Sure, given enough time and
work, it is fixable - but UI flaws are very hard to fix and I find it
more effective to work on Cogito for the time being, at least until I
bring it to 1.0, then I'll see.

Besides, I'm used to Cogito. :-)

So yes, current Git code definitely is a part of the reason, but it is
certainly not the main part of it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
