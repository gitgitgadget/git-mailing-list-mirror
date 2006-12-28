From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/11] Misc. pull/merge/am improvements
Date: Thu, 28 Dec 2006 03:42:45 -0500
Message-ID: <20061228084245.GA18150@spearce.org>
References: <20061228073441.GB17304@spearce.org> <7vmz58whnx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 28 09:42:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzqqm-0007qm-BO
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 09:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWL1Imx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 03:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWL1Imx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 03:42:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47208 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965004AbWL1Imv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 03:42:51 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzqqC-0001qx-Ol; Thu, 28 Dec 2006 03:42:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 71CBB20FB65; Thu, 28 Dec 2006 03:42:46 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmz58whnx.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35541>

Junio C Hamano <junkio@cox.net> wrote:
> Actually I am getting more greedy, and would not mind to have
> clean ups and a few more features in the new release, even the
> ones that we have talked about but have not implemented.

I know Linus wants me to fix the bash completion so it adds a trailing
space when something gets completed and is unique and no additional
text is expected to follow for that argument.  I just haven't put
the effort into it, even though I think I have a solution.

Basically I'm saying I probably could have another round of bash
completion in another week which may be worth considering for
inclusion.  ;-)
 
> I am very tempted to have sliding window mmap() if it helps
> people on cygwin, for example.

Especially now that NO_MMAP is the default on that platform.
At this point it may be ready to graduate to next to try and get a
wider audience.  Since fixing that segfault in pack-objects I can't
break it.  Of course I couldn't break it before you found that error,
so take my words with a grain of salt... ;-)

> Also, I've been running with
> "next" for my daily pushes and pulls without trouble, and I am
> very tempted to push out the shallow-clone topic.

Hasn't that been in next for a while now?  I pretty much always
run next, and have also been using it on that non-publishable
repository for almost two months now.  I've got 20 other users who I
collaborate with on cygwin running next... we haven't had any issue
with the portions of shallow-clone which had already moved in, and
I upgrade that environment almost daily to keep current.  Of course
we also haven't tried to actually use the shallow-clone feature as
we haven't needed it (the repository is only 50 MiB packed).

> Although I do find the detached HEAD attractive and would want
> to have it eventually, I suspect that even if it materializes
> soon enough, it would at least need a couple of weeks of testing
> in 'next', so making -rc1 wait for it might push back the
> release a bit too much.

Agreed.  It would be nice to implement, expecially for a major
release like 1.5.0.  I don't think its that difficult to do, we've
all just been distracted by other topics and nobody has put code
forward for it.  If a well-written implementation materialized in
the next few days it might get enough cooking time before rc1 to
include it.

-- 
Shawn.
