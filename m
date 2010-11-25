From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/3] cvsimport: partial whitespace cleanup
Date: Thu, 25 Nov 2010 16:10:54 +0100
Message-ID: <939dff25f5a58b6f37cf21bf490b2782f6e96f39.1290697830.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 25 16:13:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLdVX-0007id-Ky
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 16:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab0KYPND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 10:13:03 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:52691 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751941Ab0KYPNC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 10:13:02 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3D09F940;
	Thu, 25 Nov 2010 10:13:02 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 25 Nov 2010 10:13:02 -0500
X-Sasl-enc: BDtizPGKrtX1ZOukwZgwH9Au88OvYjtYiiokezD6dYmX 1290697981
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AF1755E31C3;
	Thu, 25 Nov 2010 10:13:01 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.614.g03864.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162139>

in preparation of the config parse patch

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git-cvsimport.perl |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index d27abfe..f955295 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -91,8 +91,8 @@ sub write_author_info($) {
 
 # convert getopts specs for use by git config
 sub read_repo_config {
-    # Split the string between characters, unless there is a ':'
-    # So "abc:de" becomes ["a", "b", "c:", "d", "e"]
+	# Split the string between characters, unless there is a ':'
+	# So "abc:de" becomes ["a", "b", "c:", "d", "e"]
 	my @opts = split(/ *(?!:)/, shift);
 	foreach my $o (@opts) {
 		my $key = $o;
@@ -100,13 +100,13 @@ sub read_repo_config {
 		my $arg = 'git config';
 		$arg .= ' --bool' if ($o !~ /:$/);
 
-        chomp(my $tmp = `$arg --get cvsimport.$key`);
+		chomp(my $tmp = `$arg --get cvsimport.$ckey`);
 		if ($tmp && !($arg =~ /--bool/ && $tmp eq 'false')) {
-            no strict 'refs';
-            my $opt_name = "opt_" . $key;
-            if (!$$opt_name) {
-                $$opt_name = $tmp;
-            }
+			no strict 'refs';
+			my $opt_name = "opt_" . $key;
+			if (!$$opt_name) {
+				$$opt_name = $tmp;
+			}
 		}
 	}
 }
-- 
1.7.3.2.614.g03864.dirty
