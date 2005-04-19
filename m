From: Christopher Li <git@chrisli.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 17:52:48 -0400
Message-ID: <20050419215248.GA6932@64m.dyndns.org>
References: <Pine.LNX.4.58.0504191608230.2274@ppc970.osdl.org> <Pine.LNX.4.62.0504191629410.26365@qynat.qvtvafvgr.pbz> <Pine.LNX.4.58.0504191651110.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Lang <david.lang@digitalinsight.com>,
	Chris Mason <mason@suse.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 03:00:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO3ZA-0003uR-D7
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 02:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVDTBDz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 21:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVDTBDz
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 21:03:55 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:20145 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261202AbVDTBDx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 21:03:53 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (rwcrmhc12) with ESMTP
          id <2005042001035101400njemqe>; Wed, 20 Apr 2005 01:03:53 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id E52173F1EF; Tue, 19 Apr 2005 17:52:48 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504191651110.6467@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 04:59:18PM -0700, Linus Torvalds wrote:
> 
> However, it definitely wouldn't be useful for _me_. The whole thing that
> I'm after is to allow painless merging of distributed work. If I have to
> merge one patch at a time, I'd much rather see people send me patches
> directly - that's much simpler than having a whole new GIT repository.
> 
> So at least to me, a git repository only makes sense when it is a
> collection of patches.

Same here, I have been toying the idea to using git as quilt back
end then I can get rid of the .pc/ directory in quilt.

But think about it more, I don't get a good reason to do it.
quilt as it is, works great with git or other SCM. Using git to
store the quilt patches will require merge more often, instead of
just applying patches. Introduce more steps and more objects to clean
up later on. It seems that every thing I have been using quilt for,
it is easier just deal with the series patches.

Chris

