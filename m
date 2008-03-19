From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: auto gc again
Date: Wed, 19 Mar 2008 22:17:34 +0100
Message-ID: <20080319211733.GD17940@kernel.dk>
References: <20080318180118.GC17940@kernel.dk> <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org> <20080318181948.GH17940@kernel.dk> <alpine.LFD.1.00.0803191629240.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:19:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5gm-0001kn-0N
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965590AbYCSVRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 17:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934465AbYCSVRl
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:17:41 -0400
Received: from brick.kernel.dk ([87.55.233.238]:9331 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936906AbYCSVRj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:17:39 -0400
Received: by kernel.dk (Postfix, from userid 500)
	id 6CD0725880A; Wed, 19 Mar 2008 22:17:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803191629240.2947@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77551>

On Wed, Mar 19 2008, Nicolas Pitre wrote:
> On Tue, 18 Mar 2008, Jens Axboe wrote:
> 
> > But freshly pulled repo, git auto gc is enabled. And that is my main
> > annoyance, I just don't think that type of policy should be in there.
> 
> Just do this once:
> 
> 	git config --global gc.auto 0
> 	git config --global gc.autopacklimit 0
> 
> and be happy.

You don't get it. I did gc.auto 0. And know some other limit crops up, I
have to do gc.autopacklimit 0. I have LOTS of git trees. On many
machines. It's just annoying, period.

> > Print the warning, include info on how to run git gc or even how to turn
> > it on automatically. But I'll bet you that most users will NOT want auto
> > gc. Ever.
> 
> Unfortunately, the harshest complaints about this whole issue were the 
> opposite.

I just don't buy that, I have more faith in users. If they come around
and complain it's slow, heck you told them it would be.

But it's not a big deal, I'll just carry a local patch that disables
this crap and forget the whole deal. I just worry that if this is where
git 'usability' is heading, it wont be a good thing in the long run.

-- 
Jens Axboe
