From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 0/3] Rename refs
Date: Thu,  7 May 2009 01:32:58 +0200
Message-ID: <1241652781-16873-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu May 07 01:33:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1qbw-0002pO-RX
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 01:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbZEFXdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 19:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbZEFXdF
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 19:33:05 -0400
Received: from mail.dewire.com ([83.140.172.130]:27500 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbZEFXdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 19:33:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id ECCAE14A8B5B;
	Thu,  7 May 2009 01:33:02 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5gRersNJRDNS; Thu,  7 May 2009 01:33:02 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id F37BB14A8B5A;
	Thu,  7 May 2009 01:33:01 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.rc2.1.g868b6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118410>

Not very pretty, but my alternative design was much worse, Having the
refs in a databae would make things simpler.

-- robin

Robin Rosenberg (3):
  Add ref rename support to JGit
  Use Constants.R_* in Branch dialog
  Add ref rename support to the branch dialog

 .../src/org/spearce/egit/ui/UIText.java            |    6 +
 .../ui/internal/dialogs/BranchSelectionDialog.java |  107 ++++++++++++++-----
 .../src/org/spearce/egit/ui/uitext.properties      |    3 +
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |  109 +++++++++++++++++++
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   32 +++++-
 .../src/org/spearce/jgit/lib/RefLogWriter.java     |   21 ++++-
 .../src/org/spearce/jgit/lib/RefUpdate.java        |  112 +++++++++++++++++++-
 .../src/org/spearce/jgit/lib/Repository.java       |   33 ++++++
 8 files changed, 390 insertions(+), 33 deletions(-)
