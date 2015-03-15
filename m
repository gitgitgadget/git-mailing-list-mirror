From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 2/3 v2] Documentation/git-add.txt: describe --exclude option
Date: Mon, 16 Mar 2015 01:06:56 +0600
Message-ID: <1426446416-5753-1-git-send-email-kuleshovmail@gmail.com>
References: <1426446383-5264-1-git-send-email-kuleshovmail@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 20:07:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXDsS-0003QH-PO
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 20:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbbCOTHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 15:07:04 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:35874 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbbCOTHD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 15:07:03 -0400
Received: by lamx15 with SMTP id x15so24057117lam.3
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 12:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eKk9r0tAp7FfTW9E/MTAX1VhTkrpiXn2RR5NyKxe35A=;
        b=wqMsMRhDP6gECElpSIvzER5WiJJRfx32fW8CQGU9YXz/TaBAHjOqj3Ry3iLlVF9uI/
         qryRaqpQgTiX0Y01boGp28tqCP+x15RwcWPrHv+fyOr3OQRDDdmeJNG302VpoYSFkypy
         7sbiy59JfexNcapvLLporWkEwLTW6jIcWaU5HPQdyVc0dKqu6kA1rfeKJvscQKMJpTz0
         z9eA/z+HznhWgCkk4YrN+dQB41xmn1lu+GXGVFu1gihODmJ0Y0597VwVnDfD1s1+rPkH
         aFocVIEUujN5qsdDH5kLi6OdqzzUfT2X3+0IZr+TBrQzyUHM0NoPopPsodQB8tZuxVcj
         os1w==
X-Received: by 10.112.26.209 with SMTP id n17mr46648029lbg.84.1426446421253;
        Sun, 15 Mar 2015 12:07:01 -0700 (PDT)
Received: from localhost.localdomain ([95.56.108.218])
        by mx.google.com with ESMTPSA id wt7sm1721806lbb.24.2015.03.15.12.06.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Mar 2015 12:07:00 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.472.g20ceeac.dirty
In-Reply-To: <1426446383-5264-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265513>

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/git-add.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index f2eb907..fee97ed 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
-	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
+	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]] [--exclude=<pattern>]
 	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]
 	  [--] [<pathspec>...]
 
@@ -164,6 +164,10 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	be ignored, no matter if they are already present in the work
 	tree or not.
 
+--exclude=<pattern>::
+	Also ignore files matching <pattern>, a .gitignore-like
+	pattern. Option can be used multiply times.
+
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
-- 
2.3.3.472.g20ceeac.dirty
