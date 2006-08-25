From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 15/19] gitweb: Change here-doc back for style consistency in git_blobdiff
Date: Fri, 25 Aug 2006 21:06:49 +0200
Message-ID: <200608252106.50047.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 25 21:07:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGh1R-0007jn-76
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 21:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWHYTHM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 15:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWHYTHL
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 15:07:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:27693 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964928AbWHYTHI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 15:07:08 -0400
Received: by nf-out-0910.google.com with SMTP id o25so872262nfa
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 12:07:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lqCmds0DsPaGs11UWsZwYujNcMJtR/L6IV7MwjNUlWpu1PpAATYk+mm6Hsc2oUrxZJO6eB0TWFD+6sbQrHv59cW7LD+U8MI1kADLXkom5HWFcRFPopSf7zlx3RDjY5Ztiurg9vgPMaz/VS2Oc/VdynEYI4PrpDeP2190cFVLHEA=
Received: by 10.48.48.15 with SMTP id v15mr5801677nfv;
        Fri, 25 Aug 2006 12:07:04 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id p72sm7119215nfc.2006.08.25.12.07.04;
        Fri, 25 Aug 2006 12:07:04 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26003>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Next will be patches which get rid of external diff dependency.

 gitweb/gitweb.perl |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ade5d42..a866922 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2800,10 +2800,8 @@ sub git_blobdiff {
 		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	} else {
-		print <<HTML;
-<div class="page_nav"><br/>$formats_nav<br/></div>
-<div class="title">$hash vs $hash_parent</div>
-HTML
+		print "<div class=\"page_nav\"><br/>$formats_nav<br/></div>\n";
+		print "<div class=\"title\">$hash vs $hash_parent</div>\n";
 	}
 	git_print_page_path($file_name, "blob", $hash_base);
 	print "<div class=\"page_body\">\n" .
-- 
1.4.1.1
