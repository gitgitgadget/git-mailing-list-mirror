From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [ANNOUNCE] Java Git (aka jgit) has switched to 3-clause BSD
Date: Sat, 7 Jun 2008 12:02:04 -0400
Message-ID: <20080607160204.GF12896@spearce.org>
References: <20080526044640.GB30245@spearce.org> <200806071303.11737.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Watson <dwatson@mimvista.com>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 18:03:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K50sj-0005Al-Ag
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 18:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758861AbYFGQCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 12:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758765AbYFGQCM
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 12:02:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45364 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757576AbYFGQCL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 12:02:11 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K50rg-00047x-0S; Sat, 07 Jun 2008 12:02:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E48C120FBAE; Sat,  7 Jun 2008 12:02:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200806071303.11737.robin.rosenberg@dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84209>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:

> I looked through the licensing info and it is inconsistent. In
> the feature.xml copyright section you dropped the mention of
> the GPL while the full license itself was retained later in the
> section. The latter is correct as we have do have the GPL code
> that you wrote in the visualization part .

Oy.  I thought I was correcting it, but I forgot code that I
wrote myself.  Not good.  Very bad mistake.
 
> Either we reintroduce mentioning GPL at the start or (you)
> relicense the graph parts.

It is my intent to relicense any code I have written in jgit as
3-clause BSD and any code I have written in egit as EPL.  The EPL
relicense I didn't start the discussion thread for yet, but its
where I am trying to go.

> To what extent I still have code in there, I have no objections
> to changing it to either EPL (or LGPL for consistency reasons). I
> can do the editorial change the license if you confirm that there
> are no issues.

EPL for egit code please.  It trivially makes us compatible with the
Eclipse foundation's own code and simplifies our project proposal
with them.
 
> $ git ls-files -z |xargs -0 grep -l "GNU G"
> org.spearce.egit-feature/feature.xml
> 	inconsistent as mentioned above
> 
> org.spearce.egit.core/COPYING
> 	only mentions LGPL
> org.spearce.egit.core/src/org/spearce/egit/core/ResourceList.java
> org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/KidCommit.java
> org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/KidCommitList.java
> org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/KidWalk.java
> org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
> 	GPL licensed

Any of this that I wrote, EPL please.

> org.spearce.egit.ui/COPYING
> 	only mentions LGPL
> org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitFileDiffViewer.java
> org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
> org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitMessageViewer.java
> org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitNavigationListener.java
> org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiff.java
> org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiffContentProvider.java
> org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiffLabelProvider.java
> org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GenerateHistoryJob.java
> org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
> org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GraphContentProvider.java
> org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GraphLabelProvider.java
> org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTCommit.java
> org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTCommitList.java
> org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
> org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTWalk.java
> 	GPL licensed

Any of this that I wrote, EPL please.  I'm fairly certain Roger
wrote some of this code as well, and its derived from your original
plotting code.  We should make sure it is acceptable to him as well.

Thanks for noticing Robin.

-- 
Shawn.
