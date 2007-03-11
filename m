From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [EGIT PATCH 00/10] Fixes and improvement on Eclipse plugin
Date: Sun, 11 Mar 2007 19:15:15 +0100
Message-ID: <20070311180608.18012.13767.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Mar 11 19:13:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQSYD-00066B-5J
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 19:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933940AbXCKSNm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 14:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933941AbXCKSNl
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 14:13:41 -0400
Received: from [83.140.172.130] ([83.140.172.130]:1592 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933940AbXCKSNk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 14:13:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 53C52802841;
	Sun, 11 Mar 2007 19:08:25 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25997-10; Sun, 11 Mar 2007 19:08:24 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id E41BD802848;
	Sun, 11 Mar 2007 19:08:21 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 03BF4291DB;
	Sun, 11 Mar 2007 19:15:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id Ewe65hiUxhWt; Sun, 11 Mar 2007 19:15:19 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 005EB28CD7;
	Sun, 11 Mar 2007 19:15:15 +0100 (CET)
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41951>

Here is a mix of bug fixes and performance improvements. The most
important ones are that the history panel now shows the right
history (yea, I'm an SWT/JFace n00b so there may be more suble bugs
there). Actually, now that I come to think of it; the rows in the
history window sometimes get the wrong height. The workaround is
to press ALT-F4 and then cancel. 

The other big thing is that Eclipse now caches commits so browsing
the resorces updates the history view immediately instead of an
annoying second or two later, provided the Link with Editor button
is pushed.

As for JDK, I recommend JDK 1.5.11 or JDK 1.6 for running because
of improvements and bug fixes made by Sun wrt GC and memory mapping.

-- robin
