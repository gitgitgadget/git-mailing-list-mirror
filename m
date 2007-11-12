From: Thomas Neumann <tneumann@users.sourceforge.net>
Subject: Re: wishlist: git info
Date: Mon, 12 Nov 2007 23:50:18 +0100
Message-ID: <4738D8AA.1030604@users.sourceforge.net>
References: <fhad5q$iia$1@ger.gmane.org> <20071112222106.GE2918@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 00:24:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irie0-0001mK-Gm
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 00:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763AbXKLXYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 18:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756409AbXKLXYY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 18:24:24 -0500
Received: from tneu02.synserver.de ([217.119.58.222]:2395 "EHLO
	tneu02.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbXKLXYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 18:24:24 -0500
X-Greylist: delayed 2049 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Nov 2007 18:24:23 EST
Received: from [192.168.0.2] (dslb-084-058-234-234.pools.arcor-ip.net [84.58.234.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tneu02.synserver.de (Postfix) with ESMTP id DDBF1680BA;
	Mon, 12 Nov 2007 23:50:12 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20071112222106.GE2918@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64731>

> you're better of just running "gitk --all" at this point. It'll show
> remote branches (with the names of remote repos prepended) and their
> relations to the local repo.
hm, this is not what I am after. I do not want to inspect the history, I
want to see where this repository "belongs" to. Gitk shows me the name
(which is reasonable, of course), but not the URL. And it is a GUI
application, which is not so perfect.

>> Probably not the most intelligent way to compute it, but you get the
>> idea. git info should give a brief overview over the current working
>> directory.
>
> Like what? None of the commands you suggested even touch it.
probably "current working directory" was not the best way to phrase it.
I mean state of the repository, which in my case is a clone of a central
repository.
My commands show (ignoring formatting): 1. the remote repositories with
URL 2. the current head commit hash 3. the date of the head commit.
Which gives a pretty decent idea about the state of the repository.

> Would
>
>     git remote -r -v && git log --max-count=1 --pretty=format:'%h %s'
>
> do what you think is what you need?
perhaps, the first command gives me an error (git 1.5.2.5). This here is
nearly ok

git remote && git log --max-count=1 --pretty=format:'%H %cD'

except the missing URL from git remote (but perhaps your options include
it with a newer git version, will test).

> May I suggest you to consider just running "git fetch -v"?
this is has side effects, and is quite slow. Your command sequence above
  is more handy (and faster).

So I can emulate git info with an alias, and this is good enough for mew
now, thanks for the hints. Perhaps a somewhat more elaborate version of
git info might be useful for others, too, but this is not urgent.

Thomas
