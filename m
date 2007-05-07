From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT 00/10] This weeks Eclipse patches
Date: Mon, 07 May 2007 23:29:08 +0200
Message-ID: <20070507212636.21546.29280.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 07 23:29:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlAlz-0003n9-Ik
	for gcvg-git@gmane.org; Mon, 07 May 2007 23:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966559AbXEGV33 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 17:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966777AbXEGV33
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 17:29:29 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12223 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S966559AbXEGV32 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 17:29:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9E734802676;
	Mon,  7 May 2007 23:23:22 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24594-09; Mon,  7 May 2007 23:23:22 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 58D84800783;
	Mon,  7 May 2007 23:23:22 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 8BC1A294E7;
	Mon,  7 May 2007 23:29:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id YCCur1gx3ef3; Mon,  7 May 2007 23:29:08 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 94CAB28F06;
	Mon,  7 May 2007 23:29:08 +0200 (CEST)
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46483>

A random collection of improvements to the Eclipse
plugin.

Highlights:
        - Now compatible with Eclipse 3.2.1 through 3.3 M7
        - Update compare view immediately when selecting a commit
          with the left button.
        - Compare with previous menu item, not just two selected
          commits.
	- Tooltip with full comment in history view
        - Minor performance and API enhancements
	- New bugs (FREE, apply now!)

You'll need Sun's JDK version 1.6 to run gracefully since the
memory mapping stresses the GC. With older versions you will get
out of memory errors needlessly, which currently means the
implementation does not see all objects.

-- robin 
