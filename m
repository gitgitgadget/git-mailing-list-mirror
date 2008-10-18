From: Abhijit Bhopatkar <bain@devslashzero.com>
Subject: [PATCH] Documentation: Better explain git-commit --author implications
Date: Sat, 18 Oct 2008 09:05:16 +0530
Message-ID: <48F95974.3010503@devslashzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 18 05:41:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr2hA-0008KV-KK
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 05:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbYJRDf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 23:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbYJRDf1
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 23:35:27 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:41213 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbYJRDf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 23:35:26 -0400
Received: by ti-out-0910.google.com with SMTP id b6so400718tic.23
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 20:35:23 -0700 (PDT)
Received: by 10.110.37.3 with SMTP id k3mr3517170tik.13.1224300923735;
        Fri, 17 Oct 2008 20:35:23 -0700 (PDT)
Received: from ?192.168.1.204? ([59.95.12.5])
        by mx.google.com with ESMTPS id d4sm6240505tib.1.2008.10.17.20.35.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Oct 2008 20:35:22 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98519>

'--author' changes the author name and email, but the
documentation was not clear that it will not affect the
'--signoff' option which will still use the user's name and
email from the git settings.

Signed-off-by: Abhijit Bhopatkar <bain@devslashzero.com>
---
 Documentation/git-commit.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index eb05b0f..17b69fa 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -78,7 +78,8 @@ OPTIONS
 	Override the author name used in the commit.  You can use the
 	standard `A U Thor <author@example.com>` format.  Otherwise,
 	an existing commit that matches the given string and its author
-	name is used.
+	name is used. This has no effect on singoff line which will
+	still use commiter name and email .

 -m <msg>::
 --message=<msg>::
@@ -95,6 +96,7 @@ OPTIONS
 -s::
 --signoff::
 	Add Signed-off-by line at the end of the commit message.
+	'--author' option has no effect on this line.

 -n::
 --no-verify::
-- 
1.5.6.3
