From: Petr Baudis <pasky@suse.cz>
Subject: [RFC][PATCH] gitweb: Make the Git logo link target to point to the homepage
Date: Tue, 19 Sep 2006 23:27:25 +0200
Message-ID: <20060919212725.GA13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=fixed
X-From: git-owner@vger.kernel.org Tue Sep 19 23:28:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPn7t-0002PZ-LE
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 23:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWISV11 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 17:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbWISV11
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 17:27:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46465 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751184AbWISV10 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 17:27:26 -0400
Received: (qmail 21536 invoked by uid 2001); 19 Sep 2006 23:27:25 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27289>

It provides more useful information for causual Git users than the Git docs
(especially about where to get Git and such).

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c77270c..7ecd7df 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1312,7 +1312,7 @@ EOF
 	print "</head>\n" .
 	      "<body>\n" .
 	      "<div class=\"page_header\">\n" .
-	      "<a href=\"http://www.kernel.org/pub/software/scm/git/docs/\" title=\"git documentation\">" .
+	      "<a href=\"http://git.or.cz/\" title=\"Git homepage\">" .
 	      "<img src=\"$logo\" width=\"72\" height=\"27\" alt=\"git\" style=\"float:right; border-width:0px;\"/>" .
 	      "</a>\n";
 	print $cgi->a({-href => esc_param($home_link)}, $home_link_str) . " / ";
