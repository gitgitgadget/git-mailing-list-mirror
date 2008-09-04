From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Mention the fact that 'git annotate' is only for backward compatibility.
Date: Thu,  4 Sep 2008 15:03:41 +0200
Message-ID: <1220533421-26057-1-git-send-email-Matthieu.Moy@imag.fr>
References: <20080904123046.GX10544@machine.or.cz>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 15:07:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbEYk-0004t9-UA
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 15:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbYIDNGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 09:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbYIDNGc
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 09:06:32 -0400
Received: from imag.imag.fr ([129.88.30.1]:32787 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645AbYIDNGb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 09:06:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m84D3nuM011850
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 4 Sep 2008 15:03:50 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KbEUv-0000xX-5X; Thu, 04 Sep 2008 15:03:41 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KbEUv-0006me-3H; Thu, 04 Sep 2008 15:03:41 +0200
X-Mailer: git-send-email 1.6.0.7.g161c
In-Reply-To: <20080904123046.GX10544@machine.or.cz>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 04 Sep 2008 15:03:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94929>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-annotate.txt         |    4 ++++
 command-list.txt                       |    2 +-
 contrib/completion/git-completion.bash |    1 +
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.txt
index 8b6b56a..76f2b8c 100644
--- a/Documentation/git-annotate.txt
+++ b/Documentation/git-annotate.txt
@@ -14,6 +14,10 @@ DESCRIPTION
 Annotates each line in the given file with information from the commit
 which introduced the line. Optionally annotate from a given revision.
 
+This command exists for backward compatibility, as an alias for 'git
+blame -c'. For regular use, you should now use linkgit:git-blame[1]
+instead.
+
 OPTIONS
 -------
 include::blame-options.txt[]
diff --git a/command-list.txt b/command-list.txt
index 3583a33..03d1023 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -2,7 +2,7 @@
 # command name				category [deprecated] [common]
 git-add                                 mainporcelain common
 git-am                                  mainporcelain
-git-annotate                            ancillaryinterrogators
+git-annotate                            ancillaryinterrogators deprecated
 git-apply                               plumbingmanipulators
 git-archimport                          foreignscminterface
 git-archive                             mainporcelain
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4f64f8a..6630033 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -380,6 +380,7 @@ __git_porcelain_commands ()
 	do
 		case $i in
 		*--*)             : helper pattern;;
+		annotate)         : deprecated;;
 		applymbox)        : ask gittus;;
 		applypatch)       : ask gittus;;
 		archimport)       : import;;
-- 
1.6.0.7.g161c
