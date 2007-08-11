From: moe <moe-git@mbox.bz>
Subject: Re: git and larger trees, not so fast?
Date: Sat, 11 Aug 2007 22:06:30 +0200
Message-ID: <20070811200630.GD19284@mbox.bz>
References: <20070809163026.GD568@mbox.bz> <alpine.LFD.0.999.0708111137250.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 22:08:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJxFs-0001NC-S9
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 22:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624AbXHKUIJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 16:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755134AbXHKUII
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 16:08:08 -0400
Received: from mx02.qsc.de ([213.148.130.14]:47694 "EHLO mx02.qsc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754368AbXHKUIH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 16:08:07 -0400
Received: from x.xxs.cc (port-212-202-38-87.dynamic.qsc.de [212.202.38.87])
	by mx02.qsc.de (Postfix) with ESMTP id 7FF1D19B5023
	for <git@vger.kernel.org>; Sat, 11 Aug 2007 22:06:31 +0200 (CEST)
Received: (qmail 20267 invoked by uid 1000); 11 Aug 2007 20:06:30 -0000
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0708111137250.30176@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55627>

On Sat, Aug 11, 2007 at 11:47:42AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 9 Aug 2007, moe wrote:
> > 
> > here's a test-case (should be safe to
> > copy/paste on linux, bash):
> 
> moe: with current git (and thus the 1.5.3 release), the "git status" 
> commands now take half a second for me, and the git commit takes just 
> under a second.
> 
> The *initial* commit that adds everything still takes almost 5 seconds, 
> but that was due to generating the diffstat summary - with a "-q" on the 
> commit line that too drops down to just under a second.
> 
> In fact, the only thing that took more than a second for me with the 
> current git is that initial "git add .", which took 1.791s for me. 
> Considering that it had to hash all the 100,000 objects, I'm not 
> surprised.
> 
> Anyway, it would be good if you re-did your real work tree with current 
> commit, just to verify. You have slower hardware than I do, but hopefully 
> it is now just about as fast as it can be.
 
hi linus,

thx for your efforts, the figures look very promising.
i'm out of town right now but will test when i get
stationary internet again (sometime tomorrow evening
i think).


regards, moe
