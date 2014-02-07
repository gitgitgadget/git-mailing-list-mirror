From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH] gitweb: Added syntax highlight support for golang
Date: Sat,  8 Feb 2014 02:40:41 +0530
Message-ID: <1391807441-23049-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 07 22:11:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBshR-0000jf-Ls
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 22:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbaBGVK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 16:10:57 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:65496 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbaBGVK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 16:10:56 -0500
Received: by mail-pa0-f42.google.com with SMTP id kl14so3686142pab.29
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 13:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=YBEOynphxV4rfmtFhyNYSe6fREjO2+ixrD1G9E/npdM=;
        b=g0AS+w0u/AHP/4QsuKwKJq+gy+jvjUExXHmSTaR8534hO4XmTCeQBLdjtCOKgw99jv
         0z7LTwrlCmySsz6bC+6YJXMRgM2B/qJPWtf1EGwQBEQGFJ82AG5MgQ5IKkbtrgjfuTZg
         niNIpQpUmny+Jq4fJD+6UTAxJCjqdZjlmWRypKJ/fzYTxMCf65wujdHV9HnfzVFQT+6J
         ZNNYBfTijMwnZOYKZ2FxaLPsvhxnGyF9OeEbWPsdzfm0riJEF5vHoDAuw/rgye4unWco
         tWbjK/j+fx43A9pwWtk8Kl6kn2NpF6ALWGpc3wNffCqXY/u48UKGqsXK/Zj5j8ksELyM
         +5aw==
X-Received: by 10.67.4.169 with SMTP id cf9mr10379880pad.45.1391807455373;
        Fri, 07 Feb 2014 13:10:55 -0800 (PST)
Received: from localhost.localdomain ([119.235.50.12])
        by mx.google.com with ESMTPSA id nu10sm16781190pbb.16.2014.02.07.13.10.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2014 13:10:54 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241800>

Golang is quickly becoming one of the major programming languages.

This change switches on golang syntax highlight support by default
in gitweb rather than asking the users to do it using config files.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bf7fd67..aa6fcfd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -273,7 +273,7 @@ our %highlight_basename = (
 our %highlight_ext = (
 	# main extensions, defining name of syntax;
 	# see files in /usr/share/highlight/langDefs/ directory
-	(map { $_ => $_ } qw(py rb java css js tex bib xml awk bat ini spec tcl sql)),
+	(map { $_ => $_ } qw(py rb java go css js tex bib xml awk bat ini spec tcl sql)),
 	# alternate extensions, see /etc/highlight/filetypes.conf
 	(map { $_ => 'c'   } qw(c h)),
 	(map { $_ => 'sh'  } qw(sh bash zsh ksh)),
-- 
1.7.10.4
