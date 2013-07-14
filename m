From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: [PATCH 4/6] Documentation: Update manpage for pre-commit hook
Date: Sun, 14 Jul 2013 18:21:17 +0200
Message-ID: <1373818879-1698-5-git-send-email-richih.mailinglist@gmail.com>
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
	id 1UyP3P-0006zD-6u
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 18:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756Ab3GNQVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 12:21:40 -0400
Received: from mail-bk0-f51.google.com ([209.85.214.51]:39482 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab3GNQV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 12:21:27 -0400
Received: by mail-bk0-f51.google.com with SMTP id ji1so4298050bkc.38
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Z95VfOn3IWnNG3buj4sgR4797ZGbTIiWX1OPNHxbfA4=;
        b=P/RZ55m0NCIcLiQkFKV7kJJWTo0ECO8aYZ+7v34dm//Xkr9JV9FqJ4cI31ltdU+Hc9
         d6xxqDWeISDpK9vmuN0W+7IG2i/uuD3eMzkp5caGcD8ulFynTWGfFkZfPxK85ZwAqIQg
         jdDCIBvj3GeROBNdNWsZp4HklNacQvFcSo02GJrZBASrdNvcU7ABuuXl314ynbetZ8YM
         5vUxY9Bc//KpU301bZ8fCkEGzbC1FEIAc8gKNaxu71ZZx2j3l5CIWKIdMRM9aaPWwNGb
         irFLa0KgjZomsEmmPySOZP2d4+lczFmYf0/h3arQIOSiyAqQJnkqSoxBKsQgoLAcvNuW
         LUHQ==
X-Received: by 10.204.168.72 with SMTP id t8mr7056021bky.161.1373818886666;
        Sun, 14 Jul 2013 09:21:26 -0700 (PDT)
Received: from rockhopper.fritz.box (p5499AB9B.dip0.t-ipconnect.de. [84.153.171.155])
        by mx.google.com with ESMTPSA id ct12sm496595bkb.12.2013.07.14.09.21.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 09:21:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230376>

Verbatim copy of 4b8234b2693af634a77ea059331d1658e070f6d7 in original
patch series from 2013-06-10.

Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
---
 Documentation/githooks.txt |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b9003fe..1276730 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -80,7 +80,8 @@ causes the 'git commit' to abort.
 
 The default 'pre-commit' hook, when enabled, catches introduction
 of lines with trailing whitespaces and aborts the commit when
-such a line is found.
+such a line is found. It will also prevent addition of non-ASCII
+file names.
 
 All the 'git commit' hooks are invoked with the environment
 variable `GIT_EDITOR=:` if the command will not bring up an editor
-- 
1.7.10.4
