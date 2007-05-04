From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: using stgit/guilt for public branches
Date: Fri, 4 May 2007 08:20:59 +0300
Message-ID: <20070504052042.GA4829@mellanox.co.il>
References: <20070425122048.GD1624@mellanox.co.il>
	<20070425191838.GA6267@filer.fsl.cs.sunysb.edu>
	<200704252337.05851.robin.rosenberg.lists@dewire.com>
	<20070503205836.GA19253@nan92-1-81-57-214-146.fbx.proxad.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri May 04 07:21:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjqE0-0008BK-Az
	for gcvg-git@gmane.org; Fri, 04 May 2007 07:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbXEDFU7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 01:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754571AbXEDFU6
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 01:20:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:44256 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576AbXEDFU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 01:20:57 -0400
Received: by ug-out-1314.google.com with SMTP id 44so587116uga
        for <git@vger.kernel.org>; Thu, 03 May 2007 22:20:55 -0700 (PDT)
Received: by 10.66.237.9 with SMTP id k9mr2422890ugh.1178256055780;
        Thu, 03 May 2007 22:20:55 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.119.177])
        by mx.google.com with ESMTP id 32sm4669027ugf.2007.05.03.22.20.53;
        Thu, 03 May 2007 22:20:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070503205836.GA19253@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46131>

> Quoting Yann Dirson <ydirson@altern.org>:
> Subject: Re: using stgit/guilt for public branches
> 
> On Wed, Apr 25, 2007 at 11:37:05PM +0200, Robin Rosenberg wrote:
> > onsdag 25 april 2007 skrev Josef Sipek:
> > > On Wed, Apr 25, 2007 at 03:20:49PM +0300, Michael S. Tsirkin wrote:
> > [...]
> > > > I am concerned that publishing a git branch managed by stg/guilt
> > > > would present problems: it seems that every time patches are re-ordered,
> > > > a patch is re-written or removed, or we update from upstream,
> > > > everyone who pulls the tree branch will have a hard-to-resolve conflict.
> > > > 
> > > > Is that really a problem? If so, would it be possible to work around this
> > > > somehow?
> > > 
> > > I thought about this problem a while back when I was trying to decide how to
> > > manage the Unionfs git repository. I came to the conclusion, that there was
> > > no clean way of doing this (at least not using guilt - I can't really speak
> > > for stgit, as I don't know how it does things exactly).
> > 
> > StGit has the same problem. Publishing such a branch is only for viewing if
> > you want to publish the tip, like the pu branch in the Git repo. You shouldn't
> > merge from pu either.
> 
> You are right, in that what can be done with such branches is limited.
> BUT you can safely "stg branch --create" off any remote stgit stack.
> Then you can "stg rebase origin/master" to port your stack to the new
> tip of the remote stack.

OK.
What happens if someone clones the repo, then reorders patches,
drops some of them, adds new patches in the middle of the stack?

-- 
MST
