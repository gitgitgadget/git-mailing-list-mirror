From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git-pasky "tutorial"
Date: Tue, 26 Apr 2005 21:57:52 +0200
Message-ID: <20050426195752.GG13224@pasky.ji.cz>
References: <1114306508.5444.7.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 21:53:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQW72-00057o-6q
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 21:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVDZT6C (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 15:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVDZT6C
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 15:58:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:15503 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261762AbVDZT5y (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 15:57:54 -0400
Received: (qmail 22178 invoked by uid 2001); 26 Apr 2005 19:57:52 -0000
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Disposition: inline
In-Reply-To: <1114306508.5444.7.camel@gaston>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 24, 2005 at 03:35:08AM CEST, I got a letter
where Benjamin Herrenschmidt <benh@kernel.crashing.org> told me that...
> Hi !

Hi,

> Is it really only my own stupidity, or is the "tutorial" in the README
> file in there only understandable if you in fact already know what it
> tries to explain ?
> 
> The more I read it, the more confused I am about the whole thing...
> 
> Is there some document somewhere that starts by explaining what are the
> concepts of "branch", "tracking", etc... in the context of git ?

you might want to try again with cogito-0.8; I hope I simplified the
concepts a lot.

There is no tracking, and branches are trivial - branches correspond to
repositories. When you do cg-init <remoterepo>, you get a branch origin
which represents the remoterepo (and gets updated when you do cg-pull or
cg-update), you can make Cogito know of more remote repositories by
doing cg-branch-add.


Yes, the README sucks; but apparently it helps at least some people. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
