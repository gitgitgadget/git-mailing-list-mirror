From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 5/6] gitweb: Rename "plain" labels to "raw"
Date: Fri, 22 Sep 2006 03:19:50 +0200
Message-ID: <20060922011950.15909.78402.stgit@rover>
References: <20060922011941.15909.32671.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 22 03:20:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQZhv-0003TZ-I8
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 03:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWIVBTx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 21:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWIVBTx
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 21:19:53 -0400
Received: from rover.dkm.cz ([62.24.64.27]:63648 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S932176AbWIVBTv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 21:19:51 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id DA53C8B875;
	Fri, 22 Sep 2006 03:19:50 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060922011941.15909.32671.stgit@rover>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27514>

I don't have much preference either way and as far as I'm concerned, it may
go the other way as well. Consistency is what is important.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 45a5fbf..7b44c28 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2693,14 +2693,14 @@ sub git_blob {
 				" | " .
 				$cgi->a({-href => href(action=>"blob_plain",
 				                       hash=>$hash, file_name=>$file_name)},
-				        "plain") .
+				        "raw") .
 				" | " .
 				$cgi->a({-href => href(action=>"blob",
 				                       hash_base=>"HEAD", file_name=>$file_name)},
 				        "head");
 		} else {
 			$formats_nav .=
-				$cgi->a({-href => href(action=>"blob_plain", hash=>$hash)}, "plain");
+				$cgi->a({-href => href(action=>"blob_plain", hash=>$hash)}, "raw");
 		}
 		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
@@ -3109,7 +3109,7 @@ sub git_blobdiff {
 			                       hash=>$hash, hash_parent=>$hash_parent,
 			                       hash_base=>$hash_base, hash_parent_base=>$hash_parent_base,
 			                       file_name=>$file_name, file_parent=>$file_parent)},
-			        "plain");
+			        "raw");
 		git_header_html(undef, $expires);
 		if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 			git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
@@ -3212,7 +3212,7 @@ sub git_commitdiff {
 		my $formats_nav =
 			$cgi->a({-href => href(action=>"commitdiff_plain",
 			                       hash=>$hash, hash_parent=>$hash_parent)},
-			        "plain");
+			        "raw");
 
 		git_header_html(undef, $expires);
 		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
