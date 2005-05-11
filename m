From: Petr Baudis <pasky@ucw.cz>
Subject: Re: History messup
Date: Wed, 11 May 2005 22:31:22 +0200
Message-ID: <20050511203122.GD22686@pasky.ji.cz>
References: <1115657971.19236.33.camel@tglx> <1115659677.16187.393.camel@hades.cambridge.redhat.com> <1115660903.19236.39.camel@tglx> <427FB3A7.8050906@zytor.com> <1115665598.12012.422.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed May 11 22:26:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVxkn-0004Ic-7y
	for gcvg-git@gmane.org; Wed, 11 May 2005 22:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVEKUbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 16:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbVEKUbl
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 16:31:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50880 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262044AbVEKUbY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2005 16:31:24 -0400
Received: (qmail 26700 invoked by uid 2001); 11 May 2005 20:31:22 -0000
To: David Woodhouse <dwmw2@infradead.org>
Content-Disposition: inline
In-Reply-To: <1115665598.12012.422.camel@baythorne.infradead.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 09, 2005 at 09:06:38PM CEST, I got a letter
where David Woodhouse <dwmw2@infradead.org> told me that...
> On Mon, 2005-05-09 at 12:01 -0700, H. Peter Anvin wrote:
> > Seems like a UUID or a SHA-1 identifier would be better.
> > 
> > However, one can definitely argue that even the meaning of "a 
> > repository" isn't well-defined in the context of git.
> 
> Of course it isn't. But neither is the meaning "a committer" or 
> "an author" or even "a date".
> 
> Including some kind of repo-specific identifier with each commit would
> help us to make sense of the history, just as those other fields do.

FWIW, I recently added .git/branch-name to Cogito, since I needed some
identifier through which to differentiate between the branches
(repositories - it's all blurred in Cogito view) when sending commits
to CIA.

It is strictly per-branch (never to be shared by multiple repositories),
optional, informative and more of a temporary solution for now I had to
cook together in a minute.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
