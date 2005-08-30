From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Documentation for git-applypatch.
Date: Mon, 29 Aug 2005 22:30:32 -0400
Message-ID: <4313C4C8.8050301@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 30 04:31:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9vtm-0007wu-CM
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 04:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVH3Cam (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 22:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVH3Cam
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 22:30:42 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:9321 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751178AbVH3Cal (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 22:30:41 -0400
Received: by wproxy.gmail.com with SMTP id i2so962191wra
        for <git@vger.kernel.org>; Mon, 29 Aug 2005 19:30:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=du0QPa+VjYZ6VboQ5jxqUE1FkhJttxtkqL2s2jOGgcEO9Cx+8RG4gsIiO/6v1dj3B8+3m2fDb3F9YxN34copdJ02PkINLYmNh7QtPyB7I9UrNBZ85N2Izhl56LQyWKC3iw8jH/+PF4BN6O4lfsLDnhbOic4x4FUzriJ6jZMoQ4U=
Received: by 10.54.39.30 with SMTP id m30mr798269wrm;
        Mon, 29 Aug 2005 19:30:34 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 33sm4822747wra.2005.08.29.19.30.33;
        Mon, 29 Aug 2005 19:30:34 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7941>

Copy & paste source comments into documentation.

Signed-off-by:  <gitzilla@gmail.com>


---

 Documentation/git-applypatch.txt |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

0c00e0e3bd83cc1297e2581cae66aeebc65e52a6
diff --git a/Documentation/git-applypatch.txt b/Documentation/git-applypatch.txt
--- a/Documentation/git-applypatch.txt
+++ b/Documentation/git-applypatch.txt
@@ -3,26 +3,30 @@ git-applypatch(1)
 
 NAME
 ----
-git-applypatch - Some git command not yet documented.
-
+git-applypatch - Apply an unpacked patch to current tree.
 
 SYNOPSIS
 --------
-'git-applypatch' [ --option ] <args>...
+'git-applypatch' <message file> <patch file> <info file> [<signoff file>]
 
 DESCRIPTION
 -----------
-Does something not yet documented.
-
+Takes four file arguments, and uses those to apply the unpacked patch that they
+represent to the current tree.
 
 OPTIONS
 -------
---option::
-	Some option not yet documented.
+<message file::
+	File with commit message.
+
+<patch file>::
+	File with the actual patch.
 
-<args>...::
-	Some argument not yet documented.
+<info file>::
+	File with Author, Email, and Subject information.
 
+<signoff file>::
+	File containing signoff ot add.
 
 Author
 ------
