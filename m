From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: [PATCH] worktree: usage: denote <branch> as optional with 'add'
Date: Mon, 19 Oct 2015 10:14:53 +0530
Message-ID: <1445229893-4179-1-git-send-email-tigerkid001@gmail.com>
References: <CAPig+cRXq9qonwPpWQdnrFkJgQQW0zDokXQhSvw5n07d7OpqdQ@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 06:45:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo2Ju-0002zx-1r
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 06:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbbJSEpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 00:45:08 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35850 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbbJSEpH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 00:45:07 -0400
Received: by pacfv9 with SMTP id fv9so82456149pac.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 21:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=gf+MfCRdz1dK2A04TKiq0A63vYoRx2J7DDnB5F60iys=;
        b=AngChdOifuem3f3uoWeE7dsA69Svt3+eFVow2cXfWWM3wbfHBejm71XZkH8qw3yJHb
         iN1usuwKQzgaCZ7Ip7824FxZDA3zw5g5EpTW7HSu6my5xEUBxmqWXhlihDx6H3w3epOV
         nZk8tdxkdrUrVL7Fir8s/hTu86KI+h+wSX0MU2fuzyh8UJuO4HR5I4rORi7kny7thaS9
         wA8R4IKb0oHQuDOro4Em/m4AQ0e1xUq2tfvX7Iig6zFXHgdtQwNr8bb1+kFX5DpM1885
         GxxxE0sMCt/QGBdKowcpj6ZfDVkhi+WO7Hw7lPa+LzdxskT0kosxnhgoSj2tkfost3XZ
         UTCw==
X-Received: by 10.66.90.233 with SMTP id bz9mr32016475pab.14.1445229906764;
        Sun, 18 Oct 2015 21:45:06 -0700 (PDT)
Received: from localhost.localdomain ([182.68.245.161])
        by smtp.gmail.com with ESMTPSA id tj2sm33861443pab.4.2015.10.18.21.45.05
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Oct 2015 21:45:06 -0700 (PDT)
X-Mailer: git-send-email 2.6.2
In-Reply-To: <CAPig+cRXq9qonwPpWQdnrFkJgQQW0zDokXQhSvw5n07d7OpqdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279827>

Although 1eb07d8 (worktree: add: auto-vivify new branch when
<branch> is omitted, 2015-07-06) updated the documentation when
<branch> became optional, it neglected to update the in-code
usage message. Fix this oversight.

Reported-by: ch3cooli@gmail.com
Signed-off-by: Sidhant Sharma <tigerkid001@gmail.com>
---
 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 71bb770..33d2d37 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -10,7 +10,7 @@
 #include "refs.h"

 static const char * const worktree_usage[] = {
-	N_("git worktree add [<options>] <path> <branch>"),
+	N_("git worktree add [<options>] <path> [<branch>]"),
 	N_("git worktree prune [<options>]"),
 	NULL
 };
--
2.6.2
