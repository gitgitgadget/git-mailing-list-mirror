From: Noel Maddy <noel@zhtwn.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 16:21:17 -0400
Message-ID: <20050429202117.GA15417@uglybox.localnet>
References: <20050429194753.GA14222@uglybox.localnet> <200504291954.MAA27561@emf.net>
Reply-To: Noel Maddy <noel@zhtwn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: noel@zhtwn.com, seanlkml@sympatico.ca, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 22:20:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRbxH-0006Oa-QI
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbVD2UYQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbVD2UWR
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:22:17 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:26573 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262944AbVD2UVV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 16:21:21 -0400
Received: from uglybox (pcp04038668pcs.wbrmfd01.mi.comcast.net[68.43.211.146])
          by comcast.net (sccrmhc12) with ESMTP
          id <2005042920211801200d9v0je>; Fri, 29 Apr 2005 20:21:19 +0000
Received: from noel by uglybox with local (Exim 4.50)
	id 1DRbzB-00046a-8M; Fri, 29 Apr 2005 16:21:17 -0400
To: Tom Lord <lord@emf.net>
Content-Disposition: inline
In-Reply-To: <200504291954.MAA27561@emf.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 12:54:19PM -0700, Tom Lord wrote:
> 
> 
>   > Call me a naive git, but seems to me the "git way" is a little
>   > different. It's tree-based rather than diff-based, and doesn't involve
>   > passing diffs around, right?
> 
> Isn't that a significant part of what I said?  Go back and read more
> carefully, is my suggestion.

I'm trying to understand you. Please bear with me, and point out what
I'm missing.

Your example had Joe reviewing a signed diff, and then applying changes
from a tree that "supposedly" had the diff applied correctly, but may
have been corrupted. If the tree was not an accurate representation of
applying the diff, then the changes Joe applied to his tree will be
different than those that he reviewed.

My example had Joe downloading a remote signed tree, reviewing the changes
locally between his own trusted tree and the remote tree, and then
applying them locally. Since the diffs are generated locally between the
two trees, Joe is always reviewing the exact changes that will be
applied to his tree.

Doesn't this deal with the logical hole that you were pointing out in
your example? Or am I seeing a different "logical hole" than you are?


-- 
A man who fears nothing is a man who loves nothing.  And if you love
nothing, what joy is there in your life?
					 -- King Arthur, "First Knight"
+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
Noel Maddy <noel@zhtwn.com>
