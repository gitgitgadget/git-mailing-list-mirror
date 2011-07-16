From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH] Documentation/Notes: Remove 'footnote:' warning
Date: Sun, 17 Jul 2011 04:00:20 +0530
Message-ID: <1310855420-21183-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 00:30:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiDNe-0006iu-N5
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 00:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab1GPWad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 18:30:33 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50830 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab1GPWad (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 18:30:33 -0400
Received: by pvg12 with SMTP id 12so1985970pvg.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 15:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=f5g8S7Ah9DzP9bYJhUgi2f3r0NOLEse0rXrYLMpVt2Y=;
        b=NuA+AnC4fyFQ6RqJSd9VxkCMg95PpDgmaGmOCxulY8LYqeTmacdtqKti5A+flgdpzZ
         uuT7VColJUybrBvlXiirDHqPBhKyoUfnBMpgiYZZ1OgKBSxhpxoCgUm8iYF7nsupwdkK
         eWbYCC1zsMEQOx0JSBQvKL8yH8nqIes3xQG5s=
Received: by 10.68.65.198 with SMTP id z6mr3129599pbs.218.1310855432827;
        Sat, 16 Jul 2011 15:30:32 -0700 (PDT)
Received: from localhost.localdomain ([203.199.213.3])
        by mx.google.com with ESMTPS id d3sm1476219pbh.37.2011.07.16.15.30.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 15:30:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.485.gad3dc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177288>

Remove 'footnote:' from git-notes.txt which is responsible
for the warnings surfacing during the generation of git
documentation.
---
 Documentation/git-notes.txt |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 6a187f2..2a18894 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -210,10 +210,11 @@ Commit notes are blobs containing extra information about an object
 are taken from notes refs.  A notes ref is usually a branch which
 contains "files" whose paths are the object names for the objects
 they describe, with some directory separators included for performance
-reasons footnote:[Permitted pathnames have the form
-'ab'`/`'cd'`/`'ef'`/`'...'`/`'abcdef...': a sequence of directory
-names of two hexadecimal digits each followed by a filename with the
-rest of the object ID.].
+reasons.
+
+Permitted pathnames have the form 'ab'`/`'cd'`/`'ef'`/`'...'`/`'abcdef...':
+a sequence of directory names of two hexadecimal digits each
+followed by a filename with the rest of the object ID.
 
 Every notes change creates a new commit at the specified notes ref.
 You can therefore inspect the history of the notes by invoking, e.g.,
-- 
1.7.6.485.gad3dc
