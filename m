From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [GIT-SVN] master follows not trunk
Date: Thu, 23 Apr 2009 11:37:05 -0700
Message-ID: <20090423183705.GB17467@dcvr.yhbt.net>
References: <36ca99e90904220821u3dae67d7jcb6366d7a95dfbd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 20:39:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx3ph-0002qq-VE
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 20:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756486AbZDWShJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 14:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756974AbZDWShH
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 14:37:07 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37211 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753355AbZDWShG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 14:37:06 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731A91F602;
	Thu, 23 Apr 2009 18:37:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <36ca99e90904220821u3dae67d7jcb6366d7a95dfbd1@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117359>

Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> Hi,
> 
> it seams so, that git-svn sets the master branch to that svn branch
> which has the highest revision!
> 
> I cloned a svn repo today where exactly this happend. I.e. master
> pointed not to the trunk but to the branch with the highest revision.
> After trunk moved forward, a git svn rebase told me that master is up
> to date.
> 
> A second clean clone of this repo and master pointed to trunk.
> 
> Is this indented?

Yes it was intended.  It was once the case that several repositories I
tracked had work done almost exclusively in branches and trunk could've
been months/years behind and worthless.

However, this issue has come up many times now so maybe setting
master==trunk if trunk exists (sometimes it does not)...

Any objections?

-- 
Eric Wong
