From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/8] git-remote-mediawiki: don't split namespaces with spaces
Date: Mon, 16 Jul 2012 14:00:46 +0200
Message-ID: <1342440053-3058-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 16 14:01:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqjzj-0006YA-6j
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 14:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019Ab2GPMB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 08:01:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54837 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568Ab2GPMB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 08:01:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6GBxWEf021730
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 13:59:32 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sqjz7-0002V1-Vo; Mon, 16 Jul 2012 14:01:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sqjz7-0000oE-U6; Mon, 16 Jul 2012 14:01:05 +0200
X-Mailer: git-send-email 1.7.11.1.30.g7e1baf9.dirty
In-Reply-To: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Jul 2012 13:59:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GBxWEf021730
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1343044772.96719@2pyLkpsGKw9H+y/cz4ubEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201508>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index accd70a..a6ad8cf 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -1275,7 +1275,7 @@ sub get_mw_namespace_id {
 		# Look at configuration file, if the record for that namespace is
 		# already cached. Namespaces are stored in form:
 		# "Name_of_namespace:Id_namespace", ex.: "File:6".
-		my @temp = split(/[ \n]/, run_git("config --get-all remote."
+		my @temp = split(/[\n]/, run_git("config --get-all remote."
 						. $remotename .".namespaceCache"));
 		chomp(@temp);
 		foreach my $ns (@temp) {
-- 
1.7.11.1.30.g7e1baf9.dirty
