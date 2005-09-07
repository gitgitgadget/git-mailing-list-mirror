From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Docs for git-checkout-script.
Date: Wed, 07 Sep 2005 17:17:18 -0400
Message-ID: <431F58DE.2000904@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 07 23:19:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ED7IR-00020A-GH
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 23:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVIGVR3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 17:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVIGVR3
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 17:17:29 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:64968 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932219AbVIGVR2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2005 17:17:28 -0400
Received: by wproxy.gmail.com with SMTP id i2so1038279wra
        for <git@vger.kernel.org>; Wed, 07 Sep 2005 14:17:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=V7oQzIZMQf6R7kxUawJpA7efBRA/kjhHRR29Q24I3pJ2mJEClu49UCIMkr5GNFNjgLFHf3SMBmhwd1J/AZ7RNhfRU2tiyTqK3D682NCgwvTRAijkYRnCUaX+AEd3rYP+oDESfb2/kHkUZQzJuecj+R8u56JfWdpll/WIIWYI8KA=
Received: by 10.54.34.20 with SMTP id h20mr3003389wrh;
        Wed, 07 Sep 2005 14:17:24 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.98])
        by mx.gmail.com with ESMTP id 44sm1031239wri.2005.09.07.14.17.24;
        Wed, 07 Sep 2005 14:17:24 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8176>


Signed-off-by: A Large Angry SCM <gitzilla@gmail.com>


---

 Documentation/git-checkout-script.txt |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

ac5328903884c402905dd2a778ce51a00c041ffc
diff --git a/Documentation/git-checkout-script.txt b/Documentation/git-checkout-script.txt
--- a/Documentation/git-checkout-script.txt
+++ b/Documentation/git-checkout-script.txt
@@ -3,26 +3,31 @@ git-checkout-script(1)
 
 NAME
 ----
-git-checkout-script - Some git command not yet documented.
-
+git-checkout-script - Checkout and switch to a branch.
 
 SYNOPSIS
 --------
-'git-checkout-script' [ --option ] <args>...
+'git-checkout-script' [-f] [-b <new_branch>] [<branch>]
 
 DESCRIPTION
 -----------
-Does something not yet documented.
-
+Updates the index and working tree to reflect the specified branch,
+<branch>. Updates HEAD to be <branch> or, if specified, <new_branch>.
 
 OPTIONS
 -------
---option::
-	Some option not yet documented.
+-f::
+	Force an re-read of everything.
+
+-b::
+	Create a new branch and start it at <branch>.
 
-<args>...::
-	Some argument not yet documented.
+<new_branch>::
+	Name for the new branch.
 
+<branch>::
+	Branch to checkout; may be any object ID that resolves to a
+	commit. Defaults to HEAD.
 
 Author
 ------
