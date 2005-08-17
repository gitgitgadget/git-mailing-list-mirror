From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitk with hyperspace support
Date: Wed, 17 Aug 2005 15:34:44 -0700
Message-ID: <7v4q9oqjjv.fsf@assigned-by-dhcp.cox.net>
References: <17154.33520.584666.701545@cargo.ozlabs.ibm.com>
	<7vr7ct124c.fsf@assigned-by-dhcp.cox.net>
	<17155.2581.888904.526537@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 00:36:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5WUk-0004ez-0z
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 00:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVHQWer (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 18:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVHQWer
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 18:34:47 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:17826 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751305AbVHQWeq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 18:34:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817223446.TLTH17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 18:34:46 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17155.2581.888904.526537@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Wed, 17 Aug 2005 19:57:41 +1000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:

> OK, you're the second person to ask for that, so I'll see what I can
> do about it.  I can think of 3 possible behaviors when you click on
> the arrowhead:
>
> 1. scroll to bring the other arrowhead on-screen and briefly make it
>    larger or something similar to draw attention to it
>
> 2. scroll to bring the other arrowhead on-screen and warp the pointer
>    to it
>
> 3. select the next commit in the indicated direction which is a child
>    or parent that the line connects (scroll to make it visible,
>    highlight it, show its diff).
>
> Which do you think would be best?

Hmph.  I think, aside from being color challenged, the primary
source of confusion for me was that the lines with arrowheads
were too long, and the node and the arrowhead did not fit within
the height of the graphical pane, at least with my window
configuration.

I wonder if not having downward or upward arrows for a long
stretch would work better.  Lose the vertical line for such
hyperspace links, and instead have a horizonal short line with
arrowheads to denote that there are also hyperspace lines coming
into or out of that node.  That way you can save one column for
a vertical line, and my preference for clicking on such an
arrowhead would be #3 from the above.
