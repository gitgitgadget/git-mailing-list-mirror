From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cg-update with local uncommitted changes
Date: Thu, 2 Jun 2005 23:14:44 +0200
Message-ID: <20050602211444.GF32189@pasky.ji.cz>
References: <1117463114.7072.185.camel@pegasus> <20050530183932.GB10439@pasky.ji.cz> <1117480796.7072.204.camel@pegasus> <1117481244.7072.209.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 23:15:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddx0o-0001E1-WC
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 23:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVFBVQj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 17:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVFBVQP
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 17:16:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17111 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261231AbVFBVOv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 17:14:51 -0400
Received: (qmail 13721 invoked by uid 2001); 2 Jun 2005 21:14:44 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1117481244.7072.209.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 30, 2005 at 09:27:24PM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> Hi Petr,

Hello,

> let me be more specific. It only works in the fast forward case. If we
> actually must merge the trees, because I have local committed changes
> and not committed changes, I see this:
> 
> link 74966c42ddd874192c318acfc5f013e56c50606a
> link b27ddcd47e293557e0605b98b2a1e8429035cdc5
> link 568ad7814e266f84b4ac28c15a0cadfb2fdb6c80
> Tree change: f345b0a066572206aac4a4f9a57d746e213b6bff:74966c42ddd874192c318acfc5f013e56c50606a
> :100644 100644 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 568ad7814e266f84b4ac28c15a0cadfb2fdb6c80 M      README
> 
> Applying changes...
> usage.c: needs update
> cg-merge: merge blocked: local changes
> 
> I changed the README in test1 repository and committed it. Then I
> changed Makefile in test2 repository and committed it. After that I
> modified usage.c and left it uncommitted. Then I pulled in the README
> change from test1 repository.

yes, and that is all right. If you are actually doing the merge with
commit, you need to have the tree clean before, since any changes you
make to the tree are counted as conflict fixes, and you don't want your
older changes to mix into that.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
