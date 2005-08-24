From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: baffled again
Date: Wed, 24 Aug 2005 15:33:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508241504580.23242@iabervon.org>
References: <200508232256.j7NMuR1q027892@agluck-lia64.sc.intel.com>
 <7vek8jhk7y.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508241140290.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, tony.luck@intel.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 21:31:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E80wk-0003W2-3a
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 21:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbVHXT37 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 15:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbVHXT37
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 15:29:59 -0400
Received: from iabervon.org ([66.92.72.58]:61709 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751437AbVHXT36 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 15:29:58 -0400
Received: (qmail 23466 invoked by uid 1000); 24 Aug 2005 15:33:32 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Aug 2005 15:33:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508241140290.3317@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7724>

On Wed, 24 Aug 2005, Linus Torvalds wrote:

> Now, if the shared patch hadn't been a patch, but a shared _commit_, then
> the thing would have been unambiguous - the shared commit would have been
> the merge point, and the revert would have clearly undone that shared
> commit.

Actually, it was a shared commit
(4aec0fb12267718c750475f3404337ad13caa8f5), which was (an ancestor of) a
candidate merge point, but wasn't the one selected. Since a different one
was chosen, it looked to the 3-way merge like a shared patch (since it
ignores the untaken parent in the merges in the history).

This should be fixable, but it'll require more cleverness in read-tree.

	-Daniel
*This .sig left intentionally blank*
