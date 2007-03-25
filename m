From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Question regarding: git pull --no-commit origin
Date: Sun, 25 Mar 2007 19:38:23 -0400
Message-ID: <20070325233823.GA13247@spearce.org>
References: <93c3eada0703251632s3be48b60na03728ce72b8ab8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 01:38:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVcIC-0002CV-GD
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 01:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932911AbXCYXi3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 19:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932889AbXCYXi3
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 19:38:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35650 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932903AbXCYXi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 19:38:28 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HVcHw-0005VL-SB; Sun, 25 Mar 2007 19:38:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 121AA20FBAE; Sun, 25 Mar 2007 19:38:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <93c3eada0703251632s3be48b60na03728ce72b8ab8c@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43095>

Geoff Russell <geoffrey.russell@gmail.com> wrote:
> I do: git pull --no-commit origin
> 
> Receive messages ending in:
> 
>        ...
>       Updating 6a29cdd..b7ba33d
>       Fast forward
>       interface/testfile |    1 +
>       1 files changed, 1 insertions(+), 0 deletions(-)
>       create mode 100644 interface/testfile
...
> However when I do: git commit -a
> 
> I'm told: nothing to commit (working directory clean)
> 
> Am I misunderstanding something?

The pull was strictly a fast-forward.  No merge commit was necessary
to record the merge, so we didn't actually honor the --no-commit
argument.

In other words, your current branch did not contain any commits
that were not in the origin branch you were pulling from.  So
a real merge wasn't required here.

-- 
Shawn.
