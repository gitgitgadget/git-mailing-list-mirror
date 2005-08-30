From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Documentation for git-request-pull-script.
Date: Mon, 29 Aug 2005 22:33:14 -0400
Message-ID: <4313C56A.3010805@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 30 04:34:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9vw8-0008H6-4o
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 04:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVH3CdR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 22:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVH3CdR
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 22:33:17 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:55208 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932077AbVH3CdR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 22:33:17 -0400
Received: by wproxy.gmail.com with SMTP id i36so731726wra
        for <git@vger.kernel.org>; Mon, 29 Aug 2005 19:33:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=mfWSCcAmJ+hImHYbLiCaM+KWy1zXTgZTeml18IsysmBbKSAJDLaPbwmYaFvxFs5fwaixw81mUwa5a1SA+fERGHjigqUDusXj5fto+DBHPDmFWTbgn2AFLwTAZ7fVsv3Ak3ERwC7nOPime5ASeuYDrE2iJ/WFYXQF4pEoBZqf3XM=
Received: by 10.54.144.7 with SMTP id r7mr6759747wrd;
        Mon, 29 Aug 2005 19:33:16 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 9sm5028663wrl.2005.08.29.19.33.15;
        Mon, 29 Aug 2005 19:33:15 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7943>

Copy & paste source comments into documentation.

Signed-off-by:  <gitzilla@gmail.com>


---

 Documentation/git-request-pull-script.txt |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

c309197099fceb12fa05d9aa23b0b7e5adf5f061
diff --git a/Documentation/git-request-pull-script.txt b/Documentation/git-request-pull-script.txt
--- a/Documentation/git-request-pull-script.txt
+++ b/Documentation/git-request-pull-script.txt
@@ -3,26 +3,28 @@ git-request-pull-script(1)
 
 NAME
 ----
-git-request-pull-script - Some git command not yet documented.
-
+git-request-pull-script - Generates a summary of pending changes.
 
 SYNOPSIS
 --------
-'git-request-pull-script' [ --option ] <args>...
+'git-request-pull-script' <start> <url> [<end>]
 
 DESCRIPTION
 -----------
-Does something not yet documented.
 
+Summarizes the changes between two commits to the standard output, and includes
+the given URL in the generated summary.
 
 OPTIONS
 -------
---option::
-	Some option not yet documented.
+<start>::
+	Commit to start at.
 
-<args>...::
-	Some argument not yet documented.
+<url>::
+	URL to include in the summary.
 
+<end>::
+	Commit to send at; defaults to HEAD.
 
 Author
 ------
