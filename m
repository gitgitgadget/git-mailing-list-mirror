From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT] Sort order from hell fixes, take 2
Date: Sun, 24 Feb 2008 00:50:33 +0100
Message-ID: <1203810643-28819-1-git-send-email-robin.rosenberg@dewire.com>
Cc: David Watson <dwatson@mimvista.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 00:51:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT49l-00013x-B9
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbYBWXuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752767AbYBWXux
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:50:53 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11189 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752245AbYBWXux (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:50:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5D20B802896;
	Sun, 24 Feb 2008 00:50:51 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id taW1dszZTg5s; Sun, 24 Feb 2008 00:50:50 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 4A3628027FE;
	Sun, 24 Feb 2008 00:50:50 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 7D7AA2930B; Sun, 24 Feb 2008 00:50:43 +0100 (CET)
X-Mailer: git-send-email 1.5.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74885>

Hi fans,

My previous attempt to fix this failed, so here is another round, including
some new infrastructure like a TreeIterator to support this fix and whatever
will need it.

Feed free to scrutize and invent whatever evil test case might be missing.

The reason I noticed the problem was introduced in c20142, where the unit
tests for org.spearce.jgit was moved to the new project org.spearce.jgit.test .

-- robin
