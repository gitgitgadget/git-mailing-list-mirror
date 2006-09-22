From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 6/6] gitweb: Relabel "head" as "HEAD"
Date: Fri, 22 Sep 2006 03:19:53 +0200
Message-ID: <20060922011952.15909.67857.stgit@rover>
References: <20060922011941.15909.32671.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 22 03:20:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQZhw-0003TZ-47
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 03:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWIVBTz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 21:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWIVBTz
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 21:19:55 -0400
Received: from rover.dkm.cz ([62.24.64.27]:64416 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S932177AbWIVBTy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 21:19:54 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 217C08BBF1;
	Fri, 22 Sep 2006 03:19:53 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060922011941.15909.32671.stgit@rover>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27512>

"head" is a reference in refs/heads/, while those labels mean HEAD,
the latest revision of the default branch.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7b44c28..9c3546f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2444,7 +2444,7 @@ sub git_blame2 {
 			"history") .
 		" | " .
 		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
-		        "head");
+		        "HEAD");
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	git_print_page_path($file_name, $ftype, $hash_base);
@@ -2513,7 +2513,7 @@ sub git_blame {
 			"history") .
 		" | " .
 		$cgi->a({-href => href(action=>"blame", file_name=>$file_name)},
-		        "head");
+		        "HEAD");
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	git_print_page_path($file_name, 'blob', $hash_base);
@@ -2697,7 +2697,7 @@ sub git_blob {
 				" | " .
 				$cgi->a({-href => href(action=>"blob",
 				                       hash_base=>"HEAD", file_name=>$file_name)},
-				        "head");
+				        "HEAD");
 		} else {
 			$formats_nav .=
 				$cgi->a({-href => href(action=>"blob_plain", hash=>$hash)}, "raw");
@@ -2760,7 +2760,7 @@ sub git_tree {
 				        "history"),
 				$cgi->a({-href => href(action=>"tree",
 				                       hash_base=>"HEAD", file_name=>$file_name)},
-				        "head");
+				        "HEAD"),
 		}
 		if ($have_snapshot) {
 			# FIXME: Should be available when we have no hash base as well.
