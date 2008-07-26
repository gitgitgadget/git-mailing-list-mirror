From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: More about how gitweb gets 'owner' of repository
Date: Sun, 27 Jul 2008 01:23:46 +0200
Message-ID: <20080726232316.23589.62384.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 27 01:28:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMtBG-0001Py-VO
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 01:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbYGZXXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 19:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753207AbYGZXXt
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 19:23:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:25232 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbYGZXXs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 19:23:48 -0400
Received: by ug-out-1314.google.com with SMTP id h2so83298ugf.16
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 16:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=f//QZ9jqcm6z+lkZ8tUvf7ZsP7OjVBB9tALLsvPd8+M=;
        b=u4izmaX+epaJddJ/+emQvsgYtANJeBU1aZgEAAnkbKboa4cc/mfHvT4rJNKWz1R7mb
         cCgP2/XePgby6OS74rrOVtGecgVW4IFBMIrpvyPHaKT2ekW0izpluTOn9xRxI309CB+Q
         j66/umMCS9NbFFf3zI5dguYevxNnxFB/468lU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=kLpkLvdmb6pZDZDfdAN0Tkzt/yrPQ5InBVa4cYgFx6R3RgMHHMjXrEayd7uubHIJ4U
         31TdtCYOaErBEZcHf2McnaXc7T4SqKnavxH4l21XVyDdmJ97lhH5unUB0uva4iUpE9Hr
         4cHKQqJRpafKj4awxUiuGufH6pq1tA51WZd3k=
Received: by 10.67.115.5 with SMTP id s5mr1052141ugm.63.1217114627195;
        Sat, 26 Jul 2008 16:23:47 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.240.214])
        by mx.google.com with ESMTPS id h1sm974945ugf.22.2008.07.26.16.23.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 16:23:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6QNNkBX023622
	for <git@vger.kernel.org>; Sun, 27 Jul 2008 01:23:47 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90292>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Just an improvement in gitweb documentation...

 gitweb/README |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 6908036..825162a 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -277,7 +277,8 @@ You can use the following files in repository:
  * gitweb.owner
    You can use the gitweb.owner repository configuration variable to set
    repository's owner. It is displayed in the project list and summary
-   page. If it's not set, filesystem directory's owner is used.
+   page. If it's not set, filesystem directory's owner is used
+   (via GECOS field / real name field from getpwiud(3)).
  * various gitweb.* config variables (in config)
    Read description of %feature hash for detailed list, and some
    descriptions.
