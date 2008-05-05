From: Bryan Donlan <bdonlan@fushizen.net>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Mon, 5 May 2008 00:25:46 -0400
Message-ID: <20080505042546.GA7164@shion.is.fushizen.net>
References: <20080416062925.8028e952@zebulon.innova-card.com> <20080416063739.4B72647879@blf.utvinternet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 06:26:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JssHw-0007xG-JP
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 06:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbYEEE0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 00:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYEEE0F
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 00:26:05 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:37887 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbYEEE0E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 00:26:04 -0400
Received: from [130.111.233.78] (helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1JssH4-0003t8-Ez
	for git@vger.kernel.org; Mon, 05 May 2008 04:26:02 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1JssGu-0003UZ-28
	for git@vger.kernel.org; Mon, 05 May 2008 00:25:52 -0400
Content-Disposition: inline
In-Reply-To: <20080416063739.4B72647879@blf.utvinternet.co.uk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81227>

On Wed, Apr 16, 2008 at 08:37:39AM +0200, Brian Foster wrote:
>    (many many apologies if this turns into a double post,
>   there seems to have been problems with the 1st attempt?)
> 
>  I've recently inherited a bare git repository,
>  which, as far as I can tell (I'm something of
>  a newbie with git), seems Ok: `git fsck --full'
>  does not report any problems.    however, any
>  clones I make from it are not Ok:
 
[snip]
 
>  explanations, suggestions, questions, &tc are all
>  very welcome.  (please keep in mind my current level
>  of knowledge/experience about git is very weak. ;-\ )
> 
>  this is all(?) using git 1.5.x (where the .x varies
>  depending on the machine in question); the distros
>  being used include ubuntu 7.10, FC-5, and probably
>  others.  (I'll check the filesystem tomorrow, but
>  I believe it's sane.)

Is there an info/grafts file? If the repository doesn't have sensitive
information in it, it would probably be helpful to tarball it up and
upload it somewhere, so we can take a look at things directly.
