From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: [PATCH 3/6] templates: Fix spelling in pre-commit hook
Date: Sun, 14 Jul 2013 18:21:16 +0200
Message-ID: <1373818879-1698-4-git-send-email-richih.mailinglist@gmail.com>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
 <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
Cc: Richard Hartmann <richih.mailinglist@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 18:21:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyP3O-0006zD-3P
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 18:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729Ab3GNQV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 12:21:28 -0400
Received: from mail-bk0-f51.google.com ([209.85.214.51]:40924 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab3GNQV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 12:21:27 -0400
Received: by mail-bk0-f51.google.com with SMTP id ji1so4298048bkc.38
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 09:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/4mqkwnHykKmRGpvRO7Yam28grf/HOvb/8cSza4Ln8Y=;
        b=BtjkgC/7QTyrIqBIkZOrgoUMZULFNFfc/28SrA852dD7eWz88qg66C/EukcWl6nQhW
         84IscWfStMWdSSrCxM52cfQZKuNSCzJD5oW0cN8UuTukvOzouOwIKcxfsOKRCu1GXOhe
         uSqqGkBoxugFUud3Dv3VbTDEh6+4AempRc29l3BpexoNTLbkqVvBbXk1cb44EZR7hC/6
         w401vdsKtfndqt9LY2LvcPkeGr4V06P3VwFIegNcm7wYL90B6LxIZpXL5OiXL2RK7N1L
         +SclYBEd772/pvhdaLJR/gb4bufGG4uKKboXlbEiqFBn72cshXiiKACGvOuY5z0Op/Gg
         oNDA==
X-Received: by 10.204.231.76 with SMTP id jp12mr7214283bkb.48.1373818885619;
        Sun, 14 Jul 2013 09:21:25 -0700 (PDT)
Received: from rockhopper.fritz.box (p5499AB9B.dip0.t-ipconnect.de. [84.153.171.155])
        by mx.google.com with ESMTPSA id ct12sm496595bkb.12.2013.07.14.09.21.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 09:21:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230374>

Based on 0b9b01276553de8097442c3c996b7a49367dd234 in original patch
series.

Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
---
 templates/hooks--pre-commit.sample |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index e09cf89..78baef6 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -15,13 +15,13 @@ else
 	against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
 fi
 
-# If you want to allow non-ascii filenames set this variable to true.
+# If you want to allow non-ASCII filenames set this variable to true.
 allownonascii=$(git config hooks.allownonascii)
 
 # Redirect output to stderr.
 exec 1>&2
 
-# Cross platform projects tend to avoid non-ascii filenames; prevent
+# Cross platform projects tend to avoid non-ASCII filenames; prevent
 # them from being added to the repository. We exploit the fact that the
 # printable range starts at the space character and ends with tilde.
 if [ "$allownonascii" != "true" ] &&
@@ -32,7 +32,7 @@ if [ "$allownonascii" != "true" ] &&
 	  LC_ALL=C tr -d '[ -~]\0' | wc -c) != 0
 then
 	cat <<-EOF
-Error: Attempt to add a non-ascii file name.
+Error: Attempt to add a non-ASCII file name.
 
 This can cause problems if you want to work with people on other platforms.
 
-- 
1.7.10.4
