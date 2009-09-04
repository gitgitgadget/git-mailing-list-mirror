From: Pete Wyckoff <pw@padd.com>
Subject: tracking branch for a rebase
Date: Fri, 4 Sep 2009 06:54:14 -0700
Message-ID: <20090904135414.GA3728@honk.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 15:54:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjZF9-0006dj-8K
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 15:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812AbZIDNyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 09:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756791AbZIDNyN
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 09:54:13 -0400
Received: from marge.padd.com ([99.188.165.110]:59757 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756778AbZIDNyM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 09:54:12 -0400
Received: from honk.padd.com (honk.padd.com [209.17.171.228])
	by marge.padd.com (Postfix) with ESMTPSA id 4AA71121A688
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:54:15 -0700 (PDT)
Received: by honk.padd.com (Postfix, from userid 7770)
	id 7961278C6A5; Fri,  4 Sep 2009 09:54:14 -0400 (EDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127734>

I received an interesting question today.

If "git pull" knows what remote tracking brach to pull from,
why doesn't "git rebase" automatically know I want to rebase
on top of my remote tracking branch?

He had done a "git remote update", reviewed the changes, and now
wants to rebase his changes on top of the new upstream.

I told him about git pull --rebase, and branch.name.rebase,
but didn't have an easy answer to the "what is my remote tracking
branch" question in this case.

All the information is in git config branch.name.{remote,merge},
but I can't find anything that just answers that question.  Nor
did I have a good answer for why "git rebase" doesn't just default
to rebasing the current branch on top of the tracking branch.

Thoughts?

		-- Pete
