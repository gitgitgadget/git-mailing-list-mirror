From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 17:31:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609131729500.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com>
 <20060913152451.GH23891@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 13 17:32:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNWiI-0000LS-P1
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 17:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWIMPbo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 11:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWIMPbo
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 11:31:44 -0400
Received: from mail.gmx.de ([213.165.64.20]:14984 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750941AbWIMPbn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 11:31:43 -0400
Received: (qmail invoked by alias); 13 Sep 2006 15:31:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 13 Sep 2006 17:31:41 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060913152451.GH23891@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26915>

Hi,

On Wed, 13 Sep 2006, Petr Baudis wrote:

> Dear diary, on Wed, Sep 13, 2006 at 05:17:59PM CEST, I got a letter
> where Jon Smirl <jonsmirl@gmail.com> said that...
> > Abandoned branches are common in CVS since it is not distributed.
> > People start working on something in the main repo and then decide it
> > was a bad idea. In the git world these branches usually don't end up
> > in the main repo.
> 
> Can't you just toss the branch away in that case? :-)
> 
> You could also stash the ref to refs/heads-abandoned/ instead of
> refs/heads/ if you want to keep the junk around for some reason. Of
> course you don't get the nice marker with explanation of why is this
> abandoned and who decided that, but you can just use an empty commit for
> the same purpose.

... or a tag (remember, you can stash a tag into refs/abandoned/, instead 
of a commit) with the further benefit that you really cannot commit on top 
of that.

> Object classes are precious things and we shouldn't get carried away.

Exactly.

Ciao,
Dscho
