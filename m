From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 09/10] user-manual: remote-tracking can be checked out, with detached HEAD
Date: Thu, 28 Oct 2010 20:21:56 +0200
Message-ID: <1288290117-6734-10-git-send-email-Matthieu.Moy@imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 28 20:24:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBX9e-00069U-1a
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 20:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934082Ab0J1SYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 14:24:37 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47872 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934029Ab0J1SYg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 14:24:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9SI87Uq011698
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 28 Oct 2010 20:08:07 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PBX7k-0003kF-Bk; Thu, 28 Oct 2010 20:22:52 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PBX7k-0001m1-9J; Thu, 28 Oct 2010 20:22:52 +0200
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 28 Oct 2010 20:08:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9SI87Uq011698
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1288894090.60275@FeV4PEXGD8jK09pUfLNW5g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160198>

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/user-manual.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 62b3788..2b04e84 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -368,13 +368,16 @@ They are references that will be updated by "git fetch" (hence by "git
 pull"), and by "git push". See
 <<Updating-a-repository-With-git-fetch>> for details.
 
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
