From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: openbsd version?
Date: Mon, 10 Oct 2005 17:31:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510101703380.23242@iabervon.org>
References: <8664s5gxl9.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0510100939320.14597@g5.osdl.org>
 <7vvf0542fs.fsf@assigned-by-dhcp.cox.net> <864q7pdvcn.fsf@blue.stonehenge.com>
 <7vll113yjs.fsf@assigned-by-dhcp.cox.net> <86ek6tcdou.fsf@blue.stonehenge.com>
 <Pine.LNX.4.63.0510102248570.10402@wbgn013.biozentrum.uni-wuerzburg.de>
 <86y851aydl.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 23:28:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP5Aq-0007xe-OD
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 23:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVJJV1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 17:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVJJV1F
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 17:27:05 -0400
Received: from iabervon.org ([66.92.72.58]:34065 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751189AbVJJV1E (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 17:27:04 -0400
Received: (qmail 32257 invoked by uid 1000); 10 Oct 2005 17:31:57 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Oct 2005 17:31:57 -0400
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86y851aydl.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9941>

On Mon, 10 Oct 2005, Randal L. Schwartz wrote:

> >>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> <sarcasm>Undocumented secret switches.  Nice.</sarcasm>  No wonder
> >> I couldn't find it.
> 
> Johannes> <optimism>Maybe he who found the documentation lacking is going to fix 
> Johannes> it?</optimism>
> 
> I'd be happy to do that.  But as a tech writer, I know that it's
> insane to not work at least from an implementor's rough draft, to at
> least understand the intent of a mechanism, if not the precise design.
> There's no implementor's rough draft here, so I can't help.

The mailing list thread on the subject is at:

 http://www.gelato.unsw.edu.au/archives/git/0509/8902.html

(That's the middle of the thread, when the patch was actually written. 
There's discussion before and after if you need more info.)

You can actually get a pretty good explanation of features, once you know 
they exist at all, by looking for the discussion on the list. This tends 
to at least give you the person who did the patch explaining how to use it 
to the person who wanted the feature. And it'll also tell you who the 
implementor was, so you can bug the right person directly. :)

What does get written about a feature generall ends up in the commit 
message for the commit that adds it, so that's another good place to look. 
(In this case, it's missing a "not" and description of an option, so it's 
quite rough as a draft.)

In this case:

 "git branch -d <name>" deletes a branch with that name; but it checks 
that you're not on that branch, and it checks that that branch doesn't 
have any commits which aren't merged into the current branch.
 "git branch -D <name>" deletes a branch, and skips the second check.

	-Daniel
*This .sig left intentionally blank*
