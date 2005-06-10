From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk-1.1 out
Date: Fri, 10 Jun 2005 19:56:19 +1000
Message-ID: <17065.25539.657361.964397@cargo.ozlabs.ibm.com>
References: <17053.35147.52729.794561@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0506080743040.2286@ppc970.osdl.org>
	<17064.15104.847009.390149@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0506090728280.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 12:38:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgguD-0004LS-PL
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 12:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVFJKmo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 06:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVFJKmo
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 06:42:44 -0400
Received: from ozlabs.org ([203.10.76.45]:41112 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261300AbVFJKmk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2005 06:42:40 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id D813E67B65; Fri, 10 Jun 2005 20:42:38 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506090728280.2286@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds writes:

> However, I also changed it to allow the "direct" kinds of tags which the 
> cvs2git thing creates, where the tag file contains just a direct pointer 
> to the commit, rather than a pointer to a tag object.
> 
> I'm not a TCL weenie, so this is just a very quick hack, and you may want 
> to re-do things properly, but something like the appended works for me..

I'll use file tail instead of regexp, but apart from that it looks
fine.

> > I also added a -t option to gitk which makes it use gitk-rev-tree
> > instead of git-rev-list, so that you can do
> > 
> > 	gitk -t $(ls .git/refs/heads)
> 
> No need, I think yoy may have an old version of git.

Ah yes, I did.  I'll take the -t option out then.

Paul.
