From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 09/10] user-manual: remote-tracking can be checked out, with detached HEAD
Date: Tue,  2 Nov 2010 16:31:27 +0100
Message-ID: <1288711888-21528-10-git-send-email-Matthieu.Moy@imag.fr>
References: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 02 17:01:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDJIl-00086C-9C
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 17:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab0KBQBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 12:01:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44196 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752548Ab0KBQB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 12:01:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oA2FGqtk006393
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Nov 2010 16:16:52 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PDIpz-00027Y-JD; Tue, 02 Nov 2010 16:31:51 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PDIpz-0005cR-H4; Tue, 02 Nov 2010 16:31:51 +0100
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 02 Nov 2010 16:16:52 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA2FGqtk006393
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1289315814.17565@GYVA1UqTg279LBHaPtnhVg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160539>

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/user-manual.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 6d6bd8d..3108b38 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -367,13 +367,16 @@ above were created based on the remote branches at clone time and will
 be updated by "git fetch" (hence "git pull) and "git push". See
 <<Updating -a-repository-With-git-fetch>> for details.
 
-You cannot check out these remote-tracking branches, but you can
-examine them on a branch of your own, just as you would a tag:
+You might want to build on one of these remote-tracking branches
+on a branch of your own, just as you would for a tag:
 
 ------------------------------------------------
 $ git checkout -b my-todo-copy origin/todo
 ------------------------------------------------
 
+You can also check out "origin/todo" directly to examine it or
+write a one-off patch.  See <<detached-head,detached head>>.
+
 Note that the name "origin" is just the name that git uses by default
 to refer to the repository that you cloned from.
 
-- 
1.7.3.2.183.g2e7b0
