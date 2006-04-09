From: Junio C Hamano <junkio@cox.net>
Subject: Re: git ident
Date: Sun, 09 Apr 2006 12:01:38 -0700
Message-ID: <7v7j5ybmjx.fsf@assigned-by-dhcp.cox.net>
References: <44395711.7000902@jeremyenglish.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 21:02:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSfAO-0007Zh-T8
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 21:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWDITBl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 15:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWDITBl
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 15:01:41 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:24982 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750897AbWDITBl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 15:01:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060409190140.NJTY26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Apr 2006 15:01:40 -0400
To: Jeremy English <jhe@jeremyenglish.org>
In-Reply-To: <44395711.7000902@jeremyenglish.org> (Jeremy English's message of
	"Sun, 09 Apr 2006 13:48:49 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18559>

Jeremy English <jhe@jeremyenglish.org> writes:

> What I don't like is that the error comes up
> after I have typed in my comment, then my comment is lost, that's
> frustrating.

Sympathizable, but presumably a new user needs to be burned only
once (set them either in $HOME/.profile or .git/config if you
want to use separate identity per project).

> ....  The other thing is I don't care if the commit is coming
> from a valid person, why require this?

Because public projects like the kernel wants to prevent
otherwise good commits from a misconfigured repository to
propagate into them.  We could have a separate per-repository
configuration to say "broken identity is not a problem for this
project", but if the user has to set that in the configuration,
she would be better off setting her identity there.

And making it the default not to require the identity is going
backwards. Our primary focus is to support public, multi-person,
distributed development project.
