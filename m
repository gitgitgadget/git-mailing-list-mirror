From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: using stgit/guilt for public branches
Date: Fri, 4 May 2007 01:31:17 +0200
Organization: Dewire
Message-ID: <200705040131.17837.robin.rosenberg.lists@dewire.com>
References: <20070425122048.GD1624@mellanox.co.il> <20070503205836.GA19253@nan92-1-81-57-214-146.fbx.proxad.net> <200705040110.34697.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri May 04 01:31:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjkli-0005Qe-9A
	for gcvg-git@gmane.org; Fri, 04 May 2007 01:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbXECXbX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 19:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754528AbXECXbX
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 19:31:23 -0400
Received: from [83.140.172.130] ([83.140.172.130]:2736 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754475AbXECXbW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 19:31:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AE4AC80288F;
	Fri,  4 May 2007 01:25:19 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09630-10; Fri,  4 May 2007 01:25:19 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 4EB1A802651;
	Fri,  4 May 2007 01:25:19 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <200705040110.34697.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46119>

fredag 04 maj 2007 skrev Robin Rosenberg:
> torsdag 03 maj 2007 skrev Yann Dirson:
> [...]
> > As for publishing, I use the following config entries to publish my
> > own stack of patches to stgit.  You can see at
> > http://repo.or.cz/w/stgit/ydirson.git that gitweb shows pretty clearly
> > the structure of the stack (even though things could surely be made
> > better).
> > 
> > I use "git push -f" to publish - maybe the "+" refspec syntax would
> > work with push, I'll try it next time :)
> > 
> > [remote "orcz"]
> >         url = git+ssh://ydirson@repo.or.cz/srv/git/stgit/ydirson.git
> >         push = refs/heads/master:refs/heads/master
> > 	push = refs/patches/master/*:refs/patches/master/*
> 
> Beautiful!!
> 
Would it be possible to push only applied patches, and drop unapplied
ones? It would only matter when one wants to prune the remote repo
so it may not be terribly important, but it seems I pushed quite a 
lot of references from old patches that I haven't decided what to do
with yet and those will get new commit id's anyway.

-- robin
