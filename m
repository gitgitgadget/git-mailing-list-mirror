From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: cg-update with local uncommitted changes
Date: Thu, 02 Jun 2005 23:26:54 +0200
Message-ID: <1117747614.3656.2.camel@pegasus>
References: <1117463114.7072.185.camel@pegasus>
	 <20050530183932.GB10439@pasky.ji.cz> <1117480796.7072.204.camel@pegasus>
	 <1117481244.7072.209.camel@pegasus>  <20050602211444.GF32189@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 23:29:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdxF3-0003f0-6H
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 23:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVFBVav (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 17:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVFBV3b
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 17:29:31 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:58301 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261231AbVFBV1H
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 17:27:07 -0400
Received: from pegasus (p5487E5AB.dip.t-dialin.net [84.135.229.171])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j52LSoSs017952
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Thu, 2 Jun 2005 23:28:51 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050602211444.GF32189@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV 0.85.1/907/Thu Jun  2 14:50:12 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

> > let me be more specific. It only works in the fast forward case. If we
> > actually must merge the trees, because I have local committed changes
> > and not committed changes, I see this:
> > 
> > link 74966c42ddd874192c318acfc5f013e56c50606a
> > link b27ddcd47e293557e0605b98b2a1e8429035cdc5
> > link 568ad7814e266f84b4ac28c15a0cadfb2fdb6c80
> > Tree change: f345b0a066572206aac4a4f9a57d746e213b6bff:74966c42ddd874192c318acfc5f013e56c50606a
> > :100644 100644 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 568ad7814e266f84b4ac28c15a0cadfb2fdb6c80 M      README
> > 
> > Applying changes...
> > usage.c: needs update
> > cg-merge: merge blocked: local changes
> > 
> > I changed the README in test1 repository and committed it. Then I
> > changed Makefile in test2 repository and committed it. After that I
> > modified usage.c and left it uncommitted. Then I pulled in the README
> > change from test1 repository.
> 
> yes, and that is all right. If you are actually doing the merge with
> commit, you need to have the tree clean before, since any changes you
> make to the tree are counted as conflict fixes, and you don't want your
> older changes to mix into that.

but not if the merge does not conflict with the local changes. This is
what Bitkeeper is doing. It lets you pull new stuff as long as it does
not conflict with your local uncommitted changes. Actually I liked that
feature a lot, because I was able the follow the latest Linux mainline
tree and work on my stuff.

Regards

Marcel


