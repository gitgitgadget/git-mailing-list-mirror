From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Remove obsolete MAXPARENT check
Date: Mon, 21 Dec 2009 14:39:18 -0800
Message-ID: <20091221223918.GA22872@dcvr.yhbt.net>
References: <1261434174-298-1-git-send-email-amyrick@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sam@vilain.net
To: Junio C Hamano <gitster@pobox.com>,
	Andrew Myrick <amyrick@apple.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 23:42:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMquT-0000yP-4P
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 23:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbZLUWjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 17:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753582AbZLUWjU
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 17:39:20 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:38086 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbZLUWjU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 17:39:20 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9791F518;
	Mon, 21 Dec 2009 22:39:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1261434174-298-1-git-send-email-amyrick@apple.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135568>

Andrew Myrick <amyrick@apple.com> wrote:
> Change git-svn not to impose a limit of 16 parents on a merge.
> 
> This limit in git-svn artificially prevents cloning svn repositories
> that contain commits with more than 16 merge parents.
> 
> The limit was removed from builtin-commit-tree.c for git v1.6.0 in commit
> ef98c5cafb3e799b1568bb843fcd45920dc62f16, so there is no need to check for it
> it in git-svn.
> 
> Signed-off-by: Andrew Myrick <amyrick@apple.com>

Thanks Andrew,

Acked-by: Eric Wong <normalperson@yhbt.net>

and pushed out to git://git.bogomips.org/git-svn along with the
rest of the stuff already pushed out last night.

Andrew Myrick (1):
      git-svn: Remove obsolete MAXPARENT check

Eric Wong (2):
      git svn: fix --revision when fetching deleted paths
      update release notes for git svn in 1.6.6

Sam Vilain (5):
      git-svn: expand the svn mergeinfo test suite, highlighting some failures
      git-svn: memoize conversion of SVN merge ticket info to git commit ranges
      git-svn: fix some mistakes with interpreting SVN mergeinfo commit ranges
      git-svn: exclude already merged tips using one rev-list call
      git-svn: detect cherry-picks correctly.

-- 
Eric Wong
