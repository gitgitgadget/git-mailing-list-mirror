From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: Remove redundant "commit" link from shortlog
Date: Thu, 28 Sep 2006 16:48:40 -0700 (PDT)
Message-ID: <20060928234840.25950.qmail@web31809.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1725377498-1159487320=:25504"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Sep 29 01:49:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT5ce-0005RX-G9
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 01:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWI1Xsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 19:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWI1Xsq
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 19:48:46 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:29520 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964980AbWI1Xso (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 19:48:44 -0400
Received: (qmail 25952 invoked by uid 60001); 28 Sep 2006 23:48:40 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=NpjUJnMUci0XkDglkyKCn+WTdQ5oeXzvh9J643bsVB6dI45qdLdNMU8rCD3AR+Z7ySc3JV/q0gDub3dY5zXAd9MW3H5CwZ6WxfSf36JT433wPY9pDd6TzPFfvuMg+/5ydhOM6DIoQFyDO6uc6gbRypbiswceCFTEziAIxb0N3zg=  ;
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Thu, 28 Sep 2006 16:48:40 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28069>

--0-1725377498-1159487320=:25504
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Remove the redundant "commit" link from shortlog.
It can be had by simply clicking on the entry title
of the row.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

--0-1725377498-1159487320=:25504
Content-Type: text/plain; name="p2.txt"
Content-Description: 1908141687-p2.txt
Content-Disposition: inline; filename="p2.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 79c8052..f3f22c2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2013,7 +2013,6 @@ sub git_shortlog_body {
 		                          href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") . " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree");
 		print "</td>\n" .
-- 
1.4.2.1.g05f0f


--0-1725377498-1159487320=:25504--
