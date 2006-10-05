From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/6] gitweb: use blame --porcelain
Date: Thu, 05 Oct 2006 14:48:13 -0700
Message-ID: <7v4puibfj6.fsf@assigned-by-dhcp.cox.net>
References: <7vwt7ebhe9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 05 23:50:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVb5q-0003iJ-T7
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 23:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWJEVsV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 17:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWJEVsS
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 17:48:18 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:3726 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932293AbWJEVsO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 17:48:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061005214813.DVDE16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Oct 2006 17:48:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WloG1V0091kojtg0000000
	Thu, 05 Oct 2006 17:48:16 -0400
To: git@vger.kernel.org
In-Reply-To: <7vwt7ebhe9.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 05 Oct 2006 14:07:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28375>

Found a stupid typo...

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index feb768f..8b97357 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2589,7 +2589,7 @@ HTML
 				  file_name => $meta->{'filename'},
 				  hash_base => $full_rev);
 		print "<td class=\"linenr\">";
-		print $cgi->a({ -href => "$blamed#l$lineno",
+		print $cgi->a({ -href => "$blamed#l$orig_lineno",
 				-id => "l$lineno",
 				-class => "linenr" },
 			      esc_html($lineno));
