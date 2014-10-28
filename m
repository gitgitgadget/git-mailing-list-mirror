From: Eric Wong <normalperson@yhbt.net>
Subject: Re: differences between old clone and new  Re: git-svn performance
Date: Tue, 28 Oct 2014 07:41:04 +0000
Message-ID: <20141028074104.GA7762@dcvr.yhbt.net>
References: <1414452388.89217.YahooMailBasic@web172306.mail.ir2.yahoo.com>
 <1414474807.30075.YahooMailBasic@web172303.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Oct 28 08:41:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xj1P0-0007XG-B7
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 08:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbaJ1HlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 03:41:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36684 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485AbaJ1HlF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 03:41:05 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B2C71F665;
	Tue, 28 Oct 2014 07:41:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1414474807.30075.YahooMailBasic@web172303.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> To compare the old clone with the new, I did:
> 
> git branch -r | sort | xargs -n 1 git log --decorate=full -n 1
> 
> It turned out other than the empty vs 3 word commit messages
> about two years ago on trunk (which are inherited in all the newer
> branches), there are two other groups of differences.
> 
> One branch on the old clone has an extra merge from trunk (
> and some extra trunk commits) listed in 'git log', while
> another branch has the exact opposite - on the old clone
> has one fewer merge.
> 
> I see the merge seem to be genuine - the subversion log
> often says so e.g. "ported from rXXX from trunk", but
> the extra/missing pattern isn't consistent.

So both merges are correct, but we lose one, and gain one?
I'll try to check more closely tomorrow.  Can you point out
the exact revisions in the R repo?  Thanks.

> So the histories are largely the same, except due to the 
> extra merge, don't have the same sha1 sums.
