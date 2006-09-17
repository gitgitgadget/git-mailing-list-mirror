From: Junio C Hamano <junkio@cox.net>
Subject: Re: Setting up Password protected repositories?
Date: Sat, 16 Sep 2006 18:24:45 -0700
Message-ID: <7virjn8eua.fsf@assigned-by-dhcp.cox.net>
References: <E1GOktx-0005JY-ER@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 03:24:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOlOr-0003hi-NN
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 03:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWIQBYr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 21:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWIQBYr
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 21:24:47 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:40610 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964891AbWIQBYq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 21:24:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917012445.DOQH21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sat, 16 Sep 2006 21:24:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PDQZ1V00S1kojtg0000000
	Sat, 16 Sep 2006 21:24:34 -0400
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1GOktx-0005JY-ER@jdl.com> (Jon Loeliger's message of "Sat, 16
	Sep 2006 19:52:53 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27147>

Jon Loeliger <jdl@jdl.com> writes:

> git-daemon has to know where to server out the files from,
> but how do we get it to enforce a ssh-based access?  It's
> easy to prevent http: from serving out the repository --
> just place it outside of the webroot directory structure.

It all depends on how you start git-daemon, but the last
parameters to git-daemon are path whitelist so presumably
placing the private repository outside of it should be enough.

Or am I missing something deeper?
