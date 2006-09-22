From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 4/6] gitweb: Link to associated tree from a particular log item in full log view
Date: Fri, 22 Sep 2006 03:19:48 +0200
Message-ID: <20060922011948.15909.59511.stgit@rover>
References: <20060922011941.15909.32671.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 22 03:20:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQZhv-0003TZ-19
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 03:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWIVBTv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 21:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWIVBTu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 21:19:50 -0400
Received: from rover.dkm.cz ([62.24.64.27]:62880 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S932174AbWIVBTt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 21:19:49 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 965388BBF1;
	Fri, 22 Sep 2006 03:19:48 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060922011941.15909.32671.stgit@rover>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27513>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0a91394..45a5fbf 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2873,6 +2873,8 @@ sub git_log {
 		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") .
 		      " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") .
+		      " | " .
+		      $cgi->a({-href => href(action=>"tree", hash=>$commit), hash_base=>$commit}, "tree") .
 		      "<br/>\n" .
 		      "</div>\n" .
 		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
