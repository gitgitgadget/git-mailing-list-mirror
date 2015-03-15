From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 2/3] Documentation/git-add.txt: describe --exclude option
Date: Sun, 15 Mar 2015 19:50:25 +0600
Message-ID: <1426427425-23309-1-git-send-email-kuleshovmail@gmail.com>
References: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 14:50:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YX8w9-000216-M8
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 14:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbbCONud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 09:50:33 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33572 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbbCONuc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 09:50:32 -0400
Received: by lbbzq9 with SMTP id zq9so16110150lbb.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 06:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WFI3tqnEVoxJ/H85rcfr3vss98rLkxqTKTsL/b1W738=;
        b=rGo+hX/MWtPJ4McFTJ+F1PY1Ef68DVBEmypgdanvC6BcP9Hmta1OIy+kJeCYMg932v
         0lS8vRq5kb3TjYpO1y7Lfu7wIy2VWi0mjJhqQEDIVnO8u0tlZjNG/IkHOz9L7cvdfHgJ
         50ZpPNwfwFy1jhXo2var6ijn7bhW8ADXb1yyWuMXD2S13zl/A6Pv/aUCota19M9xrDHE
         XAJEhbOS01V37nzaAvFJB8yDqZwulIjgL5uhOb3JJp7/t+yWEYIodHnoH6xN8ChLQEoe
         f/y6IgwuLj0y7g7gBZRoI3JOzpY/rZLtTKaKyH3yckKn8015ymVaHr1yw7AKNtYY/5xX
         bHlA==
X-Received: by 10.112.212.106 with SMTP id nj10mr32174237lbc.36.1426427430840;
        Sun, 15 Mar 2015 06:50:30 -0700 (PDT)
Received: from localhost.localdomain ([95.56.108.218])
        by mx.google.com with ESMTPSA id n12sm1571566lbg.31.2015.03.15.06.50.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Mar 2015 06:50:30 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.472.g20ceeac
In-Reply-To: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265494>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/git-add.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index f2eb907..4bc156a 100644
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
+	Do not add files to the index in addition which are found in
+	the .gitignore.
+
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
-- 
2.3.3.472.g20ceeac
