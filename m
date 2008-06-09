From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [EGIT PATCHES] Assorted minor fixes
Date: Tue, 10 Jun 2008 00:50:09 +0200
Message-ID: <1213051816-4046-1-git-send-email-robin.rosenberg.lists@dewire.com>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 00:55:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5qGD-0001Eo-3p
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 00:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080AbYFIWx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 18:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755797AbYFIWx0
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 18:53:26 -0400
Received: from [83.140.172.130] ([83.140.172.130]:17212 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755056AbYFIWxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 18:53:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5EBA21434DDF;
	Tue, 10 Jun 2008 00:53:22 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LCMT42bqO+Jg; Tue, 10 Jun 2008 00:53:21 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id A5CBC800691;
	Tue, 10 Jun 2008 00:53:21 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.178.g1f811
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84441>


-- robin

 .../egit/core/op/ConnectProviderOperation.java     |   15 ++++++-
 org.spearce.egit.ui/icons/toolbar/trackd.png       |  Bin 0 -> 387 bytes
 org.spearce.egit.ui/icons/toolbar/tracke.png       |  Bin 0 -> 411 bytes
 org.spearce.egit.ui/plugin.properties              |    2 +-
 org.spearce.egit.ui/plugin.xml                     |   19 +++++----
 .../src/org/spearce/egit/ui/UIText.java            |    3 +
 .../egit/ui/internal/actions/ResetAction.java      |    2 +-
 .../spearce/egit/ui/internal/actions/Track.java    |   40 +++++++++++++++++---
 .../internal/decorators/GitResourceDecorator.java  |    2 +-
 .../egit/ui/internal/history/GitHistoryPage.java   |   24 +++++++++---
 .../ui/internal/sharing/ExistingOrNewPage.java     |   17 ++++++++
 .../egit/ui/internal/sharing/SharingWizard.java    |   16 +++++++-
 .../src/org/spearce/egit/ui/uitext.properties      |    1 +
 13 files changed, 115 insertions(+), 26 deletions(-)
