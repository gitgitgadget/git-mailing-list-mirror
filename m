From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/7] revisions.txt: clarify the .. and ... syntax
Date: Sun, 21 Apr 2013 14:20:48 +0530
Message-ID: <1366534252-12099-4-git-send-email-artagnon@gmail.com>
References: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:51:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpzS-0008Hv-8c
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684Ab3DUIvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:51:11 -0400
Received: from mail-da0-f43.google.com ([209.85.210.43]:39021 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab3DUIvF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:51:05 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so2609208dak.30
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=n5BJ5JZ9WTWJoZbJqK8LttVk8CuOaDpDqHwYSHut2k8=;
        b=hRlU+WP8DMWPkJ+NaCoO9ZMThGoLCZuK5GMHb6Tm9udFg2ivxLFwLx0r6i0XIrFT5m
         FLni9Z6lnHru6GUcxZGzxmjYLhg4BSmdSkii+W7WoBRSYket53wy+FwE20yzYfwHuWHd
         DIouFxGhhCOejzDM9QEfHmD56+JpeIbPV4n89QG22kXTtMFevf63l8Ra3EiTv7VI63t3
         D10ssHwwFtmrb2+D7qz6seePClBIX2v/3KQYK4xzfK8+B7ZPNcf4iZCcOBj7FSHy87NG
         quwJf+qGzHNGp6JRcU178CSzvwlYNyzFqxh9PYEZ/RjKcYGDzZmITVqnU24thVSr1wAY
         hJlA==
X-Received: by 10.68.251.194 with SMTP id zm2mr26141010pbc.81.1366534265029;
        Sun, 21 Apr 2013 01:51:05 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id mm9sm20241909pbc.43.2013.04.21.01.51.03
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 01:51:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366534252-12099-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221930>

In <rev1>..<rev2> and <rev1>...<rev2>, if either <rev1> or <rev2> is
omitted, it defaults to 'HEAD'.  Add this detail to the document.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/revisions.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 8855b1a..0a23129 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -244,11 +244,13 @@ To summarize:
 
 '<rev1>..<rev2>'::
 	Include commits that are reachable from <rev2> but exclude
-	those that are reachable from <rev1>.
+	those that are reachable from <rev1>.  When either <rev1> or
+	<rev2> is omitted, it defaults to 'HEAD'.
 
 '<rev1>\...<rev2>'::
 	Include commits that are reachable from either <rev1> or
-	<rev2> but exclude those that are reachable from both.
+	<rev2> but exclude those that are reachable from both.  When
+	either <rev1> or <rev2> is omitted, it defaults to 'HEAD'.
 
 '<rev>{caret}@', e.g. 'HEAD{caret}@'::
   A suffix '{caret}' followed by an at sign is the same as listing
-- 
1.8.2.1.501.gd2949c7
