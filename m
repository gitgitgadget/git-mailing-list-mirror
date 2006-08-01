From: Junio C Hamano <junkio@cox.net>
Subject: Perhaps an obvious cut and paste error.
Date: Mon, 31 Jul 2006 19:12:18 -0700
Message-ID: <7vlkq94325.fsf_-_@assigned-by-dhcp.cox.net>
References: <200607292239.11034.jnareb@gmail.com>
	<200608010259.13721.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 04:12:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7jkJ-0004XV-5u
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 04:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWHACMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 22:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWHACMU
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 22:12:20 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:58850 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030272AbWHACMU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 22:12:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060801021219.PAJJ2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Jul 2006 22:12:19 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608010259.13721.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 1 Aug 2006 02:59:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24563>

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 4e79390..a4a46d9 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1441,7 +1434,7 @@ sub git_summary {
 	my $headlist = git_read_refs("refs/heads");
 	if (defined @$headlist) {
 		git_header_div('heads');
-		git_heads_body($taglist, $head, 0, 15,
+		git_heads_body($headlist, $head, 0, 15,
 		               $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=heads")}, "..."));
 	}
 
