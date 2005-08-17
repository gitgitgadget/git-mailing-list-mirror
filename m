From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitk with hyperspace support
Date: Tue, 16 Aug 2005 23:58:11 -0700
Message-ID: <7vr7ct124c.fsf@assigned-by-dhcp.cox.net>
References: <17154.33520.584666.701545@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 08:58:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5HsO-00069c-2D
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 08:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVHQG6N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 02:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbVHQG6N
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 02:58:13 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:64749 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750935AbVHQG6M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 02:58:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817065812.VUUM25443.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 02:58:12 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17154.33520.584666.701545@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Wed, 17 Aug 2005 10:21:04 +1000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:

> My reasoning is that it is the local short-range connections which are
> interesting and informative.  The long-range connections aren't really
> visually informative; if you want to know about the long-range
> connections, the parent and child lists in the details pane are much
> more useful.

Correct.

The new output looks a lot less cluttering and I like it very
much, but it is confusing to me on one count.  I clicked one
arrowhead pointing downward, expecting that the pane would jump
scroll to show the counterpart arrowhead, and was dissapointed
that it did not happen.  I could click the "Parent" link at that
point, but then the upward arrow was above and outside the
visible portion of that pane, which broke visual continuity and
I lost track at that point.  I think my being color challenged
exacerbated the resulting confusion; otherwise I could have
probably found the line with the same color as the color of the
downarrow I clicked.

> http://ozlabs.org/~paulus/gitk/gitk.hs

I first thought you rewrote it in Haskell ;-).
