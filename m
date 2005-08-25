From: Junio C Hamano <junkio@cox.net>
Subject: Re: baffled again
Date: Wed, 24 Aug 2005 20:26:21 -0700
Message-ID: <7vzmr63deq.fsf@assigned-by-dhcp.cox.net>
References: <200508232256.j7NMuR1q027892@agluck-lia64.sc.intel.com>
	<7vek8jhk7y.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508241140290.3317@g5.osdl.org>
	<Pine.LNX.4.58.0508241152240.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tony.luck@intel.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 05:27:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E88O3-0003LZ-HL
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 05:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVHYD00 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 23:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbVHYD00
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 23:26:26 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:51438 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964777AbVHYD00 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2005 23:26:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050825032621.MILP16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 Aug 2005 23:26:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7739>

Linus Torvalds <torvalds@osdl.org> writes:

> In fact, the case that git selected ("patch applied"), is not only the one
> that is very fundamentally the one git will always select in this kind of
> situation - in some respects is actually the nicer choice of the two.

While I appreciate the excuse for not taking immediate and hasty
action, I have two problems with your analysis.

 * I am not yet convinced that it is _not_ by accident that git
   ended up choosing the nicer choice of the two.

 * Even if it does always choose the nicer choice of the two,
   Tony was lucky (no pun intended).  Rather, we were lucky that
   Tony was observant.  A careless merger may well have easily
   missed this mismerge (from the human point of view).
