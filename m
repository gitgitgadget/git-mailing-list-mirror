From: Junio C Hamano <junkio@cox.net>
Subject: Linus repository at git.kernel.org???
Date: Wed, 11 Jan 2006 23:19:58 -0800
Message-ID: <7vr77dud41.fsf@assigned-by-dhcp.cox.net>
References: <2cd57c900601112153t2d85895bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Thu Jan 12 08:20:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewwkf-0008Mt-FG
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 08:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWALHUB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 02:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWALHUB
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 02:20:01 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:1424 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030278AbWALHUA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 02:20:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112071851.IDQW6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 02:18:51 -0500
To: Coywolf Qi Hunt <coywolf@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14550>

Coywolf Qi Hunt <coywolf@gmail.com> writes:

> gemini:~/linux/linux-2.6> git-pull
> fatal: unexpected EOF
> Fetch failure: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

The failure does not seem to happen on all repositories, but
just is with Linus repository, so I doubt "git update" on either
your end or kernel.org public machines have anything to do with
this.  And Linus repository from gitweb is also missing.

I do not have more access to the mirrored public machines than
you have.  I can try snooping the traffic from git-peek-remote
to git://git.kernel.org/ but cannot examine the filesystem over
there, so I cannot tell you more than this: I looked at Linus
repository on the mirror source machine and did not see anything
obviously wrong with it.  It seemed to have updated around 3-4
hours ago.
