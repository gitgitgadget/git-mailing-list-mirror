From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [J/E-GIT PATCH 0/7] Tag decoration v2
Date: Fri,  7 Nov 2008 23:07:37 +0100
Message-ID: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Nov 07 23:09:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZVo-0008DU-Eh
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbYKGWHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbYKGWHs
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:07:48 -0500
Received: from mail.dewire.com ([83.140.172.130]:11942 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbYKGWHs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:07:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 701531474487;
	Fri,  7 Nov 2008 23:07:46 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T99Q+xyLDyxq; Fri,  7 Nov 2008 23:07:45 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 806B1147EACC;
	Fri,  7 Nov 2008 23:07:45 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.578.g6a50
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100342>

This is a cleaned up version of the tag decoration patch set. It
also draws the labels slightly nicer, especially when the background
has alternating colors for each row.

-- robin

Robin Rosenberg (7):
  Test the origName part of the key vs the ref itself
  Add constant for "refs/"
  Keep original ref name when reading refs
  Handle peeling of loose refs.
  Add a method to get refs by object Id
  Add tags to the graphical history display.
  Add decorate option to log program

 .../egit/ui/internal/history/SWTCommit.java        |    5 +-
 .../egit/ui/internal/history/SWTPlotRenderer.java  |   71 ++++++++++++++++++-
 .../spearce/egit/ui/internal/history/SWTWalk.java  |    2 +-
 .../src/org/spearce/jgit/pgm/Log.java              |   33 +++++++++
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |   10 +++
 .../org/spearce/jgit/awtui/AWTPlotRenderer.java    |   46 ++++++++++++
 .../src/org/spearce/jgit/lib/Constants.java        |    3 +
 org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java |   77 ++++++++++++++++++--
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   71 ++++++++++++++----
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   14 ++---
 .../src/org/spearce/jgit/lib/Repository.java       |   47 ++++++++++++
 .../spearce/jgit/revplot/AbstractPlotRenderer.java |   23 ++++++-
 .../src/org/spearce/jgit/revplot/PlotCommit.java   |    8 ++-
 .../src/org/spearce/jgit/revplot/PlotWalk.java     |   60 +++++++++++++++-
 14 files changed, 432 insertions(+), 38 deletions(-)
