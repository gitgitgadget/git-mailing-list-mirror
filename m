From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: [PATCH 2/6] templates: Reformat pre-commit hook's message
Date: Sun, 14 Jul 2013 18:21:15 +0200
Message-ID: <1373818879-1698-3-git-send-email-richih.mailinglist@gmail.com>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
 <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
Cc: Richard Hartmann <richih.mailinglist@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 18:21:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyP3O-0006zD-LC
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 18:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab3GNQVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 12:21:37 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42235 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab3GNQV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 12:21:28 -0400
Received: by mail-bk0-f46.google.com with SMTP id na10so4291964bkb.19
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7X1QPEUtkkYFcqwfeOLMYgAVGSnRRmLj1BfMvu17HJ0=;
        b=Qmf1uRCibzVRwW0xc50ZyxftgFkfUlpJd/rqAUMNg0SpUsxK2N8OmeSLpV/M/yZ7h2
         +j+0rhY3G4ORw/2KHBHCgMl2TTXp0wc1MuOgsY1VF7dCNtNu5T/ePcBOUAAwC89eMtCr
         xmvE3MLqHLeYyB/6RPBJ+wJ5mEuNkn2P1TNnRrOdbApNPO+AI/7MRK5ft9pQvzKswUop
         QTCmofxksY87HaPZJbb1YvUdtH4JAp8IJeDWJ7KKY/GjSKFkCljCOKehZ5AmjoUSo7rT
         bCYrrpkBWYcZxzT3gxm7d9QhyiN1AqZ2jGAVeC3DfriR7J4mu0SjozwnZvjic9r8GuoL
         lXoA==
X-Received: by 10.204.186.141 with SMTP id cs13mr7675454bkb.34.1373818884397;
        Sun, 14 Jul 2013 09:21:24 -0700 (PDT)
Received: from rockhopper.fritz.box (p5499AB9B.dip0.t-ipconnect.de. [84.153.171.155])
        by mx.google.com with ESMTPSA id ct12sm496595bkb.12.2013.07.14.09.21.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 09:21:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230375>

Now that we're using heredoc, the message can span the full 80 chars.

Verbatim copy of 634709b489bb3db79f59127fd6bf79c5fd9b5ddf in original
patch series from 2013-06-10.

Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
---
 templates/hooks--pre-commit.sample |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 889967c..e09cf89 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -34,13 +34,11 @@ then
 	cat <<-EOF
 Error: Attempt to add a non-ascii file name.
 
-This can cause problems if you want to work
-with people on other platforms.
+This can cause problems if you want to work with people on other platforms.
 
 To be portable it is advisable to rename the file.
 
-If you know what you are doing you can disable this
-check using:
+If you know what you are doing you can disable this check using:
 
   git config hooks.allownonascii true
 EOF
-- 
1.7.10.4
