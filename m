From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/7] gitweb: Fix typo in separation of git_difftree_body
Date: Thu, 17 Aug 2006 11:21:24 +0200
Message-ID: <1155806489378-git-send-email-jnareb@gmail.com>
References: <11558064883957-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 17 11:22:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDe4h-0002Cb-K7
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWHQJVw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWHQJVv
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:21:51 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:19848 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932462AbWHQJVk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 05:21:40 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7H9KPfR023246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Aug 2006 11:20:25 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7H9LTuJ003701;
	Thu, 17 Aug 2006 11:21:29 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7H9LTjv003700;
	Thu, 17 Aug 2006 11:21:29 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11558064883957-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25570>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0d869f2..86266da 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1322,7 +1322,7 @@ sub git_difftree_body {
 			      "<td class=\"link\">" .
 				$cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$file)}, "blob");
 			if ($to_id ne $from_id) { # modified
-				print $cgi->a({-href => href(action=>"blobdiff", hash=>$to_id, hash_parent=>$from_id, hash_base=>$hash, file_name=>$file)}, "diff");
+				print " | " . $cgi->a({-href => href(action=>"blobdiff", hash=>$to_id, hash_parent=>$from_id, hash_base=>$hash, file_name=>$file)}, "diff");
 			}
 			print " | " . $cgi->a({-href => href(action=>"history", hash_base=>$hash, file_name=>$file)}, "history") . "\n";
 			print "</td>\n";
-- 
1.4.1.1
