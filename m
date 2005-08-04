From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use the template mechanism to set up refs/ hierarchy as well.
Date: Thu, 04 Aug 2005 14:35:49 -0700
Message-ID: <7vmznxwfka.fsf@assigned-by-dhcp.cox.net>
References: <7v3bprjzzg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508042038200.23886@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7vll3hxykj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508042215430.24657@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7v7jf1xw90.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508042311370.24861@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 01:06:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0onB-0001me-5T
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 01:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVHDWmB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 18:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVHDViI
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 17:38:08 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:7611 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262717AbVHDVfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 17:35:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050804213550.FKUT1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 Aug 2005 17:35:50 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508042311370.24861@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 4 Aug 2005 23:13:47 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Sorry, I am so used to not installing in my home because of small quotas 
> :-(
>
> Anyway, my usual setup is that I check git out from my private branch, add 
> that directory to my path, and every once in a while do a "git pull origin 
> && make test". Right now, it works.

Oh, I see.  Then the "templates/Makefile building into
templates/blt and then installing if you say make install"
approach I described earlier would hopefully work perfectly well
for you.  Just like you tack the $src to your $PATH, you can
define GIT_TEMPLATE_DIRECTORY to $src/templates/blt.  Problem
solved.
