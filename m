From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 3/6] gitweb: Link to latest tree from the head line in heads list
Date: Fri, 22 Sep 2006 03:19:46 +0200
Message-ID: <20060922011946.15909.10313.stgit@rover>
References: <20060922011941.15909.32671.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 22 03:20:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQZhu-0003TZ-9u
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 03:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWIVBTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 21:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWIVBTs
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 21:19:48 -0400
Received: from rover.dkm.cz ([62.24.64.27]:62112 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S932172AbWIVBTr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 21:19:47 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 557BA8B875;
	Fri, 22 Sep 2006 03:19:46 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060922011941.15909.32671.stgit@rover>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27515>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1b1653a..0a91394 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2164,7 +2164,8 @@ sub git_heads_body {
 		      "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'name'})}, "shortlog") . " | " .
-		      $cgi->a({-href => href(action=>"log", hash=>$tag{'name'})}, "log") .
+		      $cgi->a({-href => href(action=>"log", hash=>$tag{'name'})}, "log") . " | " .
+		      $cgi->a({-href => href(action=>"tree", hash=>$tag{'name'}, hash_base=>$tag{'name'})}, "tree") .
 		      "</td>\n" .
 		      "</tr>";
 	}
