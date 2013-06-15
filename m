From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 2/5] stash doc: document short form -p in synopsis
Date: Sat, 15 Jun 2013 18:43:23 +0530
Message-ID: <1371302006-29775-3-git-send-email-artagnon@gmail.com>
References: <1371302006-29775-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 15 15:15:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnqKb-0007oc-TD
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 15:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428Ab3FONPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 09:15:30 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:49705 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754409Ab3FONPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 09:15:25 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so1406630pdj.28
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=99FPX4fetC2vjAapqrWO6W5D+wt8OlTyuGHOPP1toOw=;
        b=Z+Yps0NhuttZTgctsu6GIbSoi+sVd4zOfRwIHbGP0eBFEJExTg99qjHxTt5U44riV+
         b2Ml/Dj33qOH/GaZmasTb5soGjPI+UaqfzYzkU4ioCzpnhqsULy2tHWRvd8dGZ7V78jt
         PNljN1euEZGP0hbJJCiGatN973m7wrTxnYIOzAIfqIteY3f5L4v3B6tzQBu+Idp07Qao
         3HtFcstD8QVdXjDxxuYQ6Gu8uHvrNK5BzAJ7Tb4oT2F8nNNeQyJRKdVbefBh28S9YrKC
         uF7uxw2n1hK7C1I9r7nfGYkZ2gk73vS5wcT2d2h2GIRgcBqB9t4fhPyW6Q10HqnMWuh4
         ZBDQ==
X-Received: by 10.66.119.35 with SMTP id kr3mr6336663pab.149.1371302124860;
        Sat, 15 Jun 2013 06:15:24 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id pe9sm6239122pbc.35.2013.06.15.06.15.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Jun 2013 06:15:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.441.gd7d6b72.dirty
In-Reply-To: <1371302006-29775-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227954>

'git stash save' can take -p, the short form of --patch, as an option.
Document this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-stash.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index cb0c1a6..632d4fb 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
+'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' clear
 'git stash' create [<message>]
-- 
1.8.3.1.441.gd7d6b72.dirty
