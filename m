From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] whatchanged: customize diff-tree output
Date: Sat, 24 Dec 2005 01:44:27 -0800
Message-ID: <7vzmmqu8w4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512212336230.18908@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvexhr6rc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512212245440.4827@g5.osdl.org>
	<Pine.LNX.4.63.0512221200190.7112@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051222210620.GA4679@steel.home>
	<7vvexgfns4.fsf@assigned-by-dhcp.cox.net>
	<20051223182047.GB3165@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 24 10:44:45 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eq5x7-0002zI-LL
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 10:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422641AbVLXJoa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 04:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422642AbVLXJoa
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 04:44:30 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:24752 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1422641AbVLXJo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2005 04:44:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051224094347.QYIN3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Dec 2005 04:43:47 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14010>

> But you cannot know which ones you have to give, unless you parsed
> output of git-repo-config!

Why?

I was suggesting that you would literally write something like
this in your script:

	git-whatchanged --name-status "$1".."$2"

Then whatchanged uses the '--name-status', and ignores whatever
is in the repository configuration, so you do not need to care
what repo-config says.  Neither used are its built-in defaults.
