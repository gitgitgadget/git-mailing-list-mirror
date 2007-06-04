From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Mon, 4 Jun 2007 19:57:51 +0200
Message-ID: <20070604175751.GL19935@cip.informatik.uni-erlangen.de>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com> <alpine.LFD.0.98.0706040755560.23741@woody.linux-foundation.org> <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com> <alpine.LFD.0.98.0706040857380.23741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Childs <godeater@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 19:58:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvGoe-0002xv-6Z
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 19:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759272AbXFDR5x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 13:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759410AbXFDR5x
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 13:57:53 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:39568 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759395AbXFDR5x (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2007 13:57:53 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 7CC513F2FB; Mon,  4 Jun 2007 19:57:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706040857380.23741@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49120>

Hello,

>  - instead of doing a "git pull" that merges the two branches (your work, 
>    and the work that happened by somebody else in the central repo while 
>    you did it), you *may* also just want to do a "git fetch" to fetch the 
>    changes from the central repo, and then do "git rebase origin" to 
>    linearize the work you did on _top_ of those central repo one (so that 
>    it no longer looks like a branch, and looks linear)

>    In the "git rebase" case, you'll effectively merge your commits one at 
>    a time, and you may thus have to fix up *multiple* conflicts. So it's 
>    potentially more work, but it results in a simpler history if you want 
>    it.

Thank you a lot. I finally understood what "git rebase" is all about!

        Thomas
