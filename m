From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 22:46:18 +0200
Message-ID: <20061018204618.GW20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca> <200610180057.25411.jnareb@gmail.com> <Pine.LNX.4.64.0610171610270.3962@g5.osdl.org> <20061018053647.GA3507@coredump.intra.peff.net> <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org> <20061018185225.GU20017@pasky.or.cz> <20061018155704.b94b441d.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 22:46:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaIJ0-0008L9-58
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 22:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422868AbWJRUqW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 16:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422945AbWJRUqW
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 16:46:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34217 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422868AbWJRUqU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 16:46:20 -0400
Received: (qmail 13359 invoked by uid 2001); 18 Oct 2006 22:46:18 +0200
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061018155704.b94b441d.seanlkml@sympatico.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29263>

Dear diary, on Wed, Oct 18, 2006 at 09:57:04PM CEST, I got a letter
where Sean <seanlkml@sympatico.ca> said that...
> Couldn't these just as easily have been written as git-bundle and
> git-unbundle without needing any plugins or other cogito infrastructure?

They could be written, but certainly not "just as easily". I'm more used
to coding Cogito, I find it much more convenient than hacking git's
shell scripts (those two may be interconnected ;), and there's plenty of
infrastructure in Cogito missing in Git - Cogito has more flexible
arguments parsing, documentation bundled with code, I could just
cut'n'paste the code to handle -m arguments and message editor (and most
of it is libified anyway) so I got that basically for free, and I think
Cogito beats Git hands down in code readability.

> Not sure if it would be useful, but it shouldn't be too hard to have
> same commit ids regenerated at receiving end with git patches.

It would be of course technically possible, yes. But somewhat more work,
this is just a quick hack.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
