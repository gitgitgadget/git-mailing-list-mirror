From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git 1.0 Synopis (Draft v4)
Date: Tue, 16 Aug 2005 11:39:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508161123480.23242@iabervon.org>
References: <20050729082941.GD32263@mythryan2.michonline.com>
 <200507312215.j6VMFeqn030963@laptop11.inf.utfsm.cl>
 <20050815045546.GA7001@mythryan2.michonline.com> <7vr7cv7p61.fsf@assigned-by-dhcp.cox.net>
 <20050815065833.GE7001@mythryan2.michonline.com> <7v7jen6545.fsf@assigned-by-dhcp.cox.net>
 <20050815080218.GG7001@mythryan2.michonline.com> <7vhddr397g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508151453100.21501@iabervon.org> <7vy872fiin.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 17:38:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E53Th-0007PI-JU
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 17:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbVHPPfq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 11:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030182AbVHPPfq
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 11:35:46 -0400
Received: from iabervon.org ([66.92.72.58]:20486 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030181AbVHPPfq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 11:35:46 -0400
Received: (qmail 26814 invoked by uid 1000); 16 Aug 2005 11:39:04 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Aug 2005 11:39:04 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy872fiin.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 16 Aug 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
>
> > It might be worth putting the list of things left to do before 1.0 in the
> > tree (since they clearly covary), and it would be useful to know what
> > you're thinking of as preventing the release at any particular stage.
>
> Yeah, yeah.  Call me lazy.
>
> Excerpts from my "last mile to 1.0", my Itchlist, and pieces from
> random other messages since then.
>
> - Documentation. [I really need help here --- among ~7000 lines
>   there, I've written around 2500 lines, David Greaves another
>   2500, and Linus 1400.  And it is not very easy to proofread
>   what you wrote yourself.]

I'm not sure how done this can actually get before some sort of feature
freeze; the best ways to do things keeps changing as more convenient ways
are added. Once the new stuff is diverted to post-1.0, I'd be interested
in going through it.

> - git prune and git fsck-cache; think about their interactions
>   with an object database that borrows from another.  This
>   includes the case where .git/objects itself is symlinked to
>   somewhere else (i.e. running "git prune" that somewhere else
>   without consulting this repository would lose objects), and
>   alternates pointing at somewhere else (i.e. ditto).

It should be fine, but only if .git/refs is symlinked to the matching
place; this gives you the same repository with multiple working trees.
Having refs/ and objects/ directories that aren't always together would be
much less safe.

	-Daniel
*This .sig left intentionally blank*
