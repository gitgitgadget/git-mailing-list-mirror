From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH 0/4] Eclipse (EGIT) Structured compare
Date: Sun, 18 Mar 2007 23:15:50 +0100
Message-ID: <20070318220711.24742.90943.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 23:14:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT3dc-0000PT-Tu
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 23:14:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933307AbXCRWN6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 18:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933338AbXCRWN5
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 18:13:57 -0400
Received: from [83.140.172.130] ([83.140.172.130]:7588 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933307AbXCRWN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 18:13:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AE45A802857;
	Sun, 18 Mar 2007 23:08:34 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18488-05; Sun, 18 Mar 2007 23:08:34 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 5BF45802664;
	Sun, 18 Mar 2007 23:08:33 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 612F828D38;
	Sun, 18 Mar 2007 23:16:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id zykRwTk4btqH; Sun, 18 Mar 2007 23:15:52 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id C218228CA9;
	Sun, 18 Mar 2007 23:15:50 +0100 (CET)
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42531>

Now Eclipse can compare two git version at the project level. Thanks
to the SHA-1's the compare is very quick. There is some extra cost
for version managed archives (zip/jars) as Eclipse insists on comparing
the contents of those at the file level too. Not that I mind that. It
is useful and cool. (No, it doesn't compare open office documents in
any useful manner, unless you happen to have a plugin for it, in
which case it might actually work.)

Along with this some experiments with caching and a minor bug fix in
the commit reader.

If anyone besides me actually uses this, please send a comment.

-- robin
