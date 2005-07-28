From: Junio C Hamano <junkio@cox.net>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 09:52:45 -0700
Message-ID: <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de>
	<7vll3rlnqm.fsf@assigned-by-dhcp.cox.net>
	<200507271458.43063.Josef.Weidendorfer@gmx.de>
	<20050728120806.GA2391@pasky.ji.cz>
	<Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de>
	<20050728153506.GL14229@pasky.ji.cz>
	<Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de>
	<20050728161815.GC17952@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 18:54:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyBe2-00054W-5s
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 18:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVG1Qxf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 12:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVG1Qx1
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 12:53:27 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47562 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261724AbVG1Qwx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 12:52:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050728165242.FKZC17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Jul 2005 12:52:42 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050728161815.GC17952@pasky.ji.cz> (Petr Baudis's message of "Thu, 28 Jul 2005 18:18:15 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> AFAIK the plan is to centralize all the kernel repositories to a single
> one. For that, developers would generally push into branches with name
> different that "master".

I did not know about that plan, but that is interesting and now
I understand why you think it is important to be able for more
than one person to push into a single repository.

How will the namespace of N-hundred branches in that repository
be managed?  To avoid collisions, wouldn't there be some
coordination, and there will be branch names there that
everybody agrees that they are owned by you?

At that point, wouldn't it be easier for _you_ (as one kernel
developer who owns such globally unique branch names) to name
your branch you intend to push there the same way in your
working repository as well?
