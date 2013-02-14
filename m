From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git.txt: update description of the configuration mechanism
Date: Thu, 14 Feb 2013 16:36:54 +0100
Message-ID: <1360856214-934-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 14 16:41:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U60w5-0008RC-FI
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 16:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934679Ab3BNPk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 10:40:58 -0500
Received: from mx2.imag.fr ([129.88.30.17]:57993 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934632Ab3BNPk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 10:40:57 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r1EFav9d025627
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Feb 2013 16:36:57 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U60rr-0007ms-2r; Thu, 14 Feb 2013 16:36:59 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U60rq-0000Fo-UU; Thu, 14 Feb 2013 16:36:59 +0100
X-Mailer: git-send-email 1.8.1.3.572.g35e1b60
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 14 Feb 2013 16:36:58 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1EFav9d025627
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1361461020.05438@xavLPu8rZD2Et9FunhWY4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216310>

The old Git version where it appeared is not useful only to historians,
not to normal users. Also, the text was mentioning only the per-repo
config file, so add a mention of ~/.gitconfig. Describing in details the
system-wide, XDG and all would be counter-productive here, so reword the
description of the link to git-config to make it clear that it is not
only a list of configuration options.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 0b681d9..e332947 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -535,10 +535,11 @@ include::cmds-purehelpers.txt[]
 Configuration Mechanism
 -----------------------
 
-Starting from 0.99.9 (actually mid 0.99.8.GIT), `.git/config` file
-is used to hold per-repository configuration options.  It is a
-simple text file modeled after `.ini` format familiar to some
-people.  Here is an example:
+Git uses a simple text file format modeled after `.ini` format
+familiar to some people to store its configuration. The `.git/config`
+file is used to hold per-repository configuration options, and
+per-user configuration can be stored in a `~/.gitconfig` file.
+Here is an example:
 
 ------------
 #
@@ -559,7 +560,7 @@ people.  Here is an example:
 
 Various commands read from the configuration file and adjust
 their operation accordingly.  See linkgit:git-config[1] for a
-list.
+list and more details about the configuration mechanism.
 
 
 Identifier Terminology
-- 
1.8.1.3.572.g35e1b60
