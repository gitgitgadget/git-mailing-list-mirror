From: Junio C Hamano <junkio@cox.net>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 19:24:40 -0700
Message-ID: <7v4qaeqrh3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0507281931180.30371@wgmdd8.biozentrum.uni-wuerzburg.de>
	<200507271458.43063.Josef.Weidendorfer@gmx.de>
	<7vll3rlnqm.fsf@assigned-by-dhcp.cox.net>
	<200507271458.43063.Josef.Weidendorfer@gmx.de>
	<20050728120806.GA2391@pasky.ji.cz>
	<Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de>
	<20050728153506.GL14229@pasky.ji.cz>
	<Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de>
	<20050728161815.GC17952@pasky.ji.cz>
	<7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net>
	<20050728183904.GA24948@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 04:25:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyKYY-0008T8-PX
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 04:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVG2CYv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 22:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVG2CYv
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 22:24:51 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:25755 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262256AbVG2CYn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 22:24:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050729022428.GNGE19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Jul 2005 22:24:28 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> One of the Cogito design bits is that branch name is something local to
> the repository. When you are adding a branch, the local name you assign
> it is your private thing repository-wise, and doesn't have to have any
> correlation to other repositories you might interact width.

I do not disagree with that.  I think branch name is mostly a
local matter.  However, I happen to think that two repositories
you use send-pack (not clone which uses completely different
protocol) to sync one from the other are semantically equivalent
ones, except that the destination may be a strict subset.  I
think of it as "a copy I throw at a public place to show what I
have in my private repository I work in", so,...
