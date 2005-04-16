From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Add "clone" support to lntree
Date: Fri, 15 Apr 2005 23:06:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504152251300.30848-100000@iabervon.org>
References: <20050416024755.GX7417@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 05:03:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMdaJ-0006wt-Bg
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 05:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbVDPDGg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 23:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbVDPDGg
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 23:06:36 -0400
Received: from iabervon.org ([66.92.72.58]:11781 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262595AbVDPDGe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 23:06:34 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMde2-0004eR-00; Fri, 15 Apr 2005 23:06:54 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050416024755.GX7417@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Apr 2005, Petr Baudis wrote:

> Dear diary, on Sat, Apr 16, 2005 at 03:56:03AM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > I often want to take a base tree, which I keep tracking some remote head,
> > and make a local working tree that starts from it. This makes "git ln -c
> > <dest>" give you a tree that you can just start working in and then diff
> > against the head you'd started from and send off.
> > 
> > Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
> 
> I'm sorry but you are late, I added it about a hour and half ago or so.
> :-) Check git fork. (I *want* separate command than git lntree. In fact,
> I think I should make git lntree gitXlntree.sh instead, since it is
> really internal command for git-tools and the user should probably never
> need it for anything. git lntree is too lowlevel.)

Have you not pushed since? I don't see it.

I actually first made gitlntree.sh do the forking thing, because it didn't
seem useful as is, until I noticed that merge was already using it
internally.

> Actually, I don't like the name at all, though. Some people may find
> pondering about names pointless, but when I'm going to type them in
> every day for the rest of my life, they better should not be stupid. ;-)
> 
> So, what are your clever ideas about git fork's proper name? Or should
> we leave it as is?

I think "fork" is as good as anything for describing the operation. I had
thought about "clone" because it seemed to fill the role that "bk
clone" had (although I never used BK, so I'm not sure). It doesn't seem
useful to me to try cloning multiple remote repositories, since you'd get
a copy of anything common from each; you just want to suck everything into
the same .git/objects and split off working directories.

	-Daniel
*This .sig left intentionally blank*

