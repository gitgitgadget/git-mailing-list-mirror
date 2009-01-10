From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 0/3] Show all changes files in the same compare editor
Date: Sat, 10 Jan 2009 02:14:34 +0100
Message-ID: <1231550077-1057-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jan 10 02:16:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLSSP-0002Kg-Jj
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 02:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715AbZAJBOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 20:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754967AbZAJBOn
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 20:14:43 -0500
Received: from mail.dewire.com ([83.140.172.130]:8463 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754722AbZAJBOm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 20:14:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E76011484F78;
	Sat, 10 Jan 2009 02:14:39 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E0-GNQmC1H5r; Sat, 10 Jan 2009 02:14:38 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id C2BA21484F4F;
	Sat, 10 Jan 2009 02:14:38 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105056>

Hereby I ressurrect some of the goodness the old compare editor had,
by enabling it to show all changes in the same compare editor so one
can browse back and forth using Ctrl-. and Ctrl-, instead of having
to click on each changed file.

Question: Do we need the filediff viewer AND the compare editor. We
used to have the compare editor update automaticall when one switched
revision in the history pane.

-- robin

Robin Rosenberg (3):
  Support viewing all changes in a single compare editor
  Present type of change with file revision in diff viewer
  Present full name of file revision

 .../core/internal/storage/GitFileRevision.java     |    5 +-
 .../ui/internal/history/CommitFileDiffViewer.java  |   40 +++++++--
 .../internal/history/FileDiffContentProvider.java  |   11 ++-
 .../ui/internal/history/FileDiffLabelProvider.java |   49 +++++++++--
 .../spearce/egit/ui/internal/history/RevDiff.java  |   91 ++++++++++++++++++++
 5 files changed, 179 insertions(+), 17 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevDiff.java
