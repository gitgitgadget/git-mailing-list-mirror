From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 17 May 2007 00:31:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705170017050.18541@iabervon.org>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net> <7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0705162057380.18541@iabervon.org> <7vzm44axzl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 17 06:31:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoXdr-0002kf-As
	for gcvg-git@gmane.org; Thu, 17 May 2007 06:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856AbXEQEbD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 00:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756363AbXEQEbD
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 00:31:03 -0400
Received: from iabervon.org ([66.92.72.58]:2268 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755856AbXEQEbB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 00:31:01 -0400
Received: (qmail 15073 invoked by uid 1000); 17 May 2007 04:31:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 May 2007 04:31:00 -0000
In-Reply-To: <7vzm44axzl.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47497>

On Wed, 16 May 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Wed, 16 May 2007, Junio C Hamano wrote:
> > ...
> >> * db/remote (Tue May 15 22:50:19 2007 -0400) 5 commits
> >>  - Update local tracking refs when pushing
> >>  - Add handlers for fetch-side configuration of remotes.
> >>  - Move refspec parser from connect.c and cache.h to remote.{c,h}
> >>  - Move remote parsing into a library file out of builtin-push.
> >>  + git-update-ref: add --no-deref option for overwriting/detaching
> >>    ref
> >
> > AFAICT, this isn't really in my topic. Rebased too much, perhaps?
> 
> You have a new call to lock_any_ref_for_update() in the last
> patch in your series, whose function signature is changed by
> Sven's "add --no-deref".
> 
> Because the latter is already scheduled for 'master' post 1.5.2,
> I rebased the remote series on top of it, to adjust to the
> change early (i.e. while my memory is still fresh).
> 
> That's what
> 
> 	This was rebased on to Sven's change to lock_any_ref_for_update();
> 
> comment was about in the earlier "[2/4] What's not in 1.5.2" message.

Oh, okay. I noticed the change, but missed that what it was rebased 
onto wasn't simply in the implicit base for the series, and also didn't 
realize that it was supposed to get listed that way. (I think it would be 
more clear to list merges of depended-on series rather than the contents 
of the series, when the depended-on series is also listed)

	-Daniel
*This .sig left intentionally blank*
