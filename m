From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Whitespace cleanup - tabs are for indent, spaces are for align
Date: Thu, 10 Aug 2006 12:38:47 +0200
Message-ID: <200608101238.47391.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 10 12:38:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB7w5-0001WG-7Z
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 12:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbWHJKik (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 06:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161151AbWHJKik
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 06:38:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:55033 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161146AbWHJKij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 06:38:39 -0400
Received: by nf-out-0910.google.com with SMTP id a4so490008nfc
        for <git@vger.kernel.org>; Thu, 10 Aug 2006 03:38:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Utit1Rj9JQqy7ZUjJYiiK1d22BtswZuxv+Yax90JqbdBKBQIXlrbWD3keEcOqYWwMj/67Vi9bgm24P0tArWyVEy1Tmuhs/Cr/sUTfm8h456EAMN4H61tomw1Y7qfcG2k6r6gNnqdiRva8AhbDJB/HphEWXltY1tOtJzlRT4VPdE=
Received: by 10.48.162.15 with SMTP id k15mr2674972nfe;
        Thu, 10 Aug 2006 03:38:28 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id c28sm2990164nfb.2006.08.10.03.38.27;
        Thu, 10 Aug 2006 03:38:27 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25178>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Errorneous code (using tabs for align) was generated with tab width 2;
error was noticed when browsing code with tab width 5.

 gitweb/gitweb.perl |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 855e05c..191ed79 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1003,7 +1003,7 @@ sub git_get_paging_nav {
 	if ($page > 0) {
 		$paging_nav .= " &sdot; " .
 			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action;h=$hash;pg=" . ($page-1)),
-							 -accesskey => "p", -title => "Alt-p"}, "prev");
+			         -accesskey => "p", -title => "Alt-p"}, "prev");
 	} else {
 		$paging_nav .= " &sdot; prev";
 	}
@@ -1011,7 +1011,7 @@ sub git_get_paging_nav {
 	if ($nrevs >= (100 * ($page+1)-1)) {
 		$paging_nav .= " &sdot; " .
 			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action;h=$hash;pg=" . ($page+1)),
-							 -accesskey => "n", -title => "Alt-n"}, "next");
+			         -accesskey => "n", -title => "Alt-n"}, "next");
 	} else {
 		$paging_nav .= " &sdot; next";
 	}
@@ -1844,9 +1844,9 @@ sub git_log {
 		next if !%co;
 		my %ad = date_str($co{'author_epoch'});
 		git_header_div('commit',
-									 "<span class=\"age\">$co{'age_string'}</span>" .
-									 esc_html($co{'title'}) . $ref,
-									 $commit);
+		               "<span class=\"age\">$co{'age_string'}</span>" .
+		               esc_html($co{'title'}) . $ref,
+		               $commit);
 		print "<div class=\"title_text\">\n" .
 		      "<div class=\"log_link\">\n" .
 		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit")}, "commit") .
@@ -1911,8 +1911,8 @@ sub git_commit {
 	}
 	git_header_html(undef, $expires);
 	git_page_nav('commit', defined $co{'parent'} ? '' : 'commitdiff',
-							 $hash, $co{'tree'}, $hash,
-							 $formats_nav);
+	             $hash, $co{'tree'}, $hash,
+	             $formats_nav);
 
 	if (defined $co{'parent'}) {
 		git_header_div('commitdiff', esc_html($co{'title'}) . $ref, $hash);
-- 
1.4.1.1
