From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] cvsimport: partial whitespace cleanup
Date: Wed, 29 Dec 2010 22:55:33 +0100
Message-ID: <468f815beeede312f98daa66986ce8bf887724b3.1293659350.git.git@drmicha.warpmail.net>
References: <cover.1293659350.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 29 22:55:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY3yy-0007Lc-15
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 22:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab0L2Vyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 16:54:53 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:51428 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753917Ab0L2Vyw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Dec 2010 16:54:52 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2DC05637
	for <git@vger.kernel.org>; Wed, 29 Dec 2010 16:54:52 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 29 Dec 2010 16:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=Ld6wl2E7nMrSbx+HIdxpU6Ja1hY=; b=MzZNUpxAIK1KdQ66S94KUMGdZs65tZ2nO4fHno+V62kQ0rCpj9wtJM2pD79oIIKoI1WtlZ8wcv2QT59DTjucxgd7gmeYcsFYzK32GRODlhgeIgGYilCyQmJ2I5kbk9r3hxdNfjfp6xt43MYMdRUkq1BMYw412Q+6o4wwr0CpI5w=
X-Sasl-enc: 1V5uLCniMPfUO+OWPT9S92Nyl4OC6S34TrsSufwWXjGi 1293659691
Received: from localhost (p54858E58.dip0.t-ipconnect.de [84.133.142.88])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7313B44129A;
	Wed, 29 Dec 2010 16:54:51 -0500 (EST)
X-Mailer: git-send-email 1.7.3.4.865.ga2bc4
In-Reply-To: <cover.1293659350.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164334>

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
1.7.3.4.865.ga2bc4
