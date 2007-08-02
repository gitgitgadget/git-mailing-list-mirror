From: "David Symonds" <dsymonds@gmail.com>
Subject: [PATCH] Fix documentation for core.gitproxy to reflect code
Date: Thu, 2 Aug 2007 22:23:34 +1000
Message-ID: <ee77f5c20708020523m1a243bf2g9778994441cd21d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 14:23:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGZiM-0006oz-Tk
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 14:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbXHBMXg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 08:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754785AbXHBMXf
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 08:23:35 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:61209 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263AbXHBMXe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 08:23:34 -0400
Received: by rv-out-0910.google.com with SMTP id k20so401344rvb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 05:23:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hrl33iQUz1BbgV0LejOzA+2T5Gf82jJ1QgW+NQLDLOgU5cPtPMjWR5UVQKVDR6O9zh2e8If6EU5U/81QdS5qB5CB3wrE7K9E+nuooBqBCgxF2dzAHbG4iuiaJ/ULRRvJ1Bg5NAyzgMKz7hkOshkt5qb6ZSRRG5PCqIo3Qo/9UyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Twvo9/eTTy315L+DLZ/9ICnrz9dY8uwC1F4PESsBRZUEkfVIgDrgFqXKmEO8PDScZXMZHMtVmN/yAb3g2E+2F65QlPnsGVuLeyhdyEFL1x+UFwOQWhuRaaQuTS1apUm+P0aJPrRMIyBDfH4Pb7rRUREwa0r4FOyH+B1gAW9mhV8=
Received: by 10.141.113.6 with SMTP id q6mr644356rvm.1186057414553;
        Thu, 02 Aug 2007 05:23:34 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Thu, 2 Aug 2007 05:23:34 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54546>

This is with respect to my earlier email about core.gitproxy. I
figured since 1.5.3 is looming it would be best to get the
documentation correct, then nag about the feature later!

Dave.

---
 Documentation/config.txt     |    2 +-
 Documentation/git-config.txt |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3135cb7..de9e72b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -101,7 +101,7 @@ Example

 	# Proxy settings
 	[core]
-		gitProxy="ssh" for "ssh://kernel.org/"
+		gitProxy="ssh" for "kernel.org"
 		gitProxy=default-proxy ; for the rest

 Variables
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 8451ccc..c3dffff 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -214,9 +214,7 @@ Given a .git/config like this:

 	; Proxy settings
 	[core]
-		gitproxy="ssh" for "ssh://kernel.org/"
 		gitproxy="proxy-command" for kernel.org
-		gitproxy="myprotocol-command" for "my://"
 		gitproxy=default-proxy ; for all the rest

 you can set the filemode to true with
@@ -291,7 +289,7 @@ To actually match only values with an exclamation
mark, you have to
 To add a new proxy, without altering any of the existing ones, use

 ------------
-% git config core.gitproxy '"proxy" for example.com'
+% git config core.gitproxy '"proxy-command" for example.com'
 ------------


-- 
1.5.2.4
