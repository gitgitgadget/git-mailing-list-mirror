From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into .git/config
Date: Mon, 28 Nov 2005 01:14:15 -0800
Message-ID: <7vpsolxhg8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051127125945.GD22159@pasky.or.cz>
	<Pine.LNX.4.63.0511280248020.12343@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfyph1ebq.fsf@assigned-by-dhcp.cox.net> <438AC32E.5010100@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 28 10:15:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egf5Z-0008Li-IJ
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 10:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVK1JOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 04:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVK1JOR
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 04:14:17 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:49087 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750754AbVK1JOR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 04:14:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128091250.EGEX17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 04:12:50 -0500
To: git@vger.kernel.org
In-Reply-To: <438AC32E.5010100@op5.se> (Andreas Ericsson's message of "Mon, 28
	Nov 2005 09:43:26 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12863>

Andreas Ericsson <ae@op5.se> writes:

> I'd still like to see git-repo-config and git-user-config. Otherwise 
> we'll need to continue having user-based environment variables 
> (GIT_COMMITTER_IDENT and friends).

Since .git/config is not shared across repositories even on
clone (and is deliberately so), "git-repo-config user.name" is
for you to set *your* name.

Having said that, GIT_COMMITTER_IDENT and friends are there to
stay, because that is how you override what you get from the
config file per commit, which is needed for people playing the
integrator role.  When one is playing an individual developer
role, user.name or even not having any and relying on GECOS is
often good enough.
