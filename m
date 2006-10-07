From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Sat, 07 Oct 2006 16:10:43 +0200
Message-ID: <20061007141043.16912.73982.stgit@rover>
References: <20061007132457.GB20017@pasky.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 07 16:11:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWCt7-0003fv-3j
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 16:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWJGOKp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 10:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbWJGOKp
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 10:10:45 -0400
Received: from rover.dkm.cz ([62.24.64.27]:53381 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S1751805AbWJGOKo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 10:10:44 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 643868BC23;
	Sat,  7 Oct 2006 16:10:43 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20061007132457.GB20017@pasky.or.cz>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28485>

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 096a01b..c3d09a2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1791,7 +1791,7 @@ sub git_print_tree_entry {
 		print "<td class=\"list\">";
 		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
 		                             file_name=>"$basedir$t->{'name'}", %base_key)},
-		              esc_html($t->{'name'}));
+		              esc_html($t->{'name'} . '/'));
 		print "</td>\n";
 		print "<td class=\"link\">";
 		if (defined $hash_base) {
