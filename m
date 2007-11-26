From: Denis Cheng <crquan@gmail.com>
Subject: [PATCH] gitweb: the commitdiff is very commonly used, it's needed on search page, too
Date: Mon, 26 Nov 2007 20:42:06 +0800
Message-ID: <1196080926-5962-1-git-send-email-crquan@gmail.com>
Cc: dengxw@163.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 13:42:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwdIf-0004aX-9N
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 13:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbXKZMmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 07:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824AbXKZMmj
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 07:42:39 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:60549 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbXKZMmi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 07:42:38 -0500
Received: by rv-out-0910.google.com with SMTP id k20so507211rvb
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 04:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=tc9E8MHNyzk3qQQnLfv5POJwDZ7dwfiORhkIpACzkaw=;
        b=Kk32BU9PTrlPSy9lF3PM8wxR0YYIO2ZSTiHWamtBDg9GaYQohjSFtGNQ7NCdecrFa0wvja3H8vQuj9pYJFhsJ+D3PTrMKAgBIJT6xamuXoqL44L437dehuLb7I6XnLUCepif34w0BPDaStkJPwaPwT0mTa9gdIE0OJCsBsNKj20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=U1897ANLCBcw7mogchexbHG40HtKuUGJ7O9gO4gqLZfMmbyRDxkHJrZhwMlWkHY+kTEEmCYUla2CHJ6LqF6ZNb3NA78jCeJ2iQwBALBzPeURMqZzjiJxnpaP5MhcGySg7Mg4DWXGc10TGRrDiKvC0SpC5/yOAjMYCKk4mnXcgHU=
Received: by 10.140.199.19 with SMTP id w19mr1102391rvf.1196080958099;
        Mon, 26 Nov 2007 04:42:38 -0800 (PST)
Received: from tux ( [121.34.62.230])
        by mx.google.com with ESMTPS id g1sm290105rvb.2007.11.26.04.42.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Nov 2007 04:42:35 -0800 (PST)
Received: by tux (sSMTP sendmail emulation); Mon, 26 Nov 2007 20:42:06 +0800
X-Mailer: git-send-email 1.5.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66068>

---
 gitweb/gitweb.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 491a3f4..ff5daa7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3786,6 +3786,8 @@ sub git_search_grep_body {
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
 		      " | " .
+		      $cgi->a({-href => href(action=>"commitdiff", hash=>$co{'id'})}, "commitdiff") .
+		      " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
 		print "</td>\n" .
 		      "</tr>\n";
-- 
1.5.3.4
