From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH 1/2] gitweb: blame: Print just a single new line char per table row
Date: Wed, 4 Oct 2006 17:59:26 -0700 (PDT)
Message-ID: <20061005005926.57010.qmail@web31808.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1237924797-1160009966=:56984"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Oct 05 03:07:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVHaF-0000jw-4x
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 02:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWJEA72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 20:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWJEA72
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 20:59:28 -0400
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:61802 "HELO
	web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751289AbWJEA71 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 20:59:27 -0400
Received: (qmail 57012 invoked by uid 60001); 5 Oct 2006 00:59:26 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dvAZsDBL3iRolnVPb2sR2ysybu4itTKV/fnkkND/gU/gAXXjRHi8bkMfBs8/J8/Q1o2iwXhrsY0HK3Ner7P/hbPLX+Jgbi+aPBgwBLDkI25GIVHvM46662tPzg9tZv838rhluj1xiDjeQ0hVoPFe8/9NZCUDALQJuAItNUawoSc=  ;
Received: from [64.215.88.90] by web31808.mail.mud.yahoo.com via HTTP; Wed, 04 Oct 2006 17:59:26 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28336>

--0-1237924797-1160009966=:56984
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

This makes cut-and-paste from blame legible, else after
pasting it is broken into too many lines.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--0-1237924797-1160009966=:56984
Content-Type: text/plain; name="p1.txt"
Content-Description: 1207600725-p1.txt
Content-Disposition: inline; filename="p1.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cba0840..451bf5d 100644
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2509,7 +2509,7 @@ HTML
 			$current_color = ++$current_color % $num_colors;
 			$print_c8 = 1;
 		}
-		print "<tr class=\"$rev_color[$current_color]\">\n";
+		print "<tr class=\"$rev_color[$current_color]\">";
 		print "<td class=\"sha1\"";
 		if ($print_c8 == 1) {
 			print " title=\"$author, $date\"";
@@ -2519,10 +2519,10 @@ HTML
 			print $cgi->a({-href => href(action=>"commit", hash=>$full_rev, file_name=>$file_name)},
 				      esc_html($rev));
 		}
-		print "</td>\n";
+		print "</td>";
 		print "<td class=\"linenr\"><a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" .
-		      esc_html($lineno) . "</a></td>\n";
-		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
+		      esc_html($lineno) . "</a></td>";
+		print "<td class=\"pre\">" . esc_html($data) . "</td>";
 		print "</tr>\n";
 	}
 	print "</table>\n";
-- 
1.4.2.3.g7d77


--0-1237924797-1160009966=:56984--
