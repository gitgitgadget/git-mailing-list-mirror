From: Simon Ruderich <simon@ruderich.org>
Subject: [PATCH] git-config: document interactive.singlekey requires
 Term::Readkey
Date: Sun, 2 Mar 2014 20:58:40 +0100
Message-ID: <6157736903dbcb3359eda07eff6f0faf832ef256.1393790234.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 20:58:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKCXJ-0006pP-Qq
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 20:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbaCBT6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 14:58:48 -0500
Received: from zucker.schokokeks.org ([178.63.68.96]:49902 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbaCBT6s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 14:58:48 -0500
Received: from localhost (pD9E9798F.dip0.t-ipconnect.de [::ffff:217.233.121.143])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Sun, 02 Mar 2014 20:58:43 +0100
  id 0000000000020077.0000000053138D73.000078C8
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243159>

Most distributions don't require Term::Readkey as dependency,
leaving the user to wonder why the setting doesn't work.

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f4d793..ec26fa8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1633,7 +1633,7 @@ interactive.singlekey::
 	linkgit:git-add[1], linkgit:git-checkout[1], linkgit:git-commit[1],
 	linkgit:git-reset[1], and linkgit:git-stash[1]. Note that this
 	setting is silently ignored if portable keystroke input
-	is not available.
+	is not available; requires the Perl module Term::Readkey.
 
 log.abbrevCommit::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-- 
1.9.0.11.g9a08b42

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
