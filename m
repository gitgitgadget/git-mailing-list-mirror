From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] wt-status: show author info if status.showauthor is set
Date: Wed, 4 Apr 2007 02:55:05 -0400
Message-ID: <20070404065504.GD30309@spearce.org>
References: <20070322104021.GJ29341@mellanox.co.il> <7v7it7kkl9.fsf@assigned-by-dhcp.cox.net> <20070404060213.GB31984@mellanox.co.il> <20070404062447.GA4136@coredump.intra.peff.net> <20070404064917.GE31984@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Apr 04 08:55:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYzOo-0004kM-CC
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 08:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966319AbXDDGzO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 02:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966321AbXDDGzO
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 02:55:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35789 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966319AbXDDGzM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 02:55:12 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HYzOc-0004Jb-8B; Wed, 04 Apr 2007 02:55:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 861F020FBAE; Wed,  4 Apr 2007 02:55:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070404064917.GE31984@mellanox.co.il>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43719>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> wrote:
> > Quoting Jeff King <peff@peff.net>:
> > On Wed, Apr 04, 2007 at 09:02:13AM +0300, Michael S. Tsirkin wrote:
> > 
> > > - Maybe put Author: (or From:? and maybe Subject:?) line in the pre-formatted
> > >   commit message, and let the user edit them?
> > 
> > Personally I think it's just clutter, but hey, it's off by default. Of
> > course what is the chance that you've turned on status.showauthor in
> > your ~/.gitconfig, but you don't have your identity set up properly? :)
> 
> The point is that *someone else* can have showauthor set up in .gitconfig,
> and then he'll be able to use git commit --amend to fix up
> the identity without using --author explicitly.

Hmm.  Actually I'd like to be able to set (or change) the author
using a From: line, much like email headers.  Especially in the case
of git-commit --amend, as sometimes I make a new commit as myself,
then realize *after* I've quit the editor that the patch really
came from someone else, and I should record the right author.

And no, the patch wasn't really a patch.  It was a set of files
from the user that I manually copy in, then commit.  Though I have
to wonder why I keep doing that as said user also does use the same
Git repository as me...  and edits and commits other files on their
own just fine...  ;-)

-- 
Shawn.
