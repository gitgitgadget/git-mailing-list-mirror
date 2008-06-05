From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] git-for-each-ref.txt: fix description of <pattern>
Date: Thu,  5 Jun 2008 13:19:12 +0200
Message-ID: <1212664752-12160-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 13:20:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4DVq-0007hC-88
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 13:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbYFELTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 07:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754237AbYFELTR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 07:19:17 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:34932 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbYFELTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 07:19:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so335122fgg.17
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 04:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:from;
        bh=0Elf/SxoNmGMc+oQP/5xeIys6yqCckDEUM83SxzK9qA=;
        b=VmqQdm6XogQUtkF89KBCqgrItO20AiZNDM/zBx60cwaIrCIp+QTQdm8JUhWvMO0KDK
         FJdsAb3/fgF+ih/Rez20cCzyR4xtMYSSUCIesqfx5NdHYMfrwKkupl7vOqKSnrC8NQz8
         4DK1puTwJ17EEFPNF5/XDSxL61fOLKbVibeFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=gY09+Dc3/qzcyjIQ76RonOApiM1vCFApkKsTUpH6NTTjl22MPfix2n/GLjMd53eo8R
         B+WuOZQ1MEf7uMdgQr6Ow3Dj4tK17YKporZmnZlUWIscGGYtOwGDoiK6cjxctAz1OlF5
         k3MU1V5IcRmXscen13JUn3/+y7Ng0J2wQXm0E=
Received: by 10.86.73.3 with SMTP id v3mr1852166fga.68.1212664755284;
        Thu, 05 Jun 2008 04:19:15 -0700 (PDT)
Received: from fly ( [91.33.197.196])
        by mx.google.com with ESMTPS id l19sm3438976fgb.7.2008.06.05.04.19.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Jun 2008 04:19:14 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K4DUu-0003AU-Le; Thu, 05 Jun 2008 13:19:12 +0200
X-Mailer: git-send-email 1.5.6.rc1.9.g69bbf.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83904>

git-for-each-ref supports not only glob patterns but also prefixes
like "refs/heads" as patterns.  This documents it.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
 Documentation/git-for-each-ref.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f1f90cc..a9633c6 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -48,9 +48,9 @@ OPTIONS
 	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
 
 <pattern>::
-	If given, the name of the ref is matched against this
-	using fnmatch(3).  Refs that do not match the pattern
-	are not shown.
+	If given, only refs are shown that match againt the pattern
+	either using fnmatch(3) or literally, in the latter case up to
+	a slash or entirely.
 
 --shell, --perl, --python, --tcl::
 	If given, strings that substitute `%(fieldname)`
-- 
1.5.6.rc1.9.g69bbf.dirty
