From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Docs for git-reset-script.
Date: Wed, 07 Sep 2005 17:18:51 -0400
Message-ID: <431F593B.5090909@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 07 23:22:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ED7KM-0002T4-Jz
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 23:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVIGVTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 17:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVIGVS7
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 17:18:59 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:55544 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932412AbVIGVS7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2005 17:18:59 -0400
Received: by wproxy.gmail.com with SMTP id 57so1193264wri
        for <git@vger.kernel.org>; Wed, 07 Sep 2005 14:18:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=TAfv5NmVNBsDvypllSnCOo35VJV4guaCQotxyz8nnY3M6ecDLLBPjTuJL1IsxE/N74w15dmZD1zHR0CiCfIQ7SpYZZTd0MHmXTwPZv2fAosslEG7VosMv2F/IkhnW2lImIMVp3FU9Ly5QzvJlhiG5ILEEAMyNO8UP/Xf2P51RhE=
Received: by 10.54.86.20 with SMTP id j20mr296105wrb;
        Wed, 07 Sep 2005 14:18:53 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.98])
        by mx.gmail.com with ESMTP id d75sm887998wra.2005.09.07.14.18.52;
        Wed, 07 Sep 2005 14:18:53 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8177>


Signed-off-by: A Large Angry SCM <gitzilla@gmail.com>


---

 Documentation/git-reset-script.txt |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

e6c59b4622ab3eac9c4a74cd1571136ab586ac5a
diff --git a/Documentation/git-reset-script.txt b/Documentation/git-reset-script.txt
--- a/Documentation/git-reset-script.txt
+++ b/Documentation/git-reset-script.txt
@@ -3,26 +3,33 @@ git-reset-script(1)
 
 NAME
 ----
-git-reset-script - Some git command not yet documented.
-
+git-reset-script - Reset current HEAD to the specified state.
 
 SYNOPSIS
 --------
-'git-reset-script' [ --option ] <args>...
+'git-reset-script' [--mixed | --soft | --hard] [<commit-ish>]
 
 DESCRIPTION
 -----------
-Does something not yet documented.
-
+Sets the current head to the specified commit and optionally resets the
+index and working tree to match.
 
 OPTIONS
 -------
---option::
-	Some option not yet documented.
-
-<args>...::
-	Some argument not yet documented.
+--mixed::
+	Like --soft but reports what has not been updated. This is the
+	default action.
+
+--soft::
+	Does not touch the index file nor the working tree at all, but
+	requires them in a good order.
+
+--hard::
+	Matches the working tree and index to that of the tree being
+	switched to.
 
+<commit-ish>::
+	Commit to make the current HEAD.
 
 Author
 ------
