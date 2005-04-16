From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 19:43:27 +0200
Message-ID: <20050416174327.GG19099@pasky.ji.cz>
References: <20050416131528.GB19908@elte.hu> <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 19:40:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMrGp-0007C7-Mm
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 19:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVDPRnb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 13:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVDPRnb
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 13:43:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13186 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262709AbVDPRn3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 13:43:29 -0400
Received: (qmail 863 invoked by uid 2001); 16 Apr 2005 17:43:27 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 16, 2005 at 07:04:31PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> So I'd _almost_ suggest just starting from a clean slate after all.  
> Keeping the old history around, of course, but not necessarily putting it
> into git now. It would just force everybody who is getting used to git in 
> the first place to work with a 3GB archive from day one, rather than 
> getting into it a bit more gradually.
> 
> Comments?

FWIW, it looks pretty reasonable to me. Perhaps we should have a
separate GIT repository with the previous history though, and in the
first new commit the parent could point to the last commit from the
other repository.

Just if it isn't too much work, though. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
