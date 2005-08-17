From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk with hyperspace support
Date: Wed, 17 Aug 2005 19:57:41 +1000
Message-ID: <17155.2581.888904.526537@cargo.ozlabs.ibm.com>
References: <17154.33520.584666.701545@cargo.ozlabs.ibm.com>
	<7vr7ct124c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 11:59:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5KgF-00057z-Vi
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 11:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbVHQJ5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 05:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbVHQJ5t
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 05:57:49 -0400
Received: from ozlabs.org ([203.10.76.45]:23485 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751028AbVHQJ5t (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2005 05:57:49 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0C00967FC9; Wed, 17 Aug 2005 19:57:48 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7ct124c.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:

> The new output looks a lot less cluttering and I like it very
> much, but it is confusing to me on one count.  I clicked one
> arrowhead pointing downward, expecting that the pane would jump
> scroll to show the counterpart arrowhead, and was dissapointed

OK, you're the second person to ask for that, so I'll see what I can
do about it.  I can think of 3 possible behaviors when you click on
the arrowhead:

1. scroll to bring the other arrowhead on-screen and briefly make it
   larger or something similar to draw attention to it

2. scroll to bring the other arrowhead on-screen and warp the pointer
   to it

3. select the next commit in the indicated direction which is a child
   or parent that the line connects (scroll to make it visible,
   highlight it, show its diff).

Which do you think would be best?

> > http://ozlabs.org/~paulus/gitk/gitk.hs
> 
> I first thought you rewrote it in Haskell ;-).

Hmmm, maybe it's apache on ozlabs.org that is under that
misapprehension?

Thanks,
Paul.
