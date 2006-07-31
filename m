From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 16b] gitweb: Remove characters entities entirely when shortening string -- correction
Date: Mon, 31 Jul 2006 20:58:00 +0200
Message-ID: <200607312058.00706.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com> <200607302236.06686.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 31 20:58:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7cxl-0006wv-3S
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 20:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWGaS5s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 14:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWGaS5s
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 14:57:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:25682 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030325AbWGaS5r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 14:57:47 -0400
Received: by ug-out-1314.google.com with SMTP id m3so937989ugc
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 11:57:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:user-agent:references:in-reply-to:mime-version:content-disposition:date:content-type:content-transfer-encoding:message-id;
        b=D7aq71p93XNZWBbJkLPm1gjwNq4TWTa6KuWV/BgyQw4SfPeeAsqovzJtPHOawuaJPIXhmDENVkbx6bx0QlvZodAt81C7rrvLc9Z3xGdraw0sXvxEA1yeclCeG3PWG6nn8dt0dkYDublavUNMaW6D8g5104BUP3hcSpUYsgKTG+U=
Received: by 10.66.240.12 with SMTP id n12mr2903621ugh;
        Mon, 31 Jul 2006 11:57:45 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id m1sm5425395uge.2006.07.31.11.57.45;
        Mon, 31 Jul 2006 11:57:45 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607302236.06686.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24538>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Apply it on top of [PATCH 16] to correct it;
this patch was generated after [PATCH 19].

 gitweb/gitweb.cgi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index f7fe28a..cb6af39 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -776,7 +776,7 @@ sub chop_str {
 	my $tail = $2;
 	if (length($tail) > 4) {
 		$tail = " ...";
-		$body =~ s/&[^;]$//; # remove chopped character entities
+		$body =~ s/&[^;]*$//; # remove chopped character entities
 	}
 	return "$body$tail";
 }
-- 
1.4.1.1
