From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/3] cvsimport: partial whitespace cleanup
Date: Sun, 28 Nov 2010 20:39:45 +0100
Message-ID: <468f815beeede312f98daa66986ce8bf887724b3.1290973138.git.git@drmicha.warpmail.net>
References: <4CF2ADC9.8020504@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 28 20:39:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMn5o-0001kx-NO
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 20:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab0K1TjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 14:39:16 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40218 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751973Ab0K1TjQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Nov 2010 14:39:16 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C8D487BF;
	Sun, 28 Nov 2010 14:39:15 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sun, 28 Nov 2010 14:39:15 -0500
X-Sasl-enc: XfJk4TgmuvUBdI6bvyHv8YU6211tbtp6w1P2/GOfQhjJ 1290973155
Received: from localhost (p5485894A.dip0.t-ipconnect.de [84.133.137.74])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 212F6406EFE;
	Sun, 28 Nov 2010 14:39:14 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.614.g03864.dirty
In-Reply-To: <4CF2ADC9.8020504@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162351>

in preparation of the config parse patch

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git-cvsimport.perl |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index d27abfe..7888b77 100755
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
+		chomp(my $tmp = `$arg --get cvsimport.$key`);
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
