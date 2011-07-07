From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [RFC/PATCH] Changed gitweb.remote_heads config key name to gitweb.remoteHeads.
Date: Thu,  7 Jul 2011 14:02:19 -0400
Message-ID: <1310061739-4441-1-git-send-email-marcnarc@xiplink.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 20:02:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qesue-0005Mn-Vq
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 20:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091Ab1GGSCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 14:02:51 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:4177 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752850Ab1GGSCv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2011 14:02:51 -0400
Received: from rincewind.xiplink.com (rincewind.xiplink.com [192.168.1.136])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id p67I2l88028231;
	Thu, 7 Jul 2011 14:02:47 -0400
X-Mailer: git-send-email 1.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176764>

Git doesn't accept config key names with underscore characters.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

Came across this today.  The patch is RFC because I have not verified 
if it's complete or if gitweb even respects the setting.

 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 81dacf2..edbb080 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -524,9 +524,9 @@ our %feature = (
 	# $feature{'remote_heads'}{'default'} = [1];
 	# To have project specific config enable override in $GITWEB_CONFIG
 	# $feature{'remote_heads'}{'override'} = 1;
-	# and in project config gitweb.remote_heads = 0|1;
+	# and in project config gitweb.remoteHeads = 0|1;
 	'remote_heads' => {
-		'sub' => sub { feature_bool('remote_heads', @_) },
+		'sub' => sub { feature_bool('remoteHeads', @_) },
 		'override' => 0,
 		'default' => [0]},
 );
-- 
1.7.6
