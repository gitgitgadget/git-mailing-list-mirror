From: "David S. Miller" <davem@davemloft.net>
Subject: Re: Please undo "Use git-merge instead of git-resolve in git-pull"
Date: Wed, 21 Sep 2005 17:28:49 -0700 (PDT)
Message-ID: <20050921.172849.103555057.davem@davemloft.net>
References: <Pine.LNX.4.58.0509211310150.2553@g5.osdl.org>
	<7vu0genlc1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509211501130.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 02:29:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIExS-0004a4-RA
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 02:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbVIVA2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 20:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbVIVA2z
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 20:28:55 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:30185
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965193AbVIVA2x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 20:28:53 -0400
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.52)
	id 1EIExG-00011q-3t; Wed, 21 Sep 2005 17:28:50 -0700
To: torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.58.0509211501130.2553@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9088>

From: Linus Torvalds <torvalds@osdl.org>
Date: Wed, 21 Sep 2005 15:03:39 -0700 (PDT)

> I've always multi-tasked, but when I started git I was ready to drop it. 
> Then I came up with that wonderful "merge in the index" approach, and I 
> could do it again, and I was _soo_ happy.
> 
> I often have local changes in my tree that I don't want to commit but that 
> I'm testing out. Havign them interfere with merging other peoples work 
> would mean that I'd have to have a totally separate tree for that, which I 
> could do, but I'm much much happier not having to.

You know, I personally was unaware that this was supported until now.
I have been always reverting local debugging changes in order to merge
other people's work in, then reapply the debugging changes afterwards.

I guess I won't have to do that any more. :-)

So as long as they don't interfere, you can keep local debugging
changes out of GITs way for just about anything right?  For example,
as long as you don't "git-update-cache foo.c" those files in your
local debugging hack, you can just "git commit" afterwards and
only put in the changes you want.  It won't myseriously find those
modified files and what to do something with them right?

This goes with the idea that GIT only works with what you tell it
about, I suppose.
