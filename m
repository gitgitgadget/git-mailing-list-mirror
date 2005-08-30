From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Update Thunderbird specific hints.
Date: Mon, 29 Aug 2005 22:34:07 -0400
Message-ID: <4313C59F.9030009@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 30 04:36:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9vx0-0008OM-II
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 04:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVH3CeM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 22:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVH3CeM
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 22:34:12 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:20939 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932078AbVH3CeK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 22:34:10 -0400
Received: by wproxy.gmail.com with SMTP id i2so962665wra
        for <git@vger.kernel.org>; Mon, 29 Aug 2005 19:34:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=R4l9DYl2xlzIxjpZTiSnh16AFTYK8qigdLKJiNULz1tOACBMxBoYf1X3krZjMCjsKAGTb973+RZsTvVIRK5iBDG0Tm0M7RbH2K5WXoTkF70BwN9ZARxKlYmEt6f6g0JiikWWEFmBOLgArbkigD5GAkvyWQJLd35EYdi7zq3dhgc=
Received: by 10.54.49.48 with SMTP id w48mr2548668wrw;
        Mon, 29 Aug 2005 19:34:09 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 34sm1619098wra.2005.08.29.19.34.08;
        Mon, 29 Aug 2005 19:34:09 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7944>

Setting the wraplength to zero keeps the bird from trimming WS.

Signed-off-by:  <gitzilla@gmail.com>


---

 Documentation/SubmittingPatches |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

10c16a0043ea3bc1fd97b29bfb6ea62404c9790e
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -239,7 +239,7 @@ Thunderbird
 (A Large Angry SCM)
 
 Here are some hints on how to successfully submit patches inline using
-Thunderbird. [*3*]
+Thunderbird.
 
 This recipe appears to work with the current [*1*] Thunderbird from Suse.
 
@@ -260,7 +260,7 @@ patch. [*2*]
 for the patch, use Tools->about:config to set the following to the
 indicated values:
 	mailnews.send_plaintext_flowed	=> false
-	mailnews.wraplength		=> 999
+	mailnews.wraplength		=> 0
 
 4) Open a compose window and click the external editor icon.
 
@@ -284,7 +284,3 @@ settings but I haven't tried, yet.
 	mail.identity.default.compose_html	=> false
 	mail.identity.id?.compose_html		=> false
 
-*3* Even after following these hints, Thunderbird will still trim
-trailing whitespace from each line. I currently have no work around for
-for this issue.
-
