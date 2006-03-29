From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull fails
Date: Tue, 28 Mar 2006 16:40:30 -0800
Message-ID: <7vu09igk1t.fsf@assigned-by-dhcp.cox.net>
References: <20060328162831.af1bd4c0.tihirvon@gmail.com>
	<20060328141140.GC3113@linux-mips.org>
	<20060328173827.3d64d91e.tihirvon@gmail.com>
	<200603281700.17233.astralstorm@o2.pl>
	<20060328224807.GC27689@pasky.or.cz>
	<20060329031136.e0389c00.tihirvon@gmail.com>
	<20060329002415.GG27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 02:40:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOOjk-0007yY-At
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 02:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWC2Akd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 19:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWC2Akd
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 19:40:33 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:41426 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750712AbWC2Akc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 19:40:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060329004031.FLOW6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Mar 2006 19:40:31 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060329002415.GG27689@pasky.or.cz> (Petr Baudis's message of
	"Wed, 29 Mar 2006 02:24:15 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18150>

Petr Baudis <pasky@suse.cz> writes:

> If your current branch would really be a remote branch and you simply
> git-fetched, your HEAD would change but not your working tree, and at
> that moment things would become very confusing. Cogito would start
> showing nonsensical stuff for cg-status and cg-diff (as well as
> git-diff-tree HEAD output), but your index would at least still be
> correct so I'm not sure how much attention do tools like git-diff pay to
> it, the level of messup would be proportional to that.

People want to leave tracking branches checked out, especially
when they are not developers but are "update to the latest and
compile the bleeding edge" types.  Support for that mode of
operation was invented long time ago and git-pull knows about
it, and the idea was ported to git-cvsimport recently.
