From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Thu, 22 Sep 2005 17:57:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509221747340.23242@iabervon.org>
References: <E1EIWUv-0004HR-F6@jdl.com> <Pine.LNX.4.58.0509221413400.2553@g5.osdl.org>
 <Pine.LNX.4.58.0509221427520.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 23:53:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIZ0H-0001cS-KJ
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 23:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVIVVxP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 17:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbVIVVxP
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 17:53:15 -0400
Received: from iabervon.org ([66.92.72.58]:5128 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751267AbVIVVxO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 17:53:14 -0400
Received: (qmail 17415 invoked by uid 1000); 22 Sep 2005 17:57:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Sep 2005 17:57:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509221427520.2553@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9147>

On Thu, 22 Sep 2005, Linus Torvalds wrote:

> Basically: having dirty state in your tree and then ending up having to do 
> a manual merge is a big pain. Not worth it. I just keep really small dirty 
> stuff so that I don't mind blowing it away if I need to.

Would it be worthwhile to have a flag to make git-read-tree abort rather 
than making a mess if you have any dirty state and the merge isn't 
completely automatic? It's certainly easy enough to write.

	-Daniel
*This .sig left intentionally blank*
