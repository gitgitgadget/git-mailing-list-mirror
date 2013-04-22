From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/7] revisions.txt: clarify the .. and ... syntax
Date: Mon, 22 Apr 2013 11:00:26 +0530
Message-ID: <1366608631-21734-3-git-send-email-artagnon@gmail.com>
References: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 07:30:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU9L2-0005j7-2T
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 07:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab3DVFal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 01:30:41 -0400
Received: from mail-da0-f42.google.com ([209.85.210.42]:47484 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3DVFak (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 01:30:40 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so1090484dad.29
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 22:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=n5BJ5JZ9WTWJoZbJqK8LttVk8CuOaDpDqHwYSHut2k8=;
        b=ihI8DhYeo0AfZCK2v8mgPVqnk0rH8y6nHo11pN29RgIDOheTWRkuxeVIc0Qnpq834f
         2DhhhDD6nfv+sUyZmhdlEQ1Z6x5FaOkK6C4vyLVW/yeJP7em9NKcBYj+3Ggg8EruGPmJ
         FxHmAltLqYMz+kYFJnuG++4LNhDPXlW+vN55wj/CH55nksauszQeayVb72tzLuEC72Kv
         vkrFvD21CWOa1GYaOT1YklGKfbd3Lq1KWr7C5GysRcp+ZTHd3JtPL+iUkQm1+HPgjBRL
         9pIiOcJf2Gy3oxBIzt3NiPXoWKchB4d0k4g3i04n9OsrM1YZ332nC5lxC2510FqbN1eY
         zLAw==
X-Received: by 10.66.248.105 with SMTP id yl9mr10686352pac.159.1366608640162;
        Sun, 21 Apr 2013 22:30:40 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id em2sm11144653pbb.0.2013.04.21.22.30.38
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 22:30:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.501.gd2949c7
In-Reply-To: <1366608631-21734-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221993>

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
