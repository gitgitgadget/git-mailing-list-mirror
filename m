From: Junio C Hamano <junkio@cox.net>
Subject: Re: git commit question
Date: Mon, 29 Aug 2005 13:36:27 -0700
Message-ID: <7vd5nwa3as.fsf@assigned-by-dhcp.cox.net>
References: <431368D0.40604@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 22:37:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9qMq-0006as-Hk
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 22:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbVH2Uga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 16:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbVH2Uga
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 16:36:30 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:42462 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751295AbVH2Ug3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 16:36:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050829203627.YYIQ8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 Aug 2005 16:36:27 -0400
To: Ben Greear <greearb@candelatech.com>
In-Reply-To: <431368D0.40604@candelatech.com> (Ben Greear's message of "Mon,
	29 Aug 2005 12:58:08 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7925>

Ben Greear <greearb@candelatech.com> writes:

> Is there a way to tell it to add all modified files (that git commit mentions)
> to the cache for commit, or do I have to not be so lazy and
> paste them all on the cmd line?

Perhaps 'git commit -a' is what you want (it is documented;
http://www.kernel.org/pub/software/scm/git/docs/, especially
git-commit-script.html there).
