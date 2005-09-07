From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Docs for git-build-rev-cache.
Date: Wed, 07 Sep 2005 17:20:41 -0400
Message-ID: <431F59A9.6010000@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 07 23:22:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ED7Lb-0002vL-89
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 23:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVIGVUp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 17:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVIGVUo
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 17:20:44 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:19016 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932425AbVIGVUo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2005 17:20:44 -0400
Received: by wproxy.gmail.com with SMTP id i2so1038801wra
        for <git@vger.kernel.org>; Wed, 07 Sep 2005 14:20:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=bO1U1UceD+IIAsHtpHrfh7bLdJvFUZGAZIOvgJiJmUNe5ogmbefnsDTJf+xKRISnmk2ukKpvgPlIRcse8FAKtbavmy8svdRXiFheKN8oWJPuEQesWiQ+wuMaYp+gQbKaevZix9OoKo36ZrQ0rIgPqt9lCf0ZCwoXhekQYkmSMkY=
Received: by 10.54.42.17 with SMTP id p17mr798315wrp;
        Wed, 07 Sep 2005 14:20:43 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.98])
        by mx.gmail.com with ESMTP id 7sm1229285wrl.2005.09.07.14.20.42;
        Wed, 07 Sep 2005 14:20:43 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8178>


Signed-off-by: A Large Angry SCM <gitzilla@gmail.com>


---

 Documentation/git-build-rev-cache.txt |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

c7c6e77b9efa05b8a7b84fdf630f4ff64664872f
diff --git a/Documentation/git-build-rev-cache.txt b/Documentation/git-build-rev-cache.txt
--- a/Documentation/git-build-rev-cache.txt
+++ b/Documentation/git-build-rev-cache.txt
@@ -3,26 +3,26 @@ git-build-rev-cache(1)
 
 NAME
 ----
-git-build-rev-cache - Some git command not yet documented.
-
+git-build-rev-cache - Create or update a rev-cache file.
 
 SYNOPSIS
 --------
-'git-build-rev-cache' [ --option ] <args>...
+'git-build-rev-cache' [-v] <rev-cache-file> < list-of-heads
 
 DESCRIPTION
 -----------
-Does something not yet documented.
-
+Creates or updates a file that describes the commit ancestry reachable
+from the list-of-head read from stdin. This file is in an append-only
+binary format to make the server side friendly to rsync mirroring
+scheme, and can be read by the git-show-rev-cache command.
 
 OPTIONS
 -------
---option::
-	Some option not yet documented.
-
-<args>...::
-	Some argument not yet documented.
+-v::
+	Verbose.
 
+<rev-cache-file>::
+	The rev-cache to operate on.
 
 Author
 ------
