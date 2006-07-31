From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 19] gitweb: No need to quote path for list version of open "-|"
Date: Mon, 31 Jul 2006 18:33:37 +0200
Message-ID: <200607311833.39524.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 31 18:33:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7ahv-0003uZ-Rv
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 18:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWGaQd2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 12:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWGaQd2
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 12:33:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:57726 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030227AbWGaQd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 12:33:27 -0400
Received: by ug-out-1314.google.com with SMTP id m3so862049ugc
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 09:33:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UAGmI5TYueav+ysnmKg4qmC1Xa/vXFd8kFNoB5V0luUMwj4aXJQ8uESF7FgbMm6t1VO/Y1KqOLqs8A/07WC/c49aaFGPEADo6ECNy38mnRah7ix2j1nDZPkv4U+/A2RXZNkPByV+/6+IxsFMUpjGwAp9ewfQc+w8/hUgmawGvJI=
Received: by 10.67.101.8 with SMTP id d8mr2745230ugm;
        Mon, 31 Jul 2006 09:33:26 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id q1sm5283240uge.2006.07.31.09.33.25;
        Mon, 31 Jul 2006 09:33:26 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24524>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.cgi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index d209af0..f7fe28a 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -2347,7 +2347,7 @@ sub git_history {
 	git_print_page_path($file_name, $ftype);
 
 	open my $fd, "-|",
-		$GIT, "rev-list", "--full-history", $hash_base, "--", "\'$file_name\'";
+		$GIT, "rev-list", "--full-history", $hash_base, "--", $file_name;
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
 	while (my $line = <$fd>) {
-- 
1.4.1.1
