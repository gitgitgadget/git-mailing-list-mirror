From: Petr Baudis <pasky@suse.cz>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 23:51:06 +0200
Message-ID: <20061018215106.GY20017@pasky.or.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE> <45355CBB.80108@utoronto.ca> <20061017185622.30fbc6c0.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Jakub Narebski <jnareb@gmail.com>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:51:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJJh-0003yB-Bk
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423036AbWJRVvJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423038AbWJRVvJ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:51:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19406 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1423036AbWJRVvH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 17:51:07 -0400
Received: (qmail 21829 invoked by uid 2001); 18 Oct 2006 23:51:06 +0200
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061017185622.30fbc6c0.seanlkml@sympatico.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29280>

Dear diary, on Wed, Oct 18, 2006 at 12:56:22AM CEST, I got a letter
where Sean <seanlkml@sympatico.ca> said that...
> On Tue, 17 Oct 2006 18:44:11 -0400
> Aaron Bentley <aaron.bentley@utoronto.ca> wrote:
> > Plugins also don't have a Bazaar's rigid release cycle, testing
> > requirements and coding conventions, so they are a convenient way to try
> > out an idea, before committing to the effort of getting it merged into
> > the core.
> 
> Hmm.. It's pretty easy to test out Git ideas too.  People do it all
> the time, and without plugins.  Junio maintains several such trees
> for instance.  Dunno.. I just think plugs _sounds_ good to developers
> without much real benefit to users over regular ole source code.

I think this is just another cultural difference. Git comes from the
kernel environment (although it is currently used in far more
environments than just the kernel and kernel-related stuff) and the
_kernel_'s development style is that you want to get as much stuff as
possible inside the kernel, and on the other hand don't care at all
about breaking in-kernel APIs and such.

The Git "plumbing" is very much the "kernel". We aren't as much
interested in having support for external bits of code poking in the Git
innards, we would much rather have them integrated into Git as soon as
possible rather than live around externally. OTOH, the "kernel" gives a
very flexible ("UNIXy") API to the writhing mass of porcelain scripts you
may call the "userland".

I'm not saying it must be always sharply better approach than the
plugin-encouraging approach. It's just as it is. (Also, another reason
is probably a purely technical one, it is much easier to have pluggable
functions in scripting languages that support "monkey-patching", than
have them in C, since you actually need to explicitly add all the hooks
etc. So in Python, from a large part you get the plugin support for
free.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
