From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 4/4] contrib/mw-to-git/t/install-wiki.sh: use a lowercase "usage:" string
Date: Sun, 24 Feb 2013 14:48:41 -0800
Message-ID: <1361746121-56921-4-git-send-email-davvid@gmail.com>
References: <1361746121-56921-1-git-send-email-davvid@gmail.com>
 <1361746121-56921-2-git-send-email-davvid@gmail.com>
 <1361746121-56921-3-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:49:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9kNz-0001sp-84
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 23:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759406Ab3BXWs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 17:48:58 -0500
Received: from mail-da0-f48.google.com ([209.85.210.48]:53289 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759109Ab3BXWsq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 17:48:46 -0500
Received: by mail-da0-f48.google.com with SMTP id w4so1165246dam.21
        for <git@vger.kernel.org>; Sun, 24 Feb 2013 14:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=PFvEQ5Mseba34clgW+5NfL9c75NfMwtuOnZzuMhr46s=;
        b=aapP285U53BRpKHU2pYfbxToC73WIBgTwFPgsvW++tMmrQlw6c+tqWXDF0DEzYRrIf
         gJ6/0UL9WSjrjxWFTiIhVmmN+9Upyr8jAhwo95egFL4hw2ox9KyD268wRdpDumRPLyF+
         R4a/APRUKrjn/YgMT7Stcb1mOuJraL56iGyqEGIWk0HfqEhe/NoOMiHHlvbOvdYZ11YA
         6GgeQ+hdiw7chq5Pvzk6536lH1SCF67peYr4kGSZuQHpf8mDLK6gtesZ3ce183XU6wRv
         g/2YXLyVLZ/w+XRdyHwRu+vU7VKJIUZaEROloZCVGzvEelOwTMW02wVS0vjIY5EJ1o/V
         RooQ==
X-Received: by 10.68.211.225 with SMTP id nf1mr14720897pbc.104.1361746125207;
        Sun, 24 Feb 2013 14:48:45 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id kb3sm10427967pbc.21.2013.02.24.14.48.42
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Feb 2013 14:48:44 -0800 (PST)
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
In-Reply-To: <1361746121-56921-3-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217017>

Make the usage string consistent with Git.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/mw-to-git/t/install-wiki.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/t/install-wiki.sh b/contrib/mw-to-git/t/install-wiki.sh
index c6d6fa3..70a53f6 100755
--- a/contrib/mw-to-git/t/install-wiki.sh
+++ b/contrib/mw-to-git/t/install-wiki.sh
@@ -15,7 +15,7 @@ fi
 
 . "$WIKI_TEST_DIR"/test-gitmw-lib.sh
 usage () {
-	echo "Usage: "
+	echo "usage: "
 	echo "	./install-wiki.sh <install | delete | --help>"
 	echo "		install | -i :	Install a wiki on your computer."
 	echo "		delete | -d : Delete the wiki and all its pages and "
-- 
1.7.12.4 (Apple Git-37)
