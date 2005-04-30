From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: questions about cg-update, cg-pull, and cg-clone.
Date: Sat, 30 Apr 2005 08:48:08 -0700
Message-ID: <20050430154808.GB5408@tumblerings.org>
References: <20050430005322.GA5408@tumblerings.org> <4272EF69.2090806@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	xpasky@machine.sinus.cz
X-From: git-owner@vger.kernel.org Sat Apr 30 17:45:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRu9T-0003ZU-SH
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 17:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVD3Pur (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 11:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVD3Puq
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 11:50:46 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:12265 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261260AbVD3Pub
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2005 11:50:31 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DRuCO-0007w2-AF; Sat, 30 Apr 2005 08:48:08 -0700
To: "David A. Wheeler" <dwheeler@dwheeler.com>
Content-Disposition: inline
In-Reply-To: <4272EF69.2090806@dwheeler.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 10:37:29PM -0400, David A. Wheeler wrote:
> Zack Brown wrote:
> >Now, if the update is clean, a cg-commit is invoked automatically,
> 
> Correct; cg-merge calls "cg-commit -C" (ignore cache)
> if the merge is clean.
> 
> >and if the
> >update is not clean, I then have to resolve any conflicts and give the 
> >cg-commit
> >command by hand.
> 
> Correct.
> 
> >But: what is the significance of either of these cg-commit
> >commands? Why should I have to write a changelog entry recording this 
> >merge? All
> >I'm doing is updating my tree to be current. Why should I have to 'commit' 
> >that
> >update?
> 
> I can't speak Petr, but I would guess that he's doing that because
> he's trying to avoid data loss.

So, what would be an appropriate comment for that commit? I have no idea
what is changing on my tree in that case, all I know is that I'm merging from
someone else. All I really want is their changes and their commit messages,
not one of my own that is meaningless.

So far I just type ^d when this happens, and leave the commit message blank.

Be well,
Zack

> 
> 
> --- David A. Wheeler
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
