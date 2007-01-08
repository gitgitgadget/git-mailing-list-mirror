From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Remove superfluous "|" in "commit" view
Date: Mon,  8 Jan 2007 02:10:42 +0100
Message-ID: <11682186422078-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 08 02:10:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3j2L-0008Pj-6x
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 02:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbXAHBKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 20:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbXAHBKj
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 20:10:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:25834 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965286AbXAHBKi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 20:10:38 -0500
Received: by nf-out-0910.google.com with SMTP id o25so9310761nfa
        for <git@vger.kernel.org>; Sun, 07 Jan 2007 17:10:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=oOLuTxu7SUT443af01kIPCwvadh7SdlK4e+ON3N0B4536UjkLWFWKXawTnxQzCXq3k/22/w+YF7uZWpS+aWo48poLWyNb4lPNcZ4kuUhpcgGOk9uQAbjhc6n5CV3wFBifVxXAN+We2uo2iCP5rsleYoyMvG7d/55aWUbH3781t4=
Received: by 10.48.48.18 with SMTP id v18mr28433418nfv.1168218637343;
        Sun, 07 Jan 2007 17:10:37 -0800 (PST)
Received: from roke.D-201 ( [81.190.18.145])
        by mx.google.com with ESMTP id m15sm21905090nfc.2007.01.07.17.10.36;
        Sun, 07 Jan 2007 17:10:37 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l081Ahfo006069;
	Mon, 8 Jan 2007 02:10:44 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l081AgZm006068;
	Mon, 8 Jan 2007 02:10:42 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36213>

Remove superfluous trailing "|" separator from difftree part of "commit"
view for new files (created in given commit).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f46a422..25e5079 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2239,7 +2239,7 @@ sub git_difftree_body {
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
 			                             hash_base=>$hash, file_name=>$diff{'file'})},
-			              "blob") . " | ";
+			              "blob");
 			print "</td>\n";
 
 		} elsif ($diff{'status'} eq "D") { # deleted
-- 
1.4.4.3
