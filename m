From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 7/8] git-remote-mediawiki: show progress information when getting last remote revision
Date: Mon, 16 Jul 2012 14:00:52 +0200
Message-ID: <1342440053-3058-8-git-send-email-Matthieu.Moy@imag.fr>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 16 14:02:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqjzz-0006ul-1a
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 14:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279Ab2GPMBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 08:01:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45928 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab2GPMBw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 08:01:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6GBxeWG021759
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 13:59:40 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqjzH-0002WJ-K7; Mon, 16 Jul 2012 14:01:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqjzH-0000oW-IX; Mon, 16 Jul 2012 14:01:15 +0200
X-Mailer: git-send-email 1.7.11.1.30.g7e1baf9.dirty
In-Reply-To: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Jul 2012 13:59:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GBxeWG021759
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1343044783.00513@aXFLyBeEmDMKdqYmNsdVWQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201511>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 755c9d0..cf467ac 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -579,6 +579,8 @@ sub get_last_remote_revision {
 
 	my $max_rev_num = 0;
 
+	print STDERR "Getting last revision id on tracked pages...\n";
+
 	foreach my $page (@pages) {
 		my $id = $page->{pageid};
 
-- 
1.7.11.1.30.g7e1baf9.dirty
