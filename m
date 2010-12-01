From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 1/3] cvsimport: partial whitespace cleanup
Date: Wed,  1 Dec 2010 13:53:20 +0100
Message-ID: <468f815beeede312f98daa66986ce8bf887724b3.1291207768.git.git@drmicha.warpmail.net>
References: <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 13:56:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNmED-0003d0-9i
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 13:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194Ab0LAMzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 07:55:42 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49526 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755175Ab0LAMzk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 07:55:40 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4E57F59E;
	Wed,  1 Dec 2010 07:55:40 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 01 Dec 2010 07:55:40 -0500
X-Sasl-enc: R4/cakcSKBk8iIKmfq4an1Ts/6a25UedUEKZgdAecvYZ 1291208139
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B7C335E086B;
	Wed,  1 Dec 2010 07:55:39 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.617.g84f63
In-Reply-To: <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1291207768.git.git@drmicha.warpmail.net>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162507>

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
1.7.3.2.617.g84f63
