From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 05/51] i18n: git-am echo + gettext message
Date: Sun,  3 Apr 2011 16:45:29 +0000
Message-ID: <1301849175-1697-6-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:49:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QUc-0005ya-73
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373Ab1DCQtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 12:49:00 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33259 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756Ab1DCQqf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:35 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505908ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ocdroLj8DQZA09LAfEWN8y4wT5JFQWnYilzQ4HkCIr0=;
        b=GdnubIKOfvmJm6Z5q28B5QIjmr7X+PaKvEz739Mv4uwuTc16LRiyWLUigsi/uDOVVM
         u0XXfesBp7vI4XIbeLgxRfSqen3Qe89vy9UBwIhpbXFPS8yMsIIVbN8i1BB/jzdhJQVw
         +347s+rKKpyHuN5iIjvozCNuna5b/O9EP35Uo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=C0at7eizBCeXq3/fwB4QZ76ISEfy9/PJU0it+OrEqdsp6EN97xyivj2kEV7RJsihup
         sSAsthX8ecYjCNKz/rqjMKJMSw8PtjwJuAaEctC3y1Eu0Vx32lip2g8H201Bl+R/tD7L
         HwV45zzedi4U89dUEFEUwXSp+nmD0TX9xHH9I=
Received: by 10.14.123.143 with SMTP id v15mr2890155eeh.218.1301849195224;
        Sun, 03 Apr 2011 09:46:35 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.34
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170757>

---
 git-am.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 7c0273c..688f689 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -89,8 +89,8 @@ safe_to_abort () {
 	then
 		return 0
 	fi
-	echo >&2 "You seem to have moved HEAD since the last 'am' failure."
-	echo >&2 "Not rewinding to ORIG_HEAD"
+	echo >&2 "$(gettext "You seem to have moved HEAD since the last 'am' failure.
+Not rewinding to ORIG_HEAD")"
 	return 1
 }
 
-- 
1.7.4.1
