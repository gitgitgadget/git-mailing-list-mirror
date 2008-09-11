From: "Eric Raible" <raible@gmail.com>
Subject: [PATCH] completion: git commit should list --interactive
Date: Wed, 10 Sep 2008 17:40:20 -0700
Message-ID: <279b37b20809101740v4a8f19b8k395208c124af0de0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: spearce@spearce.org, "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 02:41:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdaFi-0001fu-Kz
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 02:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbYIKAkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 20:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbYIKAkX
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 20:40:23 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:32788 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbYIKAkV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 20:40:21 -0400
Received: by gxk9 with SMTP id 9so15265337gxk.13
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 17:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=bvQXj7Y0xw1TrL6at8CgkIyvmxrSsl0qJ4NeFfk+sMM=;
        b=hofOa4koWvIL4JtLGe7NnzuhsFJJkCHHzQaKfW2hlnIXJBz8c0VR1iMbmYY9Oj77S9
         ZLDqCL4YWd1Z/Zs1AlfKT5ZGcVussPucR5YGLTRAJvQOCcBGK1zoH9PPp3CFolWwIhVF
         yg07tQ6MF9TBWW39fH/MhK0R7mG0vCnpcfsWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=O2mq+JRn/CKL8IfigBiG2JN8+NTpaDFxDEFGpZZGju1mcthYloGfKVbpKCVArcXK+X
         fflWO4QHmhaIcv5vC0sEY5BFVPfafw76sJM9mhTvydMH3r4Kuq/ZsqBOo5jDkHkZUjvj
         i5G25wBCw0sY34YFYsZLQ1wf3iXqxQOfDoXhE=
Received: by 10.142.132.2 with SMTP id f2mr707612wfd.22.1221093620164;
        Wed, 10 Sep 2008 17:40:20 -0700 (PDT)
Received: by 10.142.177.12 with HTTP; Wed, 10 Sep 2008 17:40:20 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95571>

Signed-off-by: Eric Raible <raible@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index d3fb6ae..2d8d1c3 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -750,7 +750,7 @@ _git_commit ()
 	--*)
 		__gitcomp "
 			--all --author= --signoff --verify --no-verify
-			--edit --amend --include --only
+			--edit --amend --include --only --interactive
 			"
 		return
 	esac
-- 
1.6.0.1.436.g09e16c.dirty
