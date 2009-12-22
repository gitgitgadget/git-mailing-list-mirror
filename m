From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Regression: git-svn clone failure
Date: Tue, 22 Dec 2009 12:26:17 -0800
Message-ID: <20091222202617.GA20668@dcvr.yhbt.net>
References: <8BD646EB-3F47-41F8-918C-19133CCCA89C@apple.com> <20091222192115.GA10313@dcvr.yhbt.net> <B82A784D-C8D7-4DDF-AE63-390C7AE1CC2D@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sam@vilain.net
To: Junio C Hamano <gitster@pobox.com>,
	Andrew Myrick <amyrick@apple.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 21:26:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNBJM-0006HF-KX
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 21:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbZLVU0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 15:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754051AbZLVU0U
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 15:26:20 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50010 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754123AbZLVU0S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 15:26:18 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1693B1F4F1;
	Tue, 22 Dec 2009 20:26:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <B82A784D-C8D7-4DDF-AE63-390C7AE1CC2D@apple.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135597>

Andrew Myrick <amyrick@apple.com> wrote:
> On Dec 22, 2009, at 11:21 AM, Eric Wong wrote:
> > That looks like a simple error, does the following patch help?

<snip>

> Worked like a charm; the fetch is proceeding now.  Thanks, Eric!

Awesome, tanks for the feedback, Andrew.

I've pushed out a proper commit to git://git.bogomips.org/git-svn
for Junio (which also contains the previous pull request).

Andrew Myrick (1):
      git-svn: Remove obsolete MAXPARENT check

Eric Wong (3):
      git svn: fix --revision when fetching deleted paths
      update release notes for git svn in 1.6.6
      git svn: lookup new parents correctly from svn:mergeinfo

Sam Vilain (5):
      git-svn: expand the svn mergeinfo test suite, highlighting some failures
      git-svn: memoize conversion of SVN merge ticket info to git commit ranges
      git-svn: fix some mistakes with interpreting SVN mergeinfo commit ranges
      git-svn: exclude already merged tips using one rev-list call
      git-svn: detect cherry-picks correctly.

> Do you know what the "svn cherry-pick ignored" warnings mean, and if
> it's something I should be concerned about?  This particular project
> is missing up to 65 commits at some revisions.

Definitely a question for Sam :)

-- 
Eric Wong
