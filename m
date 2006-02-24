From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] New git-seek command with documentation and test.
Date: Thu, 23 Feb 2006 19:18:48 -0500
Message-ID: <20060224001848.GB21094@fieldses.org>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org> <87k6bxvmj6.wl%cworth@cworth.org> <Pine.LNX.4.64.0602141026570.3691@g5.osdl.org> <87fymlvgzv.wl%cworth@cworth.org> <Pine.LNX.4.64.0602141224110.3691@g5.osdl.org> <87d5hpvc8p.wl%cworth@cworth.org> <7vu0b1pntl.fsf@assigned-by-dhcp.cox.net> <87zmkhrf4y.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Feb 24 01:19:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCQfi-0003dS-7q
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 01:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWBXASz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 19:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWBXASz
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 19:18:55 -0500
Received: from mail.fieldses.org ([66.93.2.214]:15851 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S932225AbWBXASy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 19:18:54 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1FCQfY-0006vv-De; Thu, 23 Feb 2006 19:18:48 -0500
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <87zmkhrf4y.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16676>

On Thu, Feb 23, 2006 at 12:31:25PM -0800, Carl Worth wrote:
> --- /dev/null
> +++ b/Documentation/git-seek.txt
> @@ -0,0 +1,44 @@
> +git-bisect(1)
> +=============

Oops.

> +When given a <revision>, git-seek updates the files in the working
> +tree to the state of the given revision. It will do this by performing
> +a checkout of <revision> to a new branch named "seek", or by resetting
> +the seek branch if it already exists.

I wonder if its a good idea to silently reset a branch named with a
short common word?

> +LONG_USAGE='git-seek provides a temporary excursion through the revision history.
> +
> +When given a <revision>, git-seek updates the files in the working
> +tree to the state of the given revision. It will do this by performing
> +a checkout of <revision> to a new branch named "seek", or by resetting
> +the seek branch if it already exists.

These long usage texts with language duplicated from the man pages seem
like they'd be asking for bit-rot, when an update happens in one place
but not the other.  I dunno.

--b.
