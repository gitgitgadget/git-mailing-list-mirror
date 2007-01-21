From: Willy Tarreau <w@1wt.eu>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Sun, 21 Jan 2007 14:43:08 +0100
Message-ID: <20070121134308.GA24090@1wt.eu>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 14:43:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8cyj-0006jY-Ug
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 14:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbXAUNnS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 08:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbXAUNnS
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 08:43:18 -0500
Received: from 1wt.eu ([62.212.114.60]:2112 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545AbXAUNnR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 08:43:17 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37323>

Hi Junio !

On Sun, Jan 21, 2007 at 03:20:06AM -0800, Junio C Hamano wrote:
> BTW, as the upcoming v1.5.0 release will introduce quite a bit of
> surface changes (although at the really core it still is the old
> git and old ways should continue to work), I am wondering if it
> would help people to try out and find wrinkles before the real
> thing for me to cut a tarball and a set of RPM packages.
> 
> Comments?

Anything you can do to make tester's life easier will always slightly
increase the number of testers. Hint: how often do you try random
software that requires that you first install CVS, SVN or arch just to
get it, compared to how often you try random software provided as tar.gz ?
Pre-release tar.gz and rpms coupled with a freshmeat announcement should
get you a bunch of testers and newcomers. This will give the new doc a
real trial, and will help discover traps in which beginners often fall.

> Also, in the same spirit of giving the release an early
> exposure, here is the current draft of 1.5.0 release notes.

(...)

>  - There is a configuration variable core.legacyheaders that
>    changes the format of loose objects so that they are more
>    efficient to pack and to send out of the repository over git
>    native protocol, since v1.4.2.  However, loose objects
>    written in the new format cannot be read by git older than
>    that version; people fetching from your repository using
>    older clients over dumb transports (e.g. http) using older
>    versions of git will also be affected.
> 
>  - Since v1.4.3, configuration repack.usedeltabaseoffset allows
>    packfile to be created in more space efficient format, which
>    cannot be read by git older than that version.

I know it's a bit late to ask, but if new on-disk format changes, isn't
it time to bump the version to 2.0 ? It would be easier for many people to
remember that GIT 1.X uses format version 1 and that GIT 2.X uses format
version 2 with backwards compatibility with 1.X. I also think that 1.5
is much more different from 1.0 than a mid-term 2.0 would be from current
1.5.

That said, kudos for the nice changelog !

Regards,
Willy
