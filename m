From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re-done kernel archive - real one?
Date: Tue, 19 Apr 2005 00:33:06 +0200
Message-ID: <20050418223306.GJ5554@pasky.ji.cz>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <20050417162448.A13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504170926410.7211@ppc970.osdl.org> <20050417195742.D13233@flint.arm.linux.org.uk> <20050418231652.C16789@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 00:29:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNek4-0001F1-Et
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 00:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVDRWdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 18:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVDRWdQ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 18:33:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3760 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261200AbVDRWdH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 18:33:07 -0400
Received: (qmail 15206 invoked by uid 2001); 18 Apr 2005 22:33:06 -0000
To: Russell King <rmk@arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050418231652.C16789@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 12:16:52AM CEST, I got a letter
where Russell King <rmk@arm.linux.org.uk> told me that...
> Ok, since the last one was soo successful, and I'm up for more
> punishment, here's another attempt.  The diffstat is rather
> interesting in this one, claiming no changes.  It should look
> like this:
> 
>  arch/arm/lib/bitops.h |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+)
> 
> However, it seems that git diff can't handle new files appearing
> yet.

Patches welcome. :^)

Actually it shouldn't be hard. Just for through add-queue/rm-queue and
diff it with /dev/null.

> The other interesting thing to note is that patches are generated
> for '-p0' rather than '-p1' application, which is contary to our
> historical requirements.  This is going to confuse people - can
> we make it generate -p1 patches please?

This should be fixed with latest Junio's show-diff changes. I might
change it to be identical with gitdiff-do output later though, using
tree ID and "uncommitted" as the directories instead of 'a' and 'b'.
It will stay -p1 now, though.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
