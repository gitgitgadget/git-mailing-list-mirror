From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 0/6] Add tests for RevWalk and its supporting code
Date: Fri, 13 Mar 2009 17:13:45 -0700
Message-ID: <20090314001345.GI22920@spearce.org>
References: <1236910062-18476-1-git-send-email-spearce@spearce.org> <200903132100.26527.robin.rosenberg.lists@dewire.com> <20090313223933.GH22920@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 01:15:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiHXC-0002mU-8T
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 01:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbZCNANr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 20:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbZCNANr
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 20:13:47 -0400
Received: from george.spearce.org ([209.20.77.23]:35233 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbZCNANr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 20:13:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 889C838211; Sat, 14 Mar 2009 00:13:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090313223933.GH22920@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113226>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> These new tests cover some of the common cases we see with using a
> RevWalk, and increase our code coverage in this critical area of
> the JGit library.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
>  > fredag 13 mars 2009 03:07:37 skrev "Shawn O. Pearce" <spearce@spearce.org>:
>  > > Today I uncovered some ugly cases with "jgit rev-list B ^A", where
>  > > some commits reachable from A were still being output, even though
>  > > we asked that they be excluded.
>  > 
>  > How about a test suite to prove this is better than before?
> 
>  Its better.  :-)

Its actually not better.  Although the tests I'm replying to are
right, there's another bug introduced by this series that they
don't detect, but that shows up on the Linux kernel repository.

I have yet to track down the full thing... but I know its busted.
 
-- 
Shawn.
