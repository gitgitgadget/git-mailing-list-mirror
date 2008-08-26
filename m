From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/6] git svn info: tests: let 'init' test run with SVN 1.5
Date: Tue, 26 Aug 2008 21:32:32 +0200
Message-ID: <1219779157-31602-2-git-send-email-trast@student.ethz.ch>
References: <1219779157-31602-1-git-send-email-trast@student.ethz.ch>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 21:33:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY4IT-0004X8-Cf
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 21:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759585AbYHZTcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 15:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759589AbYHZTcl
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 15:32:41 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:37853 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756278AbYHZTcj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 15:32:39 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 26 Aug 2008 21:32:36 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 26 Aug 2008 21:32:36 +0200
X-Mailer: git-send-email 1.6.0.1.169.g494a
In-Reply-To: <1219779157-31602-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 26 Aug 2008 19:32:36.0317 (UTC) FILETIME=[7E6940D0:01C907B2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93807>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t9119-git-svn-info.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 5fd36a1..46676bc 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -9,9 +9,9 @@ test_description='git-svn info'
 set -e
 
 # Tested with: svn, version 1.4.4 (r25188)
-v=`svn --version | sed -n -e 's/^svn, version \(1\.4\.[0-9]\).*$/\1/p'`
+v=`svn --version | sed -n -e 's/^svn, version \(1\.[0-9]*\.[0-9]*\).*$/\1/p'`
 case $v in
-1.4.*)
+1.[45].*)
 	;;
 *)
 	say "skipping svn-info test (SVN version: $v not supported)"
-- 
1.6.0.1.96.g9307e.dirty
