From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git cvsimport error
Date: Fri, 23 May 2008 16:30:25 -0400
Message-ID: <20080523203025.GU29038@spearce.org>
References: <799406d60805211214r6315268ard77678eb2ec5d732@mail.gmail.com> <799406d60805211239n42c39ea6iaa41a9ab379cafaa@mail.gmail.com> <63BEA5E623E09F4D92233FB12A9F794301FC8B2D@emailmn.mqsoftware.com> <799406d60805231301l1ff158b7k73bb193c472a8211@mail.gmail.com> <63BEA5E623E09F4D92233FB12A9F794301FC8BCA@emailmn.mqsoftware.com> <799406d60805231324o209692d2o59a700024e52100c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Craig L. Ching" <cching@mqsoftware.com>, git@vger.kernel.org
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 22:31:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzdv6-0004KS-Vh
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090AbYEWUaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756088AbYEWUaa
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:30:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51593 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075AbYEWUa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:30:29 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jzdu6-0007uO-Iu; Fri, 23 May 2008 16:30:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AF67420FBAE; Fri, 23 May 2008 16:30:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <799406d60805231324o209692d2o59a700024e52100c@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82732>

Adam Mercer <ramercer@gmail.com> wrote:
> On Fri, May 23, 2008 at 3:05 PM, Craig L. Ching <cching@mqsoftware.com> wrote:
> > Yeah, I don't know much about it at all, but my advice would be to run
> > cvsps by itself and generate a cache that git-fast-import can import.
> > That's the approach we're taking because it gives us a chance to figure
> > out where things have gone wrong as we have some bad, buggy commits in
> > our archive (CVS created the bad commits).
> 
> I thought of using git-fast-import but the problem is that the CVS
> repository is still in use so I need to keep the git and CVS repos
> synchronised and it seems like git-fast-import can't be used in this
> case.

You can run fast-import in incremental behavior.  You just have to
restart each branch with a "from refs/heads/master^0" or whatever.
There's some discussion of this in the (rather large) fast-import
man page.

-- 
Shawn.
