From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC 5/6] send-email: Cleanup the usage text a bit
Date: Tue,  7 Apr 2009 16:25:21 -0500
Message-ID: <1239139522-24118-5-git-send-email-mfwitten@gmail.com>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-2-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-3-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-4-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 23:28:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrIpw-0002qz-U6
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 23:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760756AbZDGV00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 17:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760606AbZDGV00
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 17:26:26 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:55590 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759429AbZDGV0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 17:26:25 -0400
Received: by wa-out-1112.google.com with SMTP id j5so2183758wah.21
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3JTcYc7T2A+dDpBqc4yb2a5f1ZfGQh4HNSBdIyDyy/4=;
        b=VIEeCHN9jYGo+UJs4NsZ+Xq7vAYdaL6BhB3wQvxQK+gSa+wFObM7JKqU0hHPYFU060
         IhZU2HSizl0VvMJETxnaFA43FsCOPefQ4blOGZH/qfF2nMuzwx74ruArCnO7Th5LQ6hQ
         NG+QO7iPbSZ7oEBY+hMnyhDlNsoSewVuoXBJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kcpqvQK+EQ5pFY2KT06F4jrL8ODlTJRUgH3fM/x0D8MnVA8epivbLQATQpzalLUEMn
         14TBbzxcYLCoEe5LjDQLdXIyOPpKKhybcScML29aac5Wt8MaLVjPlTTCoKARoED9Pfsp
         /fHDmV261XhrqCGJI72c8Bqq0a9a8FXVAAl+g=
Received: by 10.114.76.8 with SMTP id y8mr288097waa.201.1239139584458;
        Tue, 07 Apr 2009 14:26:24 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-21.mpls.qwest.net [97.116.125.21])
        by mx.google.com with ESMTPS id j39sm7381340waf.28.2009.04.07.14.26.22
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 14:26:23 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.448.g61445.dirty
In-Reply-To: <1239139522-24118-4-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115992>

All lines should be < 80 characters.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-send-email.perl |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 481bf36..c3e3598 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -42,6 +42,9 @@ package main;
 
 
 sub usage {
+
+	# All printed lines should be less than 80 characters.
+
 	print <<EOT;
 git send-email [options] <file | directory | rev-list options >
 
@@ -52,7 +55,8 @@ git send-email [options] <file | directory | rev-list options >
     --bcc                   <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
-    --annotate                     * Review each patch that will be sent in an editor.
+    --annotate                     * Review each patch that will be sent in
+                                     an editor.
     --compose           opt <str>  * Open an editor for introduction.
 
   Sending:
@@ -69,8 +73,10 @@ git send-email [options] <file | directory | rev-list options >
   Automating:
     --identity              <str>  * Use the sendemail.<id> options.
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
-    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
-    --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses. Default on.
+    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body,
+                                     bodycc, all.
+    --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses.
+                                     Default on.
     --[no-]suppress-from           * Send to self. Default off.
     --[no-]chain-reply-to          * Chain In-Reply-To: fields. Default on.
     --[no-]thread                  * Use In-Reply-To: field. Default on.
@@ -81,8 +87,8 @@ git send-email [options] <file | directory | rev-list options >
     --quiet                        * Output one line of info per email.
     --dry-run                      * Don't actually send the emails.
     --[no-]validate                * Perform patch sanity checks. Default on.
-    --[no-]format-patch            * understand any non optional arguments as
-                                     `git format-patch` ones.
+    --[no-]format-patch            * Understand any non-optional arguments as
+                                     `git format-patch' arguments.
 
 EOT
 	exit(1);
-- 
1.6.2.2.448.g61445.dirty
