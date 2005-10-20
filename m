From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH] [PATCH] add commitdiff option in history window
Date: Thu, 20 Oct 2005 19:28:14 +0200
Message-ID: <20051020172813.29210.3433.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 19:33:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESeCm-00039U-3I
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 19:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVJTR1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 13:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVJTR1t
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 13:27:49 -0400
Received: from [151.97.230.9] ([151.97.230.9]:49547 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932497AbVJTR1t (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 13:27:49 -0400
Received: (qmail 11660 invoked by uid 508); 20 Oct 2005 19:27:42 +0200
Received: from unknown (HELO ssc.unict.it) (151.97.230.9)
  by ssc.unict.it with SMTP; 20 Oct 2005 19:27:42 +0200
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 06A4C2A71F4;
	Thu, 20 Oct 2005 19:28:30 +0200 (CEST)
To: Kay Sievers <kay.sievers@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10371>

In the history window I like to have the commitdiff link too. Hope this
patch is correct. Thanks for review.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 gitweb.cgi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb.cgi b/gitweb.cgi
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -2028,6 +2028,7 @@ sub git_history {
 			      escapeHTML(chop_str($co{'title'}, 50)) . "</b>") . "</td>\n" .
 			      "<td class=\"link\">" .
 			      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$commit"}, "commit") .
+			      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$commit"}, "commitdiff") .
 			      " | " . $cgi->a({-href => "$my_uri?p=$project;a=blob;hb=$commit;f=$file_name"}, "blob");
 			my $blob = git_get_hash_by_path($hash, $file_name);
 			my $blob_parent = git_get_hash_by_path($commit, $file_name);
