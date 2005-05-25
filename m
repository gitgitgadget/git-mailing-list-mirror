From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-cache path restriction fix.
Date: Tue, 24 May 2005 19:33:13 -0700
Message-ID: <7vfywcox06.fsf@assigned-by-dhcp.cox.net>
References: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org>
	<7vekbwru6x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241814220.2307@ppc970.osdl.org>
	<7v3bscqdlr.fsf@assigned-by-dhcp.cox.net>
	<87u0kscaob.fsf@windlord.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 04:32:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DalgM-0005il-V7
	for gcvg-git@gmane.org; Wed, 25 May 2005 04:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVEYCdV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 22:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVEYCdU
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 22:33:20 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:6631 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262243AbVEYCdR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 22:33:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525023313.JPDG16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 22:33:13 -0400
To: Russ Allbery <rra@stanford.edu>
In-Reply-To: <87u0kscaob.fsf@windlord.stanford.edu> (Russ Allbery's message
 of "Tue, 24 May 2005 19:16:20 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I do not think there is any right or wrong in this discussion,
so I would not make any more comment on this topic for now.

Your interpretation that "(a cmp-op b) is an assertion on a" is
one valid interpretation of a boolean expression.  I would
understand it if you say you are used to think of it as an
assertion about the left hand side.  I just do not think of it
that way.  Rather, to me, "(a cmp-op b)" (or an boolean
expression in any shape for that matter) as a whole is an
assertion, and it is simply easier for me if a and b are ordered
from left to right, to visually match ascending order.

But that is only because I am used to read programs written that
way.  Just like you are used to think of these expressions about
assertions of the left hand side.

