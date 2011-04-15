From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/5] Documentation: publicize KMail hints for sending patches
 inline
Date: Thu, 14 Apr 2011 21:32:55 -0500
Message-ID: <20110415023255.GE19829@elie>
References: <87d3kq6tz7.fsf@rho.meyering.net>
 <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
 <87mxjtn8x7.fsf@rho.meyering.net>
 <20110413221736.GA773@elie>
 <7vzkntkc9d.fsf@alter.siamese.dyndns.org>
 <20110414211125.GA15277@elie>
 <7vlizcfpz8.fsf@alter.siamese.dyndns.org>
 <20110415021100.GA19829@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michele Ballabio <barra_cuda@katamail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 04:33:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAYqV-0007lY-GT
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 04:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175Ab1DOCdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 22:33:03 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35293 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab1DOCdB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 22:33:01 -0400
Received: by gyd10 with SMTP id 10so709040gyd.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 19:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=cJD/2LUumNgcXxbE0IZd22LkyS8ICf6wihcVenhhgUQ=;
        b=AFt1TXrcP6AZNy6VMRzpM/c6B6JgwYj0rcu3SSblVG5kem3MD8eA5wx85odGekGrde
         +3SoR8KZteLkUTNxiect3xSk9TgU49f6tU/tR73EumbDcxrZZCeqcsJWGOHlLbseRac9
         qORztDJcFqZNPXBiQe6UJezGdn9Z9ws1t4x1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NrVojsCqtmYBo8sjm0hcfH3BQr5gJoNEtdq67m9YxaZDlnRaejpc+7zCiQ4MPYWaC/
         VhQX8VGb4TAY9CIDZ/06okOlLuTCMo7E5crV7u/qwTxLu3XFLhQmMeOB6DidRBheovJx
         QwHtGXHgRSChCJU6GPHQG5JQudKrvzpqgfKdY=
Received: by 10.236.156.67 with SMTP id l43mr298905yhk.36.1302834780509;
        Thu, 14 Apr 2011 19:33:00 -0700 (PDT)
Received: from elie (adsl-69-209-64-230.dsl.chcgil.sbcglobal.net [69.209.64.230])
        by mx.google.com with ESMTPS id f28sm1082567yhc.44.2011.04.14.19.32.58
        (version=SSLv3 cipher=OTHER);
        Thu, 14 Apr 2011 19:32:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110415021100.GA19829@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171580>

These hints are in git's private SubmittingPatches document but a
wider audience might be interested.  Move them to the "git
format-patch" manpage.

I'm not sure what gotchas these hints are meant to work around.
They might be completely false.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
A quick search for "how to send patches with KMail" gave me the
"external editor" trick.  Do these instructions work? ;-)

Anyway, this patch reuses the current instructions from
SubmittingPatches as-is.

 Documentation/SubmittingPatches    |   22 ++--------------------
 Documentation/git-format-patch.txt |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 7908119..e9d8c3f 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -413,8 +413,8 @@ that or Gentoo did it.) So you need to set the
 it.
 
 
-Thunderbird
------------
+Thunderbird, KMail
+------------------
 
 See the MUA-SPECIFIC HINTS section of git-format-patch(1).
 
@@ -433,24 +433,6 @@ message in raw form before using '|' to run the pipe can work
 this problem around.
 
 
-KMail
------
-
-This should help you to submit patches inline using KMail.
-
-1) Prepare the patch as a text file.
-
-2) Click on New Mail.
-
-3) Go under "Options" in the Composer window and be sure that
-"Word wrap" is not set.
-
-4) Use Message -> Insert file... and insert the patch.
-
-5) Back in the compose window: add whatever other text you wish to the
-message, complete the addressing and subject fields, and press send.
-
-
 Gmail
 -----
 
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index cbf2b9c..8887375 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -415,6 +415,22 @@ There is a script in contrib/thunderbird-patch-inline which can help
 you include patches with Thunderbird in an easy way. To use it, do the
 steps above and then use the script as the external editor.
 
+KMail
+~~~~~
+This should help you to submit patches inline using KMail.
+
+1. Prepare the patch as a text file.
+
+2. Click on New Mail.
+
+3. Go under "Options" in the Composer window and be sure that
+   "Word wrap" is not set.
+
+4. Use Message -> Insert file... and insert the patch.
+
+5. Back in the compose window: add whatever other text you wish to the
+   message, complete the addressing and subject fields, and press send.
+
 
 EXAMPLES
 --------
-- 
1.7.5.rc0
