From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: whitespace cleanup around '='
Date: Thu, 22 Jun 2006 08:52:57 +0200
Message-ID: <11509591773212-git-send-email-jnareb@gmail.com>
References: <20060622023546.28cb4291.froese@gmx.de>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 22 08:53:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtJ3t-0003Hr-Il
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 08:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbWFVGxE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 02:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWFVGxD
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 02:53:03 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:52645 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1751710AbWFVGxB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 02:53:01 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k5M6qZ1N015850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 22 Jun 2006 08:52:35 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k5M6qviv030438;
	Thu, 22 Jun 2006 08:52:57 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k5M6qv3B030437;
	Thu, 22 Jun 2006 08:52:57 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <20060622023546.28cb4291.froese@gmx.de>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22299>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>


---

 gitweb/gitweb.cgi |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

82c8812870e9c40fd495e9c3e2eae0eb78ac2759
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index e044c61..adc4a42 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -326,7 +326,7 @@ EOF
 		} elsif (defined $hash) {
 			$search_hash = $hash;
 		} else {
-			$search_hash  = "HEAD";
+			$search_hash = "HEAD";
 		}
 		$cgi->param("a", "search");
 		$cgi->param("h", $search_hash);
@@ -1766,8 +1766,8 @@ sub git_opml {
 		}
 
 		my $path = esc_html(chop_str($proj{'path'}, 25, 5));
-		my $rss =  "$my_url?p=$proj{'path'};a=rss";
-		my $html =  "$my_url?p=$proj{'path'};a=summary";
+		my $rss  = "$my_url?p=$proj{'path'};a=rss";
+		my $html = "$my_url?p=$proj{'path'};a=summary";
 		print "<outline type=\"rss\" text=\"$path\" title=\"$path\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
 	}
 	print "</outline>\n".
@@ -1942,7 +1942,7 @@ sub git_commit {
 	      "<td class=\"link\">" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash")}, "tree") .
 	      "</td>" .
 	      "</tr>\n";
-	my $parents  = $co{'parents'};
+	my $parents = $co{'parents'};
 	foreach my $par (@$parents) {
 		print "<tr>" .
 		      "<td>parent</td>" .
-- 
1.3.0
