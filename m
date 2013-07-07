From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] name-rev doc: rewrite --stdin paragraph
Date: Sun,  7 Jul 2013 18:13:16 +0530
Message-ID: <1373200996-9753-4-git-send-email-artagnon@gmail.com>
References: <1373200996-9753-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 07 14:47:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvoNG-0007fW-Rh
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 14:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab3GGMr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 08:47:27 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:48720 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab3GGMr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 08:47:26 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so3392433pbc.40
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZDQGxR5ixgkn8RrYryitMhni1qUC/LEdwMnygq3b2kk=;
        b=oX3Nz3ahkpDVNsbd0hW38NO6dKkI29lUWz9/4Z72qCp9QH1TBBh1RubcSey9cxG56z
         J0jnNLm8PVIwsOA2KOQDnD/n65o21mjc3jISym/8PprPp0m0qbAKjm5xITja5rcs/3z0
         XKM/NfIwHg8yyHM4ecnTUFy3N3jgZZjM+5JBcHqpmpzNI5URgp0LsAXT5pNeKsXt1NaL
         yDBp8VXMVCpf1uskQzIzEpiYQf+JsKPuWk+3QrZ/FM1dfhN+IdEyMyKgtZ4I7f1PYQB6
         FWIHOD9sEymFIF/13YuRPfIRVIDljlJZ7XHQAIFgEnB2Kp63kQUfYjNCu60bqRgqXe9B
         z/ug==
X-Received: by 10.68.196.231 with SMTP id ip7mr17020425pbc.61.1373201245674;
        Sun, 07 Jul 2013 05:47:25 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id eq5sm17024014pbc.15.2013.07.07.05.47.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 05:47:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.737.gcbc076a.dirty
In-Reply-To: <1373200996-9753-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229770>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-name-rev.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 7cde4b3..94bded8 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -32,8 +32,10 @@ OPTIONS
 	List all commits reachable from all refs
 
 --stdin::
-	Read from stdin, append "(<rev_name>)" to all sha1's of nameable
-	commits, and pass to stdout
+	Transform stdin by substituting all the 40-character SHA-1
+	hexes (say $hex) with "$hex ($rev_name)".  When used with
+	--name-only, substitute with "$rev_name", omitting $hex
+	altogether.  Intended for the scripter's use.
 
 --name-only::
 	Instead of printing both the SHA-1 and the name, print only
-- 
1.8.3.2.737.gcbc076a.dirty
