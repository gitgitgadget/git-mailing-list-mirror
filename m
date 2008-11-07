From: "Abhijit Bhopatkar" <bain@devslashzero.com>
Subject: [PATCH] Documentation: Mention that 'bisect' is reserved branch name
Date: Fri, 7 Nov 2008 15:31:54 +0530
Message-ID: <2fcfa6df0811070201g75bfe659x38a4f14b1cf793c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 11:03:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyOBL-0001XA-0n
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 11:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbYKGKB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 05:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbYKGKBz
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 05:01:55 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:6135 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbYKGKBz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 05:01:55 -0500
Received: by wa-out-1112.google.com with SMTP id v27so557215wah.21
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 02:01:54 -0800 (PST)
Received: by 10.115.92.2 with SMTP id u2mr1236721wal.228.1226052114153;
        Fri, 07 Nov 2008 02:01:54 -0800 (PST)
Received: by 10.114.175.11 with HTTP; Fri, 7 Nov 2008 02:01:54 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100298>

"git bisect" uses 'bisect' branch to carry out it's operations.
However "git branch" documentation does mention it.
Add a note that 'bisect' can not be used as generic branch
name by the user.

Signed-off-by: Abhijit Bhopatkar <bain@devslashzero.com>

---
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 6103d62..2ea99fd 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -203,6 +203,9 @@ but different purposes:
 - `--no-merged` is used to find branches which are candidates for merging
   into HEAD, since those branches are not fully contained by HEAD.

+The branch name 'bisect' is reserved for use by "git-bisect" and can not be
+used as a generic branch name.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org> and Junio C Hamano
<gitster@pobox.com>
