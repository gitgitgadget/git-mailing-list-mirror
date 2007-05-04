From: Yann Dirson <ydirson@altern.org>
Subject: Re: using stgit/guilt for public branches
Date: Fri, 4 May 2007 23:28:42 +0200
Message-ID: <20070504212842.GB19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070425122048.GD1624@mellanox.co.il> <20070503205836.GA19253@nan92-1-81-57-214-146.fbx.proxad.net> <200705040110.34697.robin.rosenberg.lists@dewire.com> <200705040131.17837.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri May 04 23:30:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk5Ln-0002WW-AN
	for gcvg-git@gmane.org; Fri, 04 May 2007 23:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161327AbXEDV3l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 17:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161590AbXEDV3l
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 17:29:41 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:48021 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161327AbXEDV3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 17:29:24 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 24CB738C8;
	Fri,  4 May 2007 23:29:21 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 4C6DE1F15A; Fri,  4 May 2007 23:28:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200705040131.17837.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46217>

On Fri, May 04, 2007 at 01:31:17AM +0200, Robin Rosenberg wrote:
> fredag 04 maj 2007 skrev Robin Rosenberg:
> > torsdag 03 maj 2007 skrev Yann Dirson:
> > [...]
> > > As for publishing, I use the following config entries to publish my
> > > own stack of patches to stgit.  You can see at
> > > http://repo.or.cz/w/stgit/ydirson.git that gitweb shows pretty clearly
> > > the structure of the stack (even though things could surely be made
> > > better).
> > > 
> > > I use "git push -f" to publish - maybe the "+" refspec syntax would
> > > work with push, I'll try it next time :)
> > > 
> > > [remote "orcz"]
> > >         url = git+ssh://ydirson@repo.or.cz/srv/git/stgit/ydirson.git
> > >         push = refs/heads/master:refs/heads/master
> > > 	push = refs/patches/master/*:refs/patches/master/*
> > 
> > Beautiful!!
> > 
> Would it be possible to push only applied patches, and drop unapplied
> ones?

This would require stgit-level knowledge, so we would need an stgit
command.

Maybe "stg publish" or "stg branch --publish" with the current syntax,
since we already have "push".  I'd be in favor of "stg branch push"
for the next-gen syntax, though ;)

> It would only matter when one wants to prune the remote repo
> so it may not be terribly important, but it seems I pushed quite a 
> lot of references from old patches that I haven't decided what to do
> with yet and those will get new commit id's anyway.

For now you can delete them manually with "git push remote/ref:".

Best regards,
-- 
Yann.
