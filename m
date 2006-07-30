From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5] gitweb: Cleanup - chomp $line in consistent style
Date: Sun, 30 Jul 2006 04:08:17 +0200
Message-ID: <200607300408.32459.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 30 04:08:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G70jT-0006Ml-8i
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 04:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWG3CIh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 22:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWG3CIh
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 22:08:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:26843 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751041AbWG3CIh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jul 2006 22:08:37 -0400
Received: by ug-out-1314.google.com with SMTP id m3so255168ugc
        for <git@vger.kernel.org>; Sat, 29 Jul 2006 19:08:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JSr0M7cAm/GumhZcgj+tM1djslQWMxeBf0W2O5kdEjppsI4rdjQkrtgoVV1T3mAv8ryVsi5hHU7VcpOPptu2gkeirl5arbOXUq7OQPvGTyx012pd/9ApYO+nHVTUiiCCE61PZ+SfuuRg03OjgjSLRq7ITKrQXmvl2XLxKpx9vfw=
Received: by 10.66.240.12 with SMTP id n12mr1122160ugh;
        Sat, 29 Jul 2006 19:08:35 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id e1sm3675876ugf.2006.07.29.19.08.35;
        Sat, 29 Jul 2006 19:08:35 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24445>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.cgi |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 2c67df0..e1f0e26 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -635,7 +635,7 @@ sub git_diff_print {
 		$/ = "\n";
 	} else {
 		while (my $line = <$fd>) {
-			chomp($line);
+			chomp $line;
 			my $char = substr($line, 0, 1);
 			my $diff_class = "";
 			if ($char eq '+') {
@@ -944,7 +944,7 @@ sub read_info_ref {
 	# c39ae07f393806ccf406ef966e9a15afc43cc36a	refs/tags/v2.6.11^{}
 	open my $fd, "$projectroot/$project/info/refs" or return;
 	while (my $line = <$fd>) {
-		chomp($line);
+		chomp $line;
 		if ($line =~ m/^([0-9a-fA-F]{40})\t.*$type\/([^\^]+)/) {
 			if (defined $refs{$1}) {
 				$refs{$1} .= " / $2";
-- 
1.4.0
