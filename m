From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 0/2] Quickdiff improvement
Date: Fri, 11 Jul 2008 00:41:10 +0200
Message-ID: <1215729672-26906-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:48:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4vd-0004Lo-VY
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbYGJWqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754400AbYGJWqi
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:46:38 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13190 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755083AbYGJWqU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:46:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CDC77147B7F4;
	Fri, 11 Jul 2008 00:46:18 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dEiXco3xCvlW; Fri, 11 Jul 2008 00:46:18 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 3DDDC802846;
	Fri, 11 Jul 2008 00:46:18 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88040>

Connect quickdiff to the repository event mechanism and allow us
to specify what to compare against.

-- robin

Robin Rosenberg (2):
  Make quick diff aware of changes in the repository.
  Provide the ability to configure the quickdiff baseline

 org.spearce.egit.ui/plugin.properties              |    2 +-
 org.spearce.egit.ui/plugin.xml                     |   14 +++
 .../actions/QuickdiffBaselineOperation.java        |   44 ++++++++++
 .../actions/ResetQuickdiffBaselineAction.java      |   24 +++++
 .../actions/SetQuickdiffBaselineAction.java        |   26 ++++++
 .../egit/ui/internal/decorators/GitDocument.java   |   86 +++++++++++++++++++
 .../internal/decorators/GitQuickDiffProvider.java  |   90 +++++++++-----------
 7 files changed, 236 insertions(+), 50 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/QuickdiffBaselineOperation.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ResetQuickdiffBaselineAction.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/SetQuickdiffBaselineAction.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
