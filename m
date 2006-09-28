From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: Add snapshot to shortlog
Date: Thu, 28 Sep 2006 16:50:09 -0700 (PDT)
Message-ID: <20060928235009.92537.qmail@web31811.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-793751061-1159487409=:91803"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Sep 29 01:50:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT5dv-0005lT-LM
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 01:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161347AbWI1XuL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 19:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161369AbWI1XuL
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 19:50:11 -0400
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:52380 "HELO
	web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161347AbWI1XuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 19:50:09 -0400
Received: (qmail 92539 invoked by uid 60001); 28 Sep 2006 23:50:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=GqGIWfz8zUeAxcOEtobFpaW8kn7kekFStND0VLpfRXk2hqFGFehsZI50d8dK7ztdd/30BsE0mHNAnyHEiQF0FauXM3CbD2RHdpBdxzIAJUTm7OdYacYIMcpMSAU3xewMteDdwfp2oF2dfSc+MPBg/+SzJp5MdnHtmhJL3ZIZIoI=  ;
Received: from [64.215.88.90] by web31811.mail.mud.yahoo.com via HTTP; Thu, 28 Sep 2006 16:50:09 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28071>

--0-793751061-1159487409=:91803
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Add snapshot to each commit-row of shortlog.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

--0-793751061-1159487409=:91803
Content-Type: text/plain; name="p4.txt"
Content-Description: 4046732943-p4.txt
Content-Disposition: inline; filename="p4.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a2f07cc..953a0ef 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2021,7 +2021,8 @@ sub git_shortlog_body {
 		print "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") . " | " .
-		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree");
+		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") . " | " .
+		      $cgi->a({-href => href(action=>"snapshot", hash=>$commit)}, "snapshot");
 		print "</td>\n" .
 		      "</tr>\n";
 	}
-- 
1.4.2.1.g05f0f


--0-793751061-1159487409=:91803--
