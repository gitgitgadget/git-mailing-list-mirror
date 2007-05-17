From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 16 May 2007 22:07:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705162057380.18541@iabervon.org>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net> <7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 17 04:07:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoVP0-0000zT-4N
	for gcvg-git@gmane.org; Thu, 17 May 2007 04:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494AbXEQCHI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 22:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758268AbXEQCHI
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 22:07:08 -0400
Received: from iabervon.org ([66.92.72.58]:4771 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755494AbXEQCHG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 22:07:06 -0400
Received: (qmail 13598 invoked by uid 1000); 17 May 2007 02:07:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 May 2007 02:07:04 -0000
In-Reply-To: <7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47481>

On Wed, 16 May 2007, Junio C Hamano wrote:

> It probably would be more interesting to look at the earlier
> "What's not in 1.5.2" messages, but here is the current status
> of my tree on the 'next' and 'pu' front.
> 
> Here are the topics that have been cooking.  Commits prefixed
> with '-' are only in 'pu' while commits prefixed with '+' are
> in 'next'.  The topics list the commits in reverse chronological
> order.
> 
> * db/remote (Tue May 15 22:50:19 2007 -0400) 5 commits
>  - Update local tracking refs when pushing
>  - Add handlers for fetch-side configuration of remotes.
>  - Move refspec parser from connect.c and cache.h to remote.{c,h}
>  - Move remote parsing into a library file out of builtin-push.
>  + git-update-ref: add --no-deref option for overwriting/detaching
>    ref

AFAICT, this isn't really in my topic. Rebased too much, perhaps?

I've also got one more patch ready, which moves refspec pattern matching 
into match_refs, for a net reduction of 50 lines and much simpler logic.

I've also started making Julian Phillips' builtin-fetch use my parser, so 
I might have something ready before too long.

	-Daniel
*This .sig left intentionally blank*
