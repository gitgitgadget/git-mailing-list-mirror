From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 0/3] Ref log reader
Date: Sun,  7 Jun 2009 22:19:08 +0200
Message-ID: <1244405951-21808-1-git-send-email-robin.rosenberg@dewire.com>
References: <y>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 07 22:19:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDOqH-0003R9-BA
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 22:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbZFGUTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 16:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754619AbZFGUTR
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 16:19:17 -0400
Received: from mail.dewire.com ([83.140.172.130]:18038 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132AbZFGUTP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 16:19:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E650E146D03B;
	Sun,  7 Jun 2009 22:19:14 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D6bdQF4Ifg3N; Sun,  7 Jun 2009 22:19:14 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id D7CA7146D031;
	Sun,  7 Jun 2009 22:19:13 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.199.g7340d
In-Reply-To: <y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120996>

Initially this is needed to the next revised set of rename tests. I have
not optimized much for performance.

-- robin

Robin Rosenberg (3):
  Assert the name and origName properties of Ref objects
  Add methods to RawParseUtils for scanning backwards.
  Add a ref log reader class

 .../tst/org/spearce/jgit/lib/RefTest.java          |   11 ++
 .../tst/org/spearce/jgit/lib/ReflogReaderTest.java |  153 ++++++++++++++++
 .../src/org/spearce/jgit/lib/ReflogReader.java     |  186 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |    9 +
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   84 +++++++++-
 5 files changed, 442 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReflogReaderTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/ReflogReader.java
