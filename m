From: Petr Baudis <pasky@suse.cz>
Subject: Re: GitWiki lost ability to parse macros
Date: Wed, 6 Sep 2006 13:30:52 +0200
Message-ID: <20060906113052.GC23891@pasky.or.cz>
References: <edm7h3$nij$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 13:31:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKvcR-0001CW-D4
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 13:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWIFLa4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 07:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWIFLaz
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 07:30:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20871 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750820AbWIFLay (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 07:30:54 -0400
Received: (qmail 7819 invoked by uid 2001); 6 Sep 2006 13:30:52 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <edm7h3$nij$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26515>

  Hi,

Dear diary, on Wed, Sep 06, 2006 at 12:22:47PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Somehow, the GitWiki (which is MoinMoin wiki) lost the ability to parse
> macros. Macros are now output as is, instead of being substitutes with
> their expansion. It looks like MediaWiki-like syntax plugin got broken,
> because besides of {{macroname}} not being expanded, additionally pipe
> links [[target|label]] are not parsed.
> 
> See for example
>   http://git.or.cz/gitwiki/RecentChanges
>   http://git.or.cz/gitwiki/FindPage
>   http://git.or.cz/gitwiki/SystemInfo
> 
>   http://git.or.cz/gitwiki/InterfacesFrontendsAndTools 
>   (table of contents lost)
> 
> So anyone has idea what has happened, and how to repair it?

  this was connected with the server upgrade, sorry. Fixed.

  There are unfortunately some stability problems with the new server,
we hope to get that sorted out; in case of downtime we'll be falling
back to the original server which is still running, but I disabled the
wiki there in order not to lose changes when flipping back and forth.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
