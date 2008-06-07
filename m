From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [ANNOUNCE] Java Git (aka jgit) has switched to 3-clause BSD
Date: Sat, 7 Jun 2008 13:03:11 +0200
Message-ID: <200806071303.11737.robin.rosenberg@dewire.com>
References: <20080526044640.GB30245@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Dave Watson <dwatson@mimvista.com>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jun 07 13:07:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4wGJ-0000EN-Dm
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 13:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197AbYFGLGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 07:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755635AbYFGLGO
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 07:06:14 -0400
Received: from [83.140.172.130] ([83.140.172.130]:25512 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752371AbYFGLGN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 07:06:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3C67980265C;
	Sat,  7 Jun 2008 13:06:09 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xCgxPRPuGlmn; Sat,  7 Jun 2008 13:06:08 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 816FA800681;
	Sat,  7 Jun 2008 13:06:08 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080526044640.GB30245@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84197>

Hi Shawn,

I looked through the licensing info and it is inconsistent. In the feature.xml copyright section you dropped the mention of the GPL while the full license itself was retained later in the section. The latter is correct as we have do have the GPL code that you wrote in the visualization part .

Either we reintroduce mentioning GPL at the start or (you) relicense the graph parts.

To what extent I still have code in there, I have no objections to changing it to either EPL (or LGPL for consistency reasons). I can do the editorial change the license if you confirm that there are no issues.

$ git ls-files -z |xargs -0 grep -l "GNU G"
org.spearce.egit-feature/feature.xml
	inconsistent as mentioned above

org.spearce.egit.core/COPYING
	only mentions LGPL
org.spearce.egit.core/src/org/spearce/egit/core/ResourceList.java
org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/KidCommit.java
org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/KidCommitList.java
org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/KidWalk.java
org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
	GPL licensed
org.spearce.egit.ui/COPYING
	only mentions LGPL
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitFileDiffViewer.java
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitMessageViewer.java
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitNavigationListener.java
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiff.java
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiffContentProvider.java
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiffLabelProvider.java
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GenerateHistoryJob.java
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GraphContentProvider.java
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GraphLabelProvider.java
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTCommit.java
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTCommitList.java
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTPlotRenderer.java
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/SWTWalk.java
	GPL licensed

-- robin
