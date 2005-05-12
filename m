From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Support projects including other projects
Date: Thu, 12 May 2005 01:46:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505120137200.30848-100000@iabervon.org>
References: <1115876231.3085.4.camel@kryten>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 07:39:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW6Q8-0007el-B5
	for gcvg-git@gmane.org; Thu, 12 May 2005 07:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVELFrM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 01:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVELFrM
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 01:47:12 -0400
Received: from iabervon.org ([66.92.72.58]:45061 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261175AbVELFrB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 01:47:01 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DW6Wo-0001Me-00; Thu, 12 May 2005 01:46:34 -0400
To: James Purser <purserj@ksit.dynalias.com>
In-Reply-To: <1115876231.3085.4.camel@kryten>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 12 May 2005, James Purser wrote:

> On Thu, 2005-05-12 at 15:19, Daniel Barkalow wrote:
> > If you think about it as git and cogito being entirely separate projects,
> > where users would be expected to have the right version of git most of the
> > time (or ever), this is true. But I think that cogito is as closely tied
> > to git as the kernel is to kbuild or kconfig; the difference is that git
> > is not solely available with cogito, like kbuild is solely available with
> > the kernel.
> I tend to disagree with you on this point. Cogito and Git share
> arelationship more akin to xorg and gnome and this is something I think
> Linus intended so that it would be very easy to build a layer on top of
> the git toolset. Cogito is great and it fills a need but give it time
> and other implementations and tool sets will come along that may
> supersede it.

The point of this feature is to support other implementations and tool
sets. If there weren't other things using the git core, there would be no
reason to leave the current situation where cogito simply includes the
complete contents of git-pb. The relationship between cogito and git is,
however, not at all like that between Gnome and x.org; gnome could not be
started until X was essentially completely stable for several years (after
which X could be reimplemented and extended, so long as it retained the
same API). Cogito, on the other hand, is being developed concurrently with
git, and substantially informs git development. The current cogito doesn't
work completely correctly with any mainline git, whereas the current Gnome
works with every x.org release as well as any XFree86 or most other X
servers since the mid 90's.

Also, any particular user is probably only going to use one git-based
system, but will almost certainly use many different X clients.

	-Daniel
*This .sig left intentionally blank*

