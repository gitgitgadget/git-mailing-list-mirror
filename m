From: Junio C Hamano <junkio@cox.net>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Thu, 22 Sep 2005 15:22:39 -0700
Message-ID: <7vk6h8lp3k.fsf@assigned-by-dhcp.cox.net>
References: <E1EIVsD-0001Hu-9m@jdl.com> <20050922191058.GM21019@pasky.or.cz>
	<BAYC1-PASMTP0510EEC44C7F787F27215AAE970@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 00:24:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIZSz-0000CB-AE
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 00:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVIVWWl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 18:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVIVWWl
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 18:22:41 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:56477 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751134AbVIVWWl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 18:22:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050922222239.DYQJ29515.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Sep 2005 18:22:39 -0400
To: "Sean" <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP0510EEC44C7F787F27215AAE970@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Thu, 22 Sep 2005 15:25:34 -0400
	(EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9150>

"Sean" <seanlkml@sympatico.ca> writes:

> Why doesn't cogito just use the git fetch/pull commands?   Why does it
> need anything special?   It seems like cogito is doing more than just
> being an ease-of-use layer above git.

The way this question is posed is quite unfair to Pasky -- it
makes him look needlessly bad.

The simple reason is because Cogito had its own richer
fetch/pull first.  The development of git aware pack transfer
protocols by Linus and the list discussion for multi-head pushes
and pulls came much later, which resulted in the current 'git
fetch/pull' interface.
