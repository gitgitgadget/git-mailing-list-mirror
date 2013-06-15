From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 1/5] stash doc: add a warning about using create
Date: Sat, 15 Jun 2013 18:43:22 +0530
Message-ID: <1371302006-29775-2-git-send-email-artagnon@gmail.com>
References: <1371302006-29775-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 15 15:15:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnqKb-0007oc-Cr
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 15:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415Ab3FONPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 09:15:25 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:36977 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401Ab3FONPX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 09:15:23 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so1389700pbc.29
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 06:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jDUurUOYdZovDE1dwH6M/oDBs3PY0s5iGB5wgRR3VuQ=;
        b=yXkb15n8ruXGoJIPNRFuBC1VhYUcn46bcqwZ0OseTQqaGT4dFh5QmXZcycTlAnmTDr
         cVOS9sjvbVuB6/GtSuhQF2M+sKHamNeXQHhIFC2CWlv4LebK43CPCmKmMXRgFmmUThIQ
         4KZ7NCNoObrBOElFbhlbG8lbLJvpjjHwk//4ebYLjG8YLABmxM80omEais+D8RA6DLXd
         blcug+mTF923T2oFmo+Xi+Gu2swylaNp3NhtbozCneeeXmShGI1JyZTkp/6wyqM4Szu/
         J/iTQsp9FozSF8A6+Hd5CBuuK5oAL1K5g1O8dJchcTKD/ksfZbpQ8m6mizXnxRR3fjYK
         LHzA==
X-Received: by 10.68.222.7 with SMTP id qi7mr6325073pbc.7.1371302122516;
        Sat, 15 Jun 2013 06:15:22 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id pe9sm6239122pbc.35.2013.06.15.06.15.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Jun 2013 06:15:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.441.gd7d6b72.dirty
In-Reply-To: <1371302006-29775-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227953>

Add a note saying that the user probably wants "save" in the create
description.  While at it, document that it can optionally take a
message in the synopsis.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-stash.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 711ffe1..cb0c1a6 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
 'git stash' clear
-'git stash' create
+'git stash' create [<message>]
 
 DESCRIPTION
 -----------
@@ -151,6 +151,8 @@ create::
 
 	Create a stash (which is a regular commit object) and return its
 	object name, without storing it anywhere in the ref namespace.
+	This is intended to be useful for scripts.  It is probably not
+	the command you want to use; see "save" above.
 
 
 DISCUSSION
-- 
1.8.3.1.441.gd7d6b72.dirty
