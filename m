From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re-done kernel archive - real one?
Date: Tue, 19 Apr 2005 00:48:52 +0200
Message-ID: <20050418224852.GM5554@pasky.ji.cz>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org> <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org> <20050418102332.A21081@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504180802060.7211@ppc970.osdl.org> <20050418225356.B16789@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 00:45:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNez8-0002hv-5N
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 00:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVDRWsz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 18:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVDRWsz
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 18:48:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:21680 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261158AbVDRWsx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 18:48:53 -0400
Received: (qmail 17242 invoked by uid 2001); 18 Apr 2005 22:48:52 -0000
To: Russell King <rmk@arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050418225356.B16789@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 11:53:57PM CEST, I got a letter
where Russell King <rmk@arm.linux.org.uk> told me that...
> Maybe Petr can improve the error handling, and incorporate it (or at
> least some of it) into git-pasky

This does not need to touch git pull at all now; all the relevant logic
can change in git merge (and git commit), and I'm hacking that now. It
should be rather easy, I think.

I think I won't make git merge commit automatically - I think the user
should get a chance to do a git diff on what is getting merged to check
if everything is all right.

What is actually a little annoying is having to cd ,,merge and then
back, though. I don't know, but the current pull-merge script does not
bother with the temporary merge directory neither, even though Linus
wanted it. Linus, do you still do? ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
