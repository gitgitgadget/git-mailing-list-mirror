From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] documentation: update the "Pushing changes to a public 
	repository" section
Date: Fri, 19 Feb 2010 17:45:09 +0100
Message-ID: <4df72b1a1002190845o2cbde92btb8804e2467ffda51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 17:58:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiWBR-0007km-Is
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 17:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670Ab0BSQ6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 11:58:23 -0500
Received: from mail-fx0-f171.google.com ([209.85.220.171]:65058 "EHLO
	mail-fx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480Ab0BSQ6W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 11:58:22 -0500
X-Greylist: delayed 791 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Feb 2010 11:58:22 EST
Received: by fxm19 with SMTP id 19so82313fxm.1
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 08:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=FuHeX9Huqa8WYuPCGzO8J1OT7e3tDzQZUDIeB6ZDqUQ=;
        b=c5gFEkndR0jCIcfJm0qaxTHcalu24UCFihsRVsnujYAPzb8Zt2TrGUGhIPtEJnr/Rq
         SKwSRiHB2KdUlI2K7q3EAyuSRz0OtidhTyB+tIwMdZ27nXAUSqGL4iQd/zLuMfuem0Xq
         OlIeaxLoDqFk3l0jBC7sGO1MyxaM/5ctCCiE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=owHIzaDYcY9z36I/8Ws1Ydh7shDe/ZUJ0RZ7kUXE436Q0vf+9sj4+312ouWbTQ5vXn
         GJx124TQERiz7rHLz+c88LtNMIkF5WAUauwIP19yWM8Q9U2g7X/WRx9Ev9AbJsb/MFsE
         dR96LQGi4vjI98qcBYiFQwcWIO++3QQ1BjbFw=
Received: by 10.103.84.15 with SMTP id m15mr4995313mul.43.1266597909510; Fri, 
	19 Feb 2010 08:45:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140466>

Extracted from git v1.7.0 Release Notes:

* "git push" into a branch that is currently checked out (i.e. pointed at by
   HEAD in a repository that is not bare) is refused by default.

Update the user manual where necessary
---
 Documentation/user-manual.txt |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index fe6fb72..0897839 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1963,10 +1963,14 @@ As with `git fetch`, `git push` will complain
if this does not result in a
 handling this case.

 Note that the target of a "push" is normally a
-<<def_bare_repository,bare>> repository.  You can also push to a
-repository that has a checked-out working tree, but the working tree
-will not be updated by the push.  This may lead to unexpected results if
-the branch you push to is the currently checked-out branch!
+<<def_bare_repository,bare>> repository.  Until the version 1.7 you could
+also push to a repository that has a checked-out working tree,
+but the working tree will not be updated by the push.  This might lead to
+unexpected results if the branch you pushed to was the currently checked-out
+branch! From 1.7.0 git push" into a branch that is currently checked out
+(i.e. pointed at by   HEAD in a repository that is not bare)
+is refused by default.
+

 As with `git fetch`, you may also set up configuration options to
 save typing; so, for example, after
--
1.6.6
