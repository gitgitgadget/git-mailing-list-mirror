From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-add + git-reset --hard = Arrrggh!
Date: Wed, 17 May 2006 17:35:16 -0400
Message-ID: <20060517213516.GA30313@spearce.org>
References: <20060517094526.GA8563@spearce.org> <81b0412b0605170722u15702301p2565e8ac29a5a0da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 23:35:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgTfw-0005Wz-Bk
	for gcvg-git@gmane.org; Wed, 17 May 2006 23:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWEQVfV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 17:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWEQVfV
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 17:35:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38618 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751126AbWEQVfU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 17:35:20 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgTfh-0005Mi-Kk; Wed, 17 May 2006 17:35:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 17248212667; Wed, 17 May 2006 17:35:17 -0400 (EDT)
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0605170722u15702301p2565e8ac29a5a0da@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20243>

Alex Riesen <raa.lkml@gmail.com> wrote:
> On 5/17/06, Shawn Pearce <spearce@spearce.org> wrote:
> >All I can say is I'm very happy that update-index does a lot more
> >than just update the index.  I was easily able to find the deleted
> >test by finding the most recently modified object in my .git/objects
> >directory and pulling it back out with git cat-file.  :-)
> >
> 
> Maybe git-lost-found would help here?

Thanks!  I did that the hard way with git fsck-objects only to find
I actually had a lot of dangling objects.  Luckily the most recent
one was the one I was looking for so a quick pipe through perl and
ls -t found it quite quickly.

What would have really helped me was just using GIT properly
rather than slamming something in fast with `git reset --hard`.
Somehow that option has become part of my finger feel when using
reset and that's just not right.  :-)

-- 
Shawn.
