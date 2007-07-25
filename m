From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Document --unified/-U option
Date: Wed, 25 Jul 2007 12:08:17 +0200
Message-ID: <20070725100817.21185.91337.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jul 25 12:07:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDdmS-0005X0-Ni
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 12:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178AbXGYKHm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 06:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755202AbXGYKHm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 06:07:42 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19534 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754333AbXGYKHl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 06:07:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 40E4380266C;
	Wed, 25 Jul 2007 12:00:24 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05837-07; Wed, 25 Jul 2007 12:00:24 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 018E080019B;
	Wed, 25 Jul 2007 12:00:23 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 79EA2284A6;
	Wed, 25 Jul 2007 12:08:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id Lb1aTe2m8Jrs; Wed, 25 Jul 2007 12:08:20 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 291AA28391;
	Wed, 25 Jul 2007 12:08:18 +0200 (CEST)
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 Documentation/diff-options.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 1689c74..050e5fd 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -4,6 +4,13 @@
 -u::
 	Synonym for "-p".
 
+-U<n>::
+	Shorthand for "--unified=<n>".
+
+--unified=<n>::
+	Generate diffs with <n> lines of context instead of
+	the usual three. Implies "-p".
+
 --raw::
 	Generate the raw format.
 
