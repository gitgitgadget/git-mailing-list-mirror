From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 06/20] cvsserver: clean up client request handler map comments
Date: Sat, 13 Oct 2012 23:42:19 -0600
Message-ID: <1350193353-19210-7-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:48:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNH40-0006rG-O0
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175Ab2JNFsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:48:21 -0400
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:54953 "EHLO
	qmta01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752058Ab2JNFsU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:48:20 -0400
Received: from omta16.emeryville.ca.mail.comcast.net ([76.96.30.72])
	by qmta01.emeryville.ca.mail.comcast.net with comcast
	id AtnN1k0091ZMdJ4A1toLKc; Sun, 14 Oct 2012 05:48:20 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta16.emeryville.ca.mail.comcast.net with comcast
	id AtjK1k00A2wKXRC8ctjK5d; Sun, 14 Oct 2012 05:43:20 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 4481B1E9601D; Sat, 13 Oct 2012 23:43:19 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207620>

  - Comment that it should not be considered a complete list.
  - #'annotate' comment  - Uncommented annotate line is 2 lines earlier.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 8b2accb..9e71f30 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -51,6 +51,10 @@ $| = 1;
 
 #### Definition and mappings of functions ####
 
+# NOTE: Despite the existence of req_CATCHALL and req_EMPTY unimplemented
+#  requests, this list is incomplete.  It is missing many rarer/optional
+#  requests.  Perhaps some clients require a claim of support for
+#  these specific requests for main functionality to work?
 my $methods = {
     'Root'            => \&req_Root,
     'Valid-responses' => \&req_Validresponses,
@@ -80,7 +84,6 @@ my $methods = {
     'noop'            => \&req_EMPTY,
     'annotate'        => \&req_annotate,
     'Global_option'   => \&req_Globaloption,
-    #'annotate'        => \&req_CATCHALL,
 };
 
 ##############################################
-- 
1.7.10.2.484.gcd07cc5
