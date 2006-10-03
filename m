From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [StGIT PATCH 3/3] Fix the --cover option.
Date: Tue, 03 Oct 2006 23:34:57 +0200
Message-ID: <20061003213457.26195.55955.stgit@lathund.dewire.com>
References: <20061003213453.26195.54830.stgit@lathund.dewire.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Oct 03 23:34:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUruS-0003OJ-9e
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 23:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030559AbWJCVeg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 17:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbWJCVeg
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 17:34:36 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18974 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1030559AbWJCVef
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 17:34:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 156DD800782
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:31:41 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22597-10 for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:31:41 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by torino.dewire.com (Postfix) with ESMTP id 183708028A1
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:31:40 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id DD41A28F58
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:34:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id cdnGi3ftktnB for <git@vger.kernel.org>;
	Tue,  3 Oct 2006 23:34:57 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id CC3E728AF4
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:34:57 +0200 (CEST)
To: git@vger.kernel.org
In-Reply-To: <20061003213453.26195.54830.stgit@lathund.dewire.com>
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28304>

From: Robin Rosenberg <robin.rosenberg@dewire.com>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 stgit/commands/mail.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 8a713a1..c7f0f46 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -419,7 +419,7 @@ def func(parser, options, args):
     if options.cover or options.edit:
         # find the template file
         if options.cover:
-            tmpl = file(options.template).read()
+            tmpl = file(options.cover).read()
         else:
             tmpl = templates.get_template('covermail.tmpl')
             if not tmpl:
