From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use the template mechanism to set up refs/ hierarchy as well.
Date: Thu, 04 Aug 2005 13:50:03 -0700
Message-ID: <7v7jf1xw90.fsf@assigned-by-dhcp.cox.net>
References: <7v3bprjzzg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508042038200.23886@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7vll3hxykj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508042215430.24657@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 22:58:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0mmF-0004Bq-TW
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 22:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVHDUyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 16:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbVHDUwF
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 16:52:05 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:44960 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262679AbVHDUuG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 16:50:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050804205003.PHQF8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 Aug 2005 16:50:03 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508042215430.24657@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 4 Aug 2005 22:19:10 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I'd like to not being forced to install git. Scenario: I have an SSH 
> account on a remote machine. I am not root there, but I'd like to 
> synchronize my work with git. I can not install git.

Sorry, but now you completely lost me.  You want git, you are
not root, you cannot install git system wide, so you run git
installed in your $HOME/bin somewhere instead.  I think I am
following you correctly up to this point.

But if that is the case, I do not see where your objections to
the template directory installed somewhere under $HOME/etc comes
from, which is what the default Makefile does, or at least
attempts to.
