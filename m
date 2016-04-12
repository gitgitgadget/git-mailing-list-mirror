From: Rudy YAYON <ryayon@outlook.com>
Subject: [PATCH] There was a little inconsistancy in git prompt
Date: Tue, 12 Apr 2016 07:16:34 +0000
Message-ID: <01020154095436db-40246224-5586-4e95-b5f7-59b27928ffa8-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 12 09:16:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apsYz-00074R-0i
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 09:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035AbcDLHQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 03:16:37 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:52517
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755956AbcDLHQh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2016 03:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1460445394;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=P2V9kQEPn4m+zSayH3D9UXD21QFDrRD5DUP4RQQb3ZE=;
	b=SXPmOwD3IebYXSgzrB7NJKFxM7pliCZgw4eeL06MK3/Ta88mI85Dbd0LErNgzdpe
	js/mnynq9dV8TG6F6yQkpkAdVfz54eXyGZFde3RqXPtJyWWNTmr8QB6kZXTw/OV08el
	sX5FQoUS+x8MhOHw3NBMdsadLEJlnUAW4ogV9Q+k=
X-SES-Outgoing: 2016.04.12-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291247>

---
 contrib/completion/git-prompt.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 07b52be..18be99f 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -194,13 +194,13 @@ __git_ps1_show_upstream ()
 		"") # no upstream
 			p="" ;;
 		"0	0") # equal to upstream
-			p="=" ;;
+			p=" =" ;;
 		"0	"*) # ahead of upstream
-			p=">" ;;
+			p=" >" ;;
 		*"	0") # behind upstream
-			p="<" ;;
+			p=" <" ;;
 		*)	    # diverged from upstream
-			p="<>" ;;
+			p=" <>" ;;
 		esac
 	else
 		case "$count" in

--
https://github.com/git/git/pull/181
