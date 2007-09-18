From: Ben Konrath <bkonrath@redhat.com>
Subject: [EGIT PATCH] Remove src dir and entry in build.properties.
Date: Tue, 18 Sep 2007 18:20:57 -0400
Message-ID: <20070918222057.GA11990@toast.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:21:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXlRV-00029Q-3U
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbXIRWVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752919AbXIRWVK
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:21:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55074 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbXIRWVI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 18:21:08 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8IMKx2L009049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Sep 2007 18:20:59 -0400
Received: from pobox.toronto.redhat.com (pobox.toronto.redhat.com [172.16.14.4])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8IMKxlb013039;
	Tue, 18 Sep 2007 18:20:59 -0400
Received: from touchme.toronto.redhat.com (IDENT:postfix@touchme.toronto.redhat.com [172.16.14.9])
	by pobox.toronto.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l8IMKwai032288;
	Tue, 18 Sep 2007 18:20:59 -0400
Received: from toast.toronto.redhat.com (toast.toronto.redhat.com [172.16.14.221])
	by touchme.toronto.redhat.com (Postfix) with ESMTP
	id B50B18001FF; Tue, 18 Sep 2007 18:20:58 -0400 (EDT)
Received: from toast.toronto.redhat.com (localhost.localdomain [127.0.0.1])
	by toast.toronto.redhat.com (8.14.1/8.13.0) with ESMTP id l8IMKwIR012002;
	Tue, 18 Sep 2007 18:20:58 -0400
Received: (from bkonrath@localhost)
	by toast.toronto.redhat.com (8.14.1/8.14.1/Submit) id l8IMKvc6012001;
	Tue, 18 Sep 2007 18:20:57 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58638>

Hi Robin,

This is just a small clean up patch for the branding plugin.

CHeers, Ben

Signed-off-by: Ben Konrath <bkonrath@redhat.com>
---
 org.spearce.egit/build.properties |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)
 delete mode 100644 org.spearce.egit/src/.gitignore

diff --git a/org.spearce.egit/build.properties b/org.spearce.egit/build.properties
index 2a21c05..22d4e45 100644
--- a/org.spearce.egit/build.properties
+++ b/org.spearce.egit/build.properties
@@ -1,5 +1,3 @@
-source.. = src/
-output.. = bin/
 bin.includes = META-INF/,\
                egit.png,\
                about.ini
diff --git a/org.spearce.egit/src/.gitignore b/org.spearce.egit/src/.gitignore
deleted file mode 100644
index e69de29..0000000
-- 
1.5.2.4
