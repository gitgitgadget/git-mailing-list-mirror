From: Alp Toker <alp@atoker.com>
Subject: [PATCH] gitweb: Include a site name in page titles
Date: Tue, 11 Jul 2006 11:19:35 +0100
Message-ID: <1152613179634-git-send-email-alp@atoker.com>
References: <11526131782190-git-send-email-alp@atoker.com> <11526131781900-git-send-email-alp@atoker.com>
X-From: git-owner@vger.kernel.org Tue Jul 11 12:20:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0FLV-0003jo-Tp
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 12:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWGKKTv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 06:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWGKKTv
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 06:19:51 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:11795 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1750944AbWGKKTt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 06:19:49 -0400
Received: by ndesk.org (Postfix, from userid 1000)
	id 146601645A1; Tue, 11 Jul 2006 11:19:39 +0100 (BST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.g97c7-dirty
In-Reply-To: <11526131781900-git-send-email-alp@atoker.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23707>

Tip Of The Day:
    <title>: the most important element of a quality Web page.

This helps users tell one 'git' bookmark apart from the other in their
browser and improves the indexing of gitweb sites in Web search engines.

Signed-off-by: Alp Toker <alp@atoker.com>
---
 gitweb/gitweb.cgi |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index bd9b9de..b12417b 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -46,6 +46,9 @@ if (! -d $git_temp) {
 # target of the home link on top of all pages
 our $home_link = $my_uri;
 
+# name of your site or organization to appear in page titles
+our $site_name = "Untitled";
+
 # html text to include at home page
 our $home_text = "indextext.html";
 
@@ -280,7 +283,7 @@ sub git_header_html {
 	my $status = shift || "200 OK";
 	my $expires = shift;
 
-	my $title = "git";
+	my $title = "$site_name git";
 	if (defined $project) {
 		$title .= " - $project";
 		if (defined $action) {
@@ -1770,7 +1773,7 @@ sub git_opml {
 	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
 	      "<opml version=\"1.0\">\n".
 	      "<head>".
-	      "  <title>Git OPML Export</title>\n".
+	      "  <title>$site_name Git OPML Export</title>\n".
 	      "</head>\n".
 	      "<body>\n".
 	      "<outline text=\"git RSS feeds\">\n";
-- 
1.4.1.g97c7-dirty
