From: Petr Baudis <pasky@ucw.cz>
Subject: Re: I want to release a "git-1.0"
Date: Tue, 31 May 2005 02:19:16 +0200
Message-ID: <20050531001916.GD10439@pasky.ji.cz>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 02:18:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcuS3-0007GB-Ec
	for gcvg-git@gmane.org; Tue, 31 May 2005 02:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVEaAUL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 20:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVEaATa
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 20:19:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:666 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261598AbVEaATT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 20:19:19 -0400
Received: (qmail 865 invoked by uid 2001); 31 May 2005 00:19:16 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 30, 2005 at 10:00:42PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> Ok, I'm at the point where I really think it's getting close to a 1.0, and
> make another tar-ball etc. I obviously feel that it's already way superior
> to CVS, but I also realize that somebody who is used to CVS may not 
> actually realize that very easily.

Can we (well, me) count on the output format of the git commands being
stabilized now and not change in a backwards-incompatible way from now
on? I would like to finally remove the git itself from Cogito, but for
that I have to be able to rely on the fact that as long as the user has
git version >=N, it will work (assuming that Cogito is bugless ;-).

> So before I do a 1.0 release, I want to write some stupid git tutorial for
> a complete beginner that has only used CVS before, with a real example of
> how to use raw git, and along those lines I actually want the thing to
> show how to do something useful.

Is there actually much point in using raw git directly? You don't
usually invoke the syscalls directly from the user programs either (and
you usually actually use stdio for the casual stuff). I guess the
raw git usage can get quite long and tiresome sometimes.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
