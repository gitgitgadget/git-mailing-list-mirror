From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [StGit PATCH] Add an empty line before signed-off-by
Date: Sat, 10 Mar 2007 00:00:41 +0100
Message-ID: <20070309225959.20959.32505.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Fri Mar 09 23:59:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPo3k-0007aP-7r
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 23:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767601AbXCIW73 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 17:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767604AbXCIW73
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 17:59:29 -0500
Received: from [83.140.172.130] ([83.140.172.130]:20029 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1767601AbXCIW71 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 17:59:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DF85380284B;
	Fri,  9 Mar 2007 23:54:12 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06063-05; Fri,  9 Mar 2007 23:54:12 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 90B23802848;
	Fri,  9 Mar 2007 23:54:10 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 1429A297B8;
	Sat, 10 Mar 2007 00:01:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id tBLLGVA5gzSW; Sat, 10 Mar 2007 00:00:49 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 2EB0C29786;
	Sat, 10 Mar 2007 00:00:45 +0100 (CET)
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41817>

Default to the standard convention of having an empty line
before the Signed-off line when addign a signature using the
--sign option.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 stgit/commands/refresh.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 4cf09ae..dbcb757 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -108,7 +108,7 @@ def func(parser, options, args):
         options.authname, options.authemail = name_email(options.author)
 
     if options.sign:
-        sign_str = 'Signed-off-by'
+        sign_str = '\nSigned-off-by'
         if options.ack:
             raise CmdException, '--ack and --sign were both specified'
     elif options.ack:
