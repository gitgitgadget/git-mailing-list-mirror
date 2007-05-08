From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Eclipse support status (was: Re: [EGIT 00/10] This weeks Eclipse patches)
Date: Mon, 7 May 2007 22:07:10 -0400
Message-ID: <20070508020710.GG11311@spearce.org>
References: <20070507212636.21546.29280.stgit@lathund.dewire.com> <Pine.LNX.4.63.0705072331260.20408@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Grzegorz Kulewski <kangur@polcom.net>
X-From: git-owner@vger.kernel.org Tue May 08 04:07:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlF6r-0007CL-B1
	for gcvg-git@gmane.org; Tue, 08 May 2007 04:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966863AbXEHCHV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 22:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966837AbXEHCHV
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 22:07:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51717 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966863AbXEHCHU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 22:07:20 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlF6T-0002u6-Fl; Mon, 07 May 2007 22:07:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2568020FBAE; Mon,  7 May 2007 22:07:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0705072331260.20408@alpha.polcom.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46516>

Grzegorz Kulewski <kangur@polcom.net> wrote:
> I wanted to ask about current status of Git-Eclipse support. Is this 
> plugin able to actually do anything or not? What works and what does not? 
> Can it be used by developers using Git? Or maybe git-svn or git-cvsserver 
> are better?

There's no support for committing through Eclipse yet, let alone
doing things like creating new branches or switching branches.

But Robin has done a lot of work on the status and history viewing
tools, to the point that you can use the QuickDiff feature in
Eclipse to see which parts of a file you have recently modified
(but not committed), which files/directories are modified in the
Navigator, and view the "git shortlog" for the currently selected
file/directory.

> If it it not usable at the moment do you have any idea when it may be 
> usable? I know several developers really waiting for such support even 
> early or beta quality.

I would say its *very* early alpha.  It could cause your Eclipse
workbench to run out of memory, and crash, especially on large
projects.  It also doesn't have that many features yet.  ;-)

-- 
Shawn.
