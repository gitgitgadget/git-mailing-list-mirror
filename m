From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Tue, 20 Jun 2006 22:10:35 +0200
Message-ID: <20060620201035.GT2609@pasky.or.cz>
References: <e79921$u0e$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 22:24:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsmlT-0003Is-PP
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 22:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWFTUXt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 16:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWFTUXt
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 16:23:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56757 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750878AbWFTUXs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 16:23:48 -0400
Received: (qmail 27996 invoked by uid 2001); 20 Jun 2006 22:10:35 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e79921$u0e$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22223>

Dear diary, on Tue, Jun 20, 2006 at 06:51:18PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> * Add git fetch URL to the project page from gitweb-xmms2. Needs site-wide
>   base_url, which need not to be set as there is sane default: use base 
>   of gitweb URL.
> 
>   Is it useful to allow repository configuration to override it?

Certainly. E.g. http://pasky.or.cz/gitweb.cgi hosts some random projects
but generally they are to be fetched from totally different locations.

> * Refactor dispatch from if...elsif...else construction 
>   to using 'name' => \&sub hash.

In other words, you say the result of the IRC discussion we had about
symbol lookups and evals turned out really scary? ;-)

> * gitweb-xmms2 has something called committags support: it means that
>   'BUG(n)', 'FEATURE(n)' and 'RELEASE: xx' in commit message are turned into
>   bugtracker (Mantis for xmms2) or wiki links. It is extension of turning
>   sha1-ids into references. Probably needs some extra configuration file,
>   and some per repository configuration. Of course we want to support not
>   only Mantis, but also e.g. Bugzilla (e.g. Linux kernel) and conventions
>   for marking bugs therein.

For Bugzilla, just /\bbug (\d+)/i is frequently used so many people are
probably used to it while it feels natural and doesn't make you tumble
over it when reading the message.

For these things it's simplest to give the user ability to specify some
regexp substitutions to be applied on commit messages.

About sha1 turned to references, I don't think that's practical until
you will have some way of finding out whether a given sha1 is a valid
object reference without Theta(n) forks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
