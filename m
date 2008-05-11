From: nathan spindel <nathans@gmail.com>
Subject: [PATCH] Documentation/git-instaweb.txt: Updated defaults to match my last two git-instaweb.sh changes
Date: Sat, 10 May 2008 22:26:05 -0700
Message-ID: <1210483565-12415-3-git-send-email-nathans@gmail.com>
References: <1210483565-12415-1-git-send-email-nathans@gmail.com>
 <1210483565-12415-2-git-send-email-nathans@gmail.com>
Cc: nathan spindel <nathans@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 11 07:27:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv45Z-0006JL-9N
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 07:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbYEKF0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 01:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbYEKF0P
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 01:26:15 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:25310 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbYEKF0L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 01:26:11 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1796178wfd.4
        for <git@vger.kernel.org>; Sat, 10 May 2008 22:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1fRHHydhe56Ds/Tzaciake/qknnegmgLzwLeoo3Si8o=;
        b=EpqTW+CKIYYCVGCLAIT3qT99xDfSCUBtk10G5xWD8dFeRHTPZjhZNQ5fWJHVVCcwEGnUAmHjP2BDf9LenJnDSCm+HCPxVUcoz4EdkpcNznUtlAdZXe19PnBnrI+6Sacg9UkLYNPsO0eZ/HQWlh2eUv8j8E8i89ZVl5pRJrCAEh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xr1L+FSbi4t0n7+GdfZF1bGHWe3JX38CKofMjPLND1UrTzAv8OfD0H2uUbK1NoFx8lZ7yo+Bi7qfZPx6Vrg0mCLVus8u0tcRGBmDKtXPX26PfzPJ69+oT1ttxNmzMdsnmt6rY35WPtpAcmMKJyZRwWRo3ouWEXdA1w4zJWGRT1M=
Received: by 10.142.47.6 with SMTP id u6mr2697444wfu.111.1210483570972;
        Sat, 10 May 2008 22:26:10 -0700 (PDT)
Received: from localhost ( [76.14.71.118])
        by mx.google.com with ESMTPS id 27sm14522494wff.7.2008.05.10.22.26.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 May 2008 22:26:10 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.179.g2fe4.dirty
In-Reply-To: <1210483565-12415-2-git-send-email-nathans@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81737>

Signed-off-by: nathan spindel <nathans@gmail.com>
---
 Documentation/git-instaweb.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index 51f1532..aae5334 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -28,11 +28,12 @@ OPTIONS
 	Command-line options may be specified here, and the
 	configuration file will be added at the end of the command-line.
 	Currently lighttpd, apache2 and webrick are supported.
-	(Default: lighttpd)
+	(Default: lighttpd if it exists, otherwise apache2)
 
 -m|--module-path::
 	The module path (only needed if httpd is Apache).
-	(Default: /usr/lib/apache2/modules)
+	(Default: /usr/lib/apache2/modules or /usr/libexec/apache2, 
+	whichever exists)
 
 -p|--port::
 	The port number to bind the httpd to.  (Default: 1234)
-- 
1.5.5.1.179.g2fe4.dirty
