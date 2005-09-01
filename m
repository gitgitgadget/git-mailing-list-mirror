From: Junio C Hamano <junkio@cox.net>
Subject: Re: Couple of read-tree questions
Date: Wed, 31 Aug 2005 23:32:36 -0700
Message-ID: <7vvf1l1env.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509010009350.23242@iabervon.org>
	<7vll2h4bc8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509010138370.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 08:34:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAicr-0005GE-MT
	for gcvg-git@gmane.org; Thu, 01 Sep 2005 08:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbVIAGci (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Sep 2005 02:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbVIAGci
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Sep 2005 02:32:38 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:22185 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965058AbVIAGci (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2005 02:32:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050901063236.HPQX3414.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Sep 2005 02:32:36 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509010138370.23242@iabervon.org> (Daniel
	Barkalow's message of "Thu, 1 Sep 2005 02:16:17 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7993>

Daniel Barkalow <barkalow@iabervon.org> writes:

> (The thread you mention seems to say that we accept entries being missing 
> from the index as if they were unchanged, but I don't see a good reason 
> for this; you'd be dealing with the full set in the index for the merge, 
> even if you don't have a populated working tree)

You are correct.  I was wondering myself why *both* of us
thought (or Linus *seemed* to be agreeing, at least to me) what I
was referring to as I+H made any sense while re-reaing the
thread.

> I should have asked sooner, then. :) There's a bunch of clutter to get it 
> to work that I can remove if it's not actually necessary.

Yeah, removal of dead code!  Go wild, please.
