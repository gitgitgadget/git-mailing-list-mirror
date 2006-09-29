From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: Remove redundant "commit" from history
Date: Thu, 28 Sep 2006 17:20:23 -0700 (PDT)
Message-ID: <20060929002023.15243.qmail@web31803.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-384569879-1159489223=:14373"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Sep 29 02:20:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT679-00057K-Hk
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 02:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWI2AUY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 20:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWI2AUY
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 20:20:24 -0400
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:14954 "HELO
	web31803.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932125AbWI2AUY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 20:20:24 -0400
Received: (qmail 15245 invoked by uid 60001); 29 Sep 2006 00:20:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=nygrooIRDrIl/PnpJ8ANgp/2FTE4Djk0LAcCvlnHr8Mx//YNWAzkoJdEeLYJej7f0h//hmI6yG3G8krZMCFF2ivvOx6z9257DUZUv9PXZ5/KZj3GC2sJJqkO5szFgeU6lViryPJrx9H6mz4Zs+4vtoWcef1ezrCFBGoZhzy3IP4=  ;
Received: from [64.215.88.90] by web31803.mail.mud.yahoo.com via HTTP; Thu, 28 Sep 2006 17:20:23 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28077>

--0-384569879-1159489223=:14373
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Remove redundant "commit" from history -- it can be had
by clicking on the title of the commit.  This commit
makes visualization consistent with shortlog, log, etc.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)
--0-384569879-1159489223=:14373
Content-Type: text/plain; name="p1.txt"
Content-Description: 1207600725-p1.txt
Content-Disposition: inline; filename="p1.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fdbdb82..c0f7dff 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2071,7 +2071,6 @@ sub git_history_body {
 		                          href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") . " | " .
 		      $cgi->a({-href => href(action=>$ftype, hash_base=>$commit, file_name=>$file_name)}, $ftype);
 
-- 
1.4.2.1.g8492a


--0-384569879-1159489223=:14373--
