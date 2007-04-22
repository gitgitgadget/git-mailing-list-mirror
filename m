From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 0/4] Unit test for plugin and then some
Date: Sun, 22 Apr 2007 23:35:51 +0200
Message-ID: <20070422212907.26396.12810.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Apr 22 23:36:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfjjO-0008BM-R0
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 23:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbXDVVgX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 17:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbXDVVgX
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 17:36:23 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14867 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbXDVVgW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 17:36:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7174E8028A0;
	Sun, 22 Apr 2007 23:30:29 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25602-06; Sun, 22 Apr 2007 23:30:29 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 0EBA8802892;
	Sun, 22 Apr 2007 23:30:29 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 2C445297FE;
	Sun, 22 Apr 2007 23:36:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id TM2IZH4tvlRu; Sun, 22 Apr 2007 23:35:55 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 31AA229100;
	Sun, 22 Apr 2007 23:35:52 +0200 (CEST)
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45278>

This adds a JUnit test for the plugin. It doesn't test much
yet, but rather than having more people add the infrastructure
I submit the skeleton and two small samples here. A writeRef
method is implemented to be able to set up the test repository
without using native Git. 

I also found an unneeded class when using Eclipse 3.3M6. Exterminated.

I also dropped the non-git sort order of trees.  This isn't too good looking, but
I expect it to be improved in later versions.

-- robin
