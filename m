From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Install built-ins as symlinks
Date: Tue, 11 Jul 2006 20:48:38 +0200
Message-ID: <20060711184838.GC13776@pasky.or.cz>
References: <11526131782190-git-send-email-alp@atoker.com> <11526131781900-git-send-email-alp@atoker.com> <1152613179634-git-send-email-alp@atoker.com> <11526131791902-git-send-email-alp@atoker.com> <11526131792773-git-send-email-alp@atoker.com> <11526131792377-git-send-email-alp@atoker.com> <Pine.LNX.4.63.0607111614550.29667@wbgn013.biozentrum.uni-wuerzburg.de> <44B3BC94.3000204@atoker.com> <Pine.LNX.4.63.0607111951350.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alp Toker <alp@atoker.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 20:49:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0NHo-00037Y-Hc
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 20:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWGKSsl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 14:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWGKSsl
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 14:48:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18381 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751181AbWGKSsk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 14:48:40 -0400
Received: (qmail 25925 invoked by uid 2001); 11 Jul 2006 20:48:38 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607111951350.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23725>

  Hi,

Dear diary, on Tue, Jul 11, 2006 at 08:02:53PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> The consistency is a non-issue, because the Makefile rules Do The Right 
> Thing.

  once in a while, a Git command disappears, it has already happenned
several times (git-rename, git-octopus, git-apply-patch-script, I'm sure
I'd find some more if I looked better; looking into future, I'm not sure
about the further life expectancy of e.g. git-resolve or git-ssh-fetch).

> I happen to run git without installing it, mainly because I like to fiddle 
> around with git. Now, if "git" does not compile for some reason, with 
> symlinks I lose git-diff, git-ls-files, etc.

  If "git" doesn't compile nothing overwrites your previous "git" binary
and things stay working. If "git" did compile but is broken, the
Makefile already rehardlinked the other files anyway so you are still
screwed.

> And -- just maybe -- I _did_ mention a single reason to keep hard links: 
> It works now. So why change it?

  The original patch mentioned why hardlinks are bad, so if you argue
that the raised points are moot, you should give some substance to your
argument.

> > If you don't have the technical background to review a certain patch, please
> > don't add to the noise.
> 
> It is not nice to tell a dumb man how dumb he is. Mommy! I am so sorry 
> that I lack the technical background. Please apologize for the noise.

  Please help to maintain the very friendly nature of this list we
have been enjoying so far.

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
