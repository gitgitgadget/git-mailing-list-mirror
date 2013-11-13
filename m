From: "Jason St. John" <jstjohn@purdue.edu>
Subject: [PATCH 1/2] Rewrite man page explanation of git log's "--log-size" option
Date: Wed, 13 Nov 2013 01:21:48 -0500
Message-ID: <1384323709-2690-1-git-send-email-jstjohn@purdue.edu>
Cc: "Jason St. John" <jstjohn@purdue.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 13 07:22:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgTpx-0003IR-7u
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 07:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756626Ab3KMGV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 01:21:58 -0500
Received: from mailhub129.itcs.purdue.edu ([128.210.5.129]:51733 "EHLO
	mailhub129.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751926Ab3KMGV4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Nov 2013 01:21:56 -0500
Received: from megahurtz.itap.purdue.edu (pal-nat184-041-152.itap.purdue.edu [10.184.41.152])
	(authenticated bits=0)
	by mailhub129.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id rAD6Lpd4006447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 13 Nov 2013 01:21:55 -0500
X-Mailer: git-send-email 1.8.4.2
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237776>

Documentation/git-log.txt:
--log-size was added in commit 9fa3465, and the commit message contained
a satisfactory explanation; however, the man page entry for it was
unclear and cryptic.

Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jason St. John <jstjohn@purdue.edu>
---
This is effectively a resubmit of my previous patch here:
http://marc.info/?l=git&m=138395803808196&w=2

Thanks to Jonathan Nieder for writing the text used in this commit:
http://marc.info/?l=git&m=138395887208373&w=2


 Documentation/git-log.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 34097ef..a5de513 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -56,11 +56,11 @@ Note that this affects all diff-based output types, e.g. those
 produced by --stat etc.
 
 --log-size::
-	Before the log message print out its size in bytes. Intended
-	mainly for porcelain tools consumption. If Git is unable to
-	produce a valid value size is set to zero.
-	Note that only message is considered, if also a diff is shown
-	its size is not included.
+
+	Include a line ``log size <number>'' in the output for each commit,
+	where <number> is the length of that commit's message in bytes.
+	Intended to speed up tools that read log messages from `git log`
+	output by allowing them to allocate space in advance.
 
 -L <start>,<end>:<file>::
 -L :<regex>:<file>::
-- 
1.8.4.2
