From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 7/8] git-remote-mediawiki: show progress information when getting last remote revision
Date: Mon, 16 Jul 2012 21:46:41 +0200
Message-ID: <1342468002-31818-8-git-send-email-Matthieu.Moy@imag.fr>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
 <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 16 21:48:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqrHW-0000yu-2s
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 21:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748Ab2GPTs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 15:48:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37308 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753705Ab2GPTs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 15:48:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6GJjdoh014915
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 21:45:39 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqrGS-0001Sm-DK; Mon, 16 Jul 2012 21:47:28 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqrGS-0008Ic-C6; Mon, 16 Jul 2012 21:47:28 +0200
X-Mailer: git-send-email 1.7.11.2.258.g5ff3cdf.dirty
In-Reply-To: <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 16 Jul 2012 21:45:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GJjdoh014915
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1343072740.06834@k5YT4FkLGW4bAeAs6cwbGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201562>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 729a0bc..8badff6 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -579,6 +579,8 @@ sub get_last_remote_revision {
 
 	my $max_rev_num = 0;
 
+	print STDERR "Getting last revision id on tracked pages...\n";
+
 	foreach my $page (@pages) {
 		my $id = $page->{pageid};
 
-- 
1.7.11.2.258.g5ff3cdf.dirty
