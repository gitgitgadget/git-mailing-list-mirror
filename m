From: Petr Baudis <pasky@suse.cz>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 17:24:51 +0200
Message-ID: <20060913152451.GH23891@pasky.or.cz>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 13 17:26:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNWbh-0006yD-E1
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 17:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWIMPYy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 11:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWIMPYy
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 11:24:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51949 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750927AbWIMPYy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 11:24:54 -0400
Received: (qmail 26677 invoked by uid 2001); 13 Sep 2006 17:24:51 +0200
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26914>

Dear diary, on Wed, Sep 13, 2006 at 05:17:59PM CEST, I got a letter
where Jon Smirl <jonsmirl@gmail.com> said that...
> Abandoned branches are common in CVS since it is not distributed.
> People start working on something in the main repo and then decide it
> was a bad idea. In the git world these branches usually don't end up
> in the main repo.

Can't you just toss the branch away in that case? :-)

You could also stash the ref to refs/heads-abandoned/ instead of
refs/heads/ if you want to keep the junk around for some reason. Of
course you don't get the nice marker with explanation of why is this
abandoned and who decided that, but you can just use an empty commit for
the same purpose.

Object classes are precious things and we shouldn't get carried away.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
