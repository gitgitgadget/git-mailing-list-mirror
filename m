From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Multi-ancestor read-tree notes
Date: Tue, 6 Sep 2005 16:25:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509061610080.23242@iabervon.org>
References: <Pine.LNX.4.63.0509050049030.23242@iabervon.org>
 <7virxeycod.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0509061228090.23242@iabervon.org>
 <7vbr36j75b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 22:25:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECjy0-0000fz-Ht
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 22:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbVIFUVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 16:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbVIFUVu
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 16:21:50 -0400
Received: from iabervon.org ([66.92.72.58]:4868 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750866AbVIFUVt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 16:21:49 -0400
Received: (qmail 32684 invoked by uid 1000); 6 Sep 2005 16:25:44 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Sep 2005 16:25:44 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr36j75b.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8143>

On Tue, 6 Sep 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Do you know if there's anything like case #16 in there? I'd be interested 
> > to know if there's anything that gets handled automatically in different 
> > ways depending on which single base is used, and doesn't require manual 
> > intervention with multiple bases, because that's probably wrong.
> 
> Re-running the tests with the attached patch shows there weren't any.

Good. (Although that patch doesn't seem to be directly on top of my 
version; I can tell what it's doing anyway)

> > Great. Want me to send the patches with better organization, or are you 
> > set with what I've sent?
> 
> That's up to you.  If you are content with what I have in the pu
> branch, there is no need to bother resending.  OTOH if you have
> further clean-ups in mind, i.e. "better organization" above, I
> do not mind dropping the current ones from "pu" and replace them
> with another set from you.

I'm happy with the content in "pu"; the issue is just whether you want the 
history cleaned up more. In the series I sent, I kept forgetting parts 
that belonged in earlier patches.

Could you look over the documentation in 
Documentation/technical/trivial-merge.txt, and see if it's a suitable 
replacement for the table in t1000-read-tree-m-3way.sh? It should be the 
same, except for ALT or non-ALT versions that we're not using, combining a 
few matching cases, describing the rules behind index requirements rather 
than listing outcomes, and the addition of info on how multiple ancestors 
are handled.

	-Daniel
*This .sig left intentionally blank*
