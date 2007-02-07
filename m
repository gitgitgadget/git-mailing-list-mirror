From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Wed, 7 Feb 2007 17:57:23 -0500
Message-ID: <20070207225723.GB1970@spearce.org>
References: <17866.20355.744025.133326@lisa.zopyra.com> <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 23:57:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEvjI-0000x7-AV
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 23:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161471AbXBGW51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 17:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161472AbXBGW51
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 17:57:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45902 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161471AbXBGW50 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 17:57:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEvj1-0003Mu-7g; Wed, 07 Feb 2007 17:57:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1D49D20FBAE; Wed,  7 Feb 2007 17:57:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38990>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Of course, we should probably just have a
> 
> 	git reflog show
> 
> command for this to make it prettier.

I tried that (I submitted patches to create `git reflog show`).
Dscho's `git log -g` was the better candidate, and won.
Its already in git.git's master branch.

-- 
Shawn.
