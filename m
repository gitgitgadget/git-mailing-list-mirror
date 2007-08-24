From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [BUG] git-gui: "Stage Hunk For Commit" doesn't work at all anymore
Date: Thu, 23 Aug 2007 23:08:08 -0400
Message-ID: <20070824030808.GT27913@spearce.org>
References: <20070823203024.GF21692@lavos.net> <20070823203818.GG21692@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Fri Aug 24 05:08:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOPXU-0004Ah-3Y
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 05:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbXHXDIS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 23:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933717AbXHXDIS
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 23:08:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38625 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933635AbXHXDIR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 23:08:17 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IOPWg-0006FM-2Y; Thu, 23 Aug 2007 23:07:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AEAB420FBAE; Thu, 23 Aug 2007 23:08:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070823203818.GG21692@lavos.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56546>

Brian Downing <bdowning@lavos.net> wrote:
> On Thu, Aug 23, 2007 at 03:30:24PM -0500, Brian Downing wrote:
> > This commit:
> > 
> > commit a13ee29b975d3a9a012983309e842d942b2bbd44
> > 
> > seems to have broken the "Stage Hunk For Commit" option entirely for me
> > -- it is now disabled whether or not there is a patch in the viewer.

Yea, that commit was a dud.  I noticed it myself a few days ago
and fixed the dang thing.  I don't know what I was thinking when
I made that commit...
 
> Sorry, I just saw the following commit in the git-gui tree:
> 
> ce015c213fbef39140b6192db28110bc666dc6c8 
> git-gui: Paper bag fix "Stage Hunk For Commit" in diff context menu
> 
> So it appears this issue is known.  Sorry about the noise.

No problem.  Better that someone raises an issue than just pretend
like its not there...
 
> (Though this will be merged before 1.5.3, right?)

Yes.  It will be in git-gui 0.8.2, which Junio has agreed to merge
into 1.5.3 before it goes final.  I'll likely tag git-gui 0.8.2
tomorrow, then ask him to pull when he has the chance.

-- 
Shawn.
