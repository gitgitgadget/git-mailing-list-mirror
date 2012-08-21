From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn.perl: consider all ranges for a given merge,
 instead of only tip-by-tip
Date: Tue, 21 Aug 2012 22:05:56 +0000
Message-ID: <20120821220556.GA5848@dcvr.yhbt.net>
References: <20120819193356.GA6203@dcvr.yhbt.net>
 <1345426781-7754-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sam@vilain.net, avarab@gmail.com, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 00:06:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3waK-0002hG-Qz
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 00:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758718Ab2HUWF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 18:05:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40659 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758465Ab2HUWF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 18:05:56 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B2DB335BB;
	Tue, 21 Aug 2012 22:05:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1345426781-7754-1-git-send-email-stevenrwalter@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203998>

Steven Walter <stevenrwalter@gmail.com> wrote:
> Consider the case where you have trunk, branch1 of trunk, and branch2 of
> branch1.  trunk is merged back into branch2, and then branch2 is
> reintegrated into trunk.  The merge of branch2 into trunk will have
> svn:mergeinfo property references to both branch1 and branch2.  When
> git-svn fetches the commit that merges branch2 (check_cherry_pick),
> it is necessary to eliminate the merged contents of branch1 as well as
> branch2, or else the merge will be incorrectly ignored as a cherry-pick.
> 
> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>

Thanks, I've Signed-off (also added Sam's Reviewed-by) and
pushed to "for-git-master" on git://bogomips.org/git-svn

(Will wait on a few other patches before asking Junio to pull)
