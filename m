From: william pursell <bill.pursell@gmail.com>
Subject: [PATCH] Correct tenses in documentation.
Date: Sat, 09 Jun 2007 16:44:12 +0100
Message-ID: <466ACACC.3070801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 17:35:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx2yE-0004Ns-KZ
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 17:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbXFIPfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 11:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752929AbXFIPfE
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 11:35:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:23219 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbXFIPfD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 11:35:03 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1160785ugf
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 08:35:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=nSC+1Z5txofTKRvA0wTQ69tnUNCxNKl/uzbHoYf1B58uRLbHRVAJwTzBE4Wj1hlKLz4Qz4L2ON7xXAcvUdHEg7CqMPTOtnkTBp2dEU0KzI1oeJjB5+N/x+eAnH3QmoSZUUX/dLTQiu4ZqgyONERqpDQ/RG1z3dqVnduJYERPo4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=dvPwJ+eDYLJiZ3uyfxv/NzaVFT1y3ZYqbNXoDFUQlbD3nWuo9wY8SbfLdSopACVAvfDgpLjqEk3enGNPy0yaAlRXnnhDcnD4oIrj//ICZHWjTPuv7zNU25LRPe7Mzk6UkCDs2AnBRCVbW5/q57EzvQ/Oy7a7SyRGzrteAhzNmxE=
Received: by 10.82.134.12 with SMTP id h12mr7319524bud.1181403302070;
        Sat, 09 Jun 2007 08:35:02 -0700 (PDT)
Received: from ?192.168.1.103? ( [82.17.45.135])
        by mx.google.com with ESMTP id k9sm12819088nfh.2007.06.09.08.35.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Jun 2007 08:35:01 -0700 (PDT)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49577>

In several of the text messages, the tense of the verb
is inconsistent.  For example, "Add" vs "Creates".  This
patch to the .txt files makes all of the verbs for
the summaries be present tense.  eg, "Creates" becomes
"Create".
---
  Documentation/git-archive.txt |    2 +-
  Documentation/git-clone.txt   |    2 +-
  Documentation/git-prune.txt   |    2 +-
  3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 721e035..4da07c1 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -3,7 +3,7 @@ git-archive(1)

  NAME
  ----
-git-archive - Creates an archive of files from a named tree
+git-archive - Create an archive of files from a named tree


  SYNOPSIS
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 2461c0e..4a5bab5 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -3,7 +3,7 @@ git-clone(1)

  NAME
  ----
-git-clone - Clones a repository into a new directory
+git-clone - Clone a repository into a new directory


  SYNOPSIS
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 50ee5bd..0ace233 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -3,7 +3,7 @@ git-prune(1)

  NAME
  ----
-git-prune - Prunes all unreachable objects from the object database
+git-prune - Prune all unreachable objects from the object database


  SYNOPSIS
--
1.4.4.4
