From: Eric Lesh <eclesh@ucla.edu>
Subject: [PATCH guilt] Documentation/guilt-fork: document argument to
	choose name of new patch
Date: Tue, 27 Mar 2007 20:48:13 -0700
Message-ID: <1175053693.5945.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Wed Mar 28 06:15:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWPZQ-0001as-N4
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 06:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912AbXC1EPd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 00:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753914AbXC1EPd
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 00:15:33 -0400
Received: from smtp-3.smtp.ucla.edu ([169.232.48.136]:60319 "EHLO
	smtp-3.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912AbXC1EPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 00:15:32 -0400
X-Greylist: delayed 1631 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Mar 2007 00:15:32 EDT
Received: from mail.ucla.edu (mail.ucla.edu [169.232.48.150])
	by smtp-3.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l2S3mEic029988;
	Tue, 27 Mar 2007 20:48:14 -0700
Received: from [192.168.1.7] (adsl-75-26-189-151.dsl.scrm01.sbcglobal.net [75.26.189.151])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l2S3mDUQ026368
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Tue, 27 Mar 2007 20:48:14 -0700
X-Mailer: Evolution 2.8.1 
X-Probable-Spam: no
X-Scanned-By: smtp.ucla.edu on 169.232.48.136
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43353>

From: Eric Lesh <eclesh@ucla.edu>
Date: Tue, 27 Mar 2007 20:36:27 -0700
Subject: [PATCH] Documentation/guilt-fork: document argument to choose name of new patch

Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
 Documentation/guilt-fork.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/guilt-fork.txt b/Documentation/guilt-fork.txt
index c5b9ed3..c474345 100644
--- a/Documentation/guilt-fork.txt
+++ b/Documentation/guilt-fork.txt
@@ -14,6 +14,11 @@ DESCRIPTION
 Create a copy of the top most patch, and replace the entry in the series
 file to use this new patch file.
 
+OPTIONS
+-------
+<new_name>::
+	The name of the new patch to create.
+
 Author
 ------
 Written by Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
-- 
1.5.1-rc1.GIT
